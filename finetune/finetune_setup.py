#!/usr/bin/env python3
"""
COMSOL Fine-Tuning Setup using Unsloth
Optimized for domain-specific COMSOL MATLAB code generation
"""

import os
import json
import glob
import argparse
from pathlib import Path
import torch
from datasets import Dataset
from transformers import TrainingArguments
import re

# Set environment variables to avoid warnings
os.environ["TOKENIZERS_PARALLELISM"] = "false"
os.environ["WANDB_DISABLED"] = "true"

# Import unsloth first for optimizations
try:
    from unsloth import FastLanguageModel
    UNSLOTH_AVAILABLE = True
except ImportError:
    print("Warning: Unsloth not available, falling back to standard training")
    UNSLOTH_AVAILABLE = False

def install_requirements():
    """Install required packages if not present"""
    import subprocess
    import sys
    
    required_packages = [
        "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git",
        "xformers",
        "trl<0.9.0",
        "accelerate",
        "bitsandbytes",
    ]
    
    for package in required_packages:
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", package])
        except subprocess.CalledProcessError as e:
            print(f"Warning: Failed to install {package}: {e}")

def load_jsonl_data(data_dir, max_samples=None):
    """Load and prepare COMSOL training data from JSONL files"""
    
    jsonl_files = glob.glob(os.path.join(data_dir, "*.jsonl"))
    if not jsonl_files:
        raise ValueError(f"No JSONL files found in {data_dir}")
    
    print(f"Found {len(jsonl_files)} JSONL files")
    
    all_data = []
    for file_path in jsonl_files:
        print(f"Loading: {file_path}")
        with open(file_path, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f):
                try:
                    data = json.loads(line.strip())
                    
                    # Validate required fields
                    if all(field in data for field in ['instruction', 'input', 'output']):
                        all_data.append({
                            'instruction': data['instruction'],
                            'input': data['input'], 
                            'output': data['output'],
                            'explanation': data.get('explanation', ''),
                            'confidence': data.get('confidence', 0.5),
                            'category': data.get('category', 'unknown'),
                            'physics': extract_physics_from_explanation(data.get('explanation', ''))
                        })
                        
                        if max_samples and len(all_data) >= max_samples:
                            break
                            
                except json.JSONDecodeError as e:
                    print(f"Warning: Skipping invalid JSON at line {line_num+1} in {file_path}: {e}")
                    continue
                    
        if max_samples and len(all_data) >= max_samples:
            break
    
    print(f"Loaded {len(all_data)} training examples")
    return all_data

def extract_physics_from_explanation(explanation):
    """Extract physics information from explanation field"""
    if not explanation:
        return "Unknown"
    
    # Look for "Physics: ..." pattern
    match = re.search(r'Physics:\s*([^.]+)', explanation)
    if match:
        return match.group(1).strip()
    return "Unknown"

def format_chat_template(example):
    """Format training examples using a simpler format for SFTTrainer"""
    
    # Create a simpler prompt format that works better with SFTTrainer
    prompt = f"""### Task: {example['instruction']}

### Context: {example['input']}

### COMSOL MATLAB Code:
{example['output']}"""

    return {"text": prompt}

def analyze_dataset(data):
    """Analyze the dataset composition"""
    print("\n=== Dataset Analysis ===")
    
    # Category distribution
    categories = {}
    physics_domains = {}
    confidence_levels = {"high": 0, "medium": 0, "low": 0}
    
    for example in data:
        # Categories
        cat = example.get('category', 'unknown')
        categories[cat] = categories.get(cat, 0) + 1
        
        # Physics domains
        physics = example.get('physics', 'Unknown')
        physics_domains[physics] = physics_domains.get(physics, 0) + 1
        
        # Confidence levels
        conf = example.get('confidence', 0.5)
        if conf >= 0.8:
            confidence_levels["high"] += 1
        elif conf >= 0.5:
            confidence_levels["medium"] += 1
        else:
            confidence_levels["low"] += 1
    
    print(f"Total examples: {len(data)}")
    print(f"\nCategories: {dict(sorted(categories.items(), key=lambda x: x[1], reverse=True))}")
    print(f"\nPhysics domains: {dict(sorted(physics_domains.items(), key=lambda x: x[1], reverse=True))}")
    print(f"\nConfidence levels: {confidence_levels}")
    
    # Code length analysis
    code_lengths = [len(example['output']) for example in data]
    print(f"\nCode length stats:")
    print(f"  Min: {min(code_lengths)} chars")
    print(f"  Max: {max(code_lengths)} chars") 
    print(f"  Avg: {sum(code_lengths)/len(code_lengths):.1f} chars")

def setup_model_and_tokenizer(model_name="unsloth/codellama-34b-bnb-4bit", available_gpus=None):
    """Setup model and tokenizer with Unsloth optimizations"""
    
    print(f"Loading model: {model_name}")
    
    # Determine max sequence length based on model size
    if "70b" in model_name.lower():
        max_seq_length = 2048  # Conservative for 70B
    elif "34b" in model_name.lower() or "32b" in model_name.lower():
        max_seq_length = 4096  # More generous for 34B
    else:
        max_seq_length = 4096  # Default for smaller models
    
    # Set device mapping for multi-GPU if available
    device_map = None
    if available_gpus and len(available_gpus) > 1:
        device_map = "auto"
        os.environ["CUDA_VISIBLE_DEVICES"] = ",".join(map(str, available_gpus))
        print(f"Using GPUs: {available_gpus}")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=model_name,
        max_seq_length=max_seq_length,
        dtype=None,  # Auto-detect (bf16 for H100)
        load_in_4bit=False,  # Use full precision on H100s
        device_map=device_map,
    )
    
    # Setup LoRA with parameters optimized for larger models
    if "70b" in model_name.lower():
        # Conservative settings for 70B
        lora_rank = 32
        lora_alpha = 32
        target_modules = ["q_proj", "k_proj", "v_proj", "o_proj"]
    elif "34b" in model_name.lower() or "32b" in model_name.lower():
        # Balanced settings for 30B+
        lora_rank = 64
        lora_alpha = 64
        target_modules = ["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"]
    else:
        # Full settings for smaller models
        lora_rank = 128
        lora_alpha = 128
        target_modules = ["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"]
    
    model = FastLanguageModel.get_peft_model(
        model,
        r=lora_rank,
        target_modules=target_modules,
        lora_alpha=lora_alpha,
        lora_dropout=0.05,  # Lower dropout for H100s
        bias="none",
        use_gradient_checkpointing="unsloth",
        random_state=3407,
        use_rslora=False,
        loftq_config=None,
    )
    
    return model, tokenizer

def prepare_dataset(train_data, tokenizer):
    """Prepare and tokenize dataset for training"""
    
    # Format data using chat template
    formatted_data = [format_chat_template(example) for example in train_data]
    dataset = Dataset.from_list(formatted_data)
    
    def tokenize_function(examples):
        return tokenizer(
            examples["text"],
            truncation=True,
            padding=False,  # Will be handled by data collator
            max_length=2048,
            return_overflowing_tokens=False,
        )
    
    tokenized_dataset = dataset.map(tokenize_function, batched=True)
    return tokenized_dataset

def create_training_config(output_dir, num_train_samples):
    """Create optimized training configuration"""
    
    # Calculate training steps based on dataset size
    batch_size = 4  # Adjust based on your GPU memory
    gradient_accumulation_steps = 4
    effective_batch_size = batch_size * gradient_accumulation_steps
    
    # Aim for 3-5 epochs typically
    num_epochs = 3
    total_steps = (num_train_samples * num_epochs) // effective_batch_size
    
    return TrainingArguments(
        output_dir=output_dir,
        per_device_train_batch_size=batch_size,
        gradient_accumulation_steps=gradient_accumulation_steps,
        warmup_steps=min(100, total_steps // 10),  # 10% warmup
        max_steps=total_steps,
        num_train_epochs=num_epochs,
        learning_rate=2e-4,  # Good starting point for LoRA
        fp16=not torch.cuda.is_bf16_supported(),
        bf16=torch.cuda.is_bf16_supported(),
        logging_steps=20,
        optim="adamw_8bit",  # Memory efficient optimizer
        weight_decay=0.01,
        lr_scheduler_type="cosine",
        save_steps=max(50, total_steps // 20),  # Save 20 checkpoints
        save_strategy="steps",
        evaluation_strategy="no",  # Disable eval for faster training
        report_to=None,  # Disable wandb/tensorboard for now
        dataloader_pin_memory=False,
        remove_unused_columns=False,
    )

def main():
    parser = argparse.ArgumentParser(description="Fine-tune model on COMSOL data")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing JSONL training files")
    parser.add_argument("--output_dir", type=str, default="./comsol_finetuned_model",
                       help="Output directory for the fine-tuned model")
    parser.add_argument("--model_name", type=str, default="unsloth/codellama-34b-bnb-4bit",
                       help="Base model to fine-tune")
    parser.add_argument("--max_samples", type=int, default=None,
                       help="Maximum number of samples to use (for testing)")
    parser.add_argument("--gpus", type=str, default="4,5,6,7",
                       help="Comma-separated list of GPU IDs to use (default: 4,5,6,7)")
    parser.add_argument("--epochs", type=int, default=1,
                       help="Number of training epochs (default: 1 for large models)")
    parser.add_argument("--install_deps", action="store_true",
                       help="Install required dependencies")
    
    args = parser.parse_args()
    
    if args.install_deps:
        print("Installing dependencies...")
        install_requirements()
    
    # Parse GPU list
    available_gpus = [int(gpu.strip()) for gpu in args.gpus.split(",") if gpu.strip()]
    print(f"Available GPUs: {available_gpus}")
    
    # Validate output directory
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    try:
        # Load and analyze data
        print("Loading training data...")
        train_data = load_jsonl_data(args.data_dir, args.max_samples)
        analyze_dataset(train_data)
        
        if len(train_data) == 0:
            print("No training data found!")
            return
        
        print(f"Training on {len(train_data)} examples")
        
        # Setup model and tokenizer
        print("Setting up model and tokenizer...")
        model, tokenizer = setup_model_and_tokenizer(args.model_name, available_gpus)
        
        # Fix tokenizer configuration
        if tokenizer.pad_token is None:
            tokenizer.pad_token = tokenizer.eos_token
            tokenizer.pad_token_id = tokenizer.eos_token_id
        
        # Ensure the model can handle the pad token
        if tokenizer.pad_token_id != tokenizer.eos_token_id:
            model.resize_token_embeddings(len(tokenizer))
        
        # Prepare dataset
        print("Preparing dataset...")
        # Don't tokenize manually - let SFTTrainer handle it
        formatted_data = [format_chat_template(example) for example in train_data]
        train_dataset = Dataset.from_list(formatted_data)
        
        # Training arguments optimized for H100s and larger models
        batch_size = 1 if "70b" in args.model_name.lower() else 2
        gradient_accumulation_steps = 8 if "70b" in args.model_name.lower() else 4
        learning_rate = 1e-4 if "70b" in args.model_name.lower() else 2e-4
        
        training_args = TrainingArguments(
            per_device_train_batch_size=batch_size,
            gradient_accumulation_steps=gradient_accumulation_steps,
            warmup_steps=min(100, len(train_dataset) // 10),
            num_train_epochs=args.epochs,
            learning_rate=learning_rate,
            fp16=False,  # Use bf16 on H100
            bf16=True,   # Better for H100s
            logging_steps=10,
            optim="adamw_8bit",
            weight_decay=0.01,
            lr_scheduler_type="cosine",
            seed=3407,
            output_dir=output_dir,
            save_steps=min(500, len(train_dataset) // 4),
            save_total_limit=3,
            dataloader_num_workers=0,  # Set to 0 to avoid multiprocessing issues
            remove_unused_columns=False,
            report_to=None,  # Disable wandb for now
        )
        
        # Initialize trainer
        from trl import SFTTrainer
        
        trainer = SFTTrainer(
            model=model,
            train_dataset=train_dataset,
            dataset_text_field="text",
            max_seq_length=2048,
            tokenizer=tokenizer,
            args=training_args,
            packing=False,  # Don't pack sequences to avoid issues
        )
        
        print(f"Starting training with {len(train_data)} examples...")
        print(f"Effective batch size: {training_args.per_device_train_batch_size * training_args.gradient_accumulation_steps}")
        
        # Start training
        trainer.train()
        
        # Save the final model
        print(f"Saving model to {args.output_dir}")
        trainer.save_model()
        tokenizer.save_pretrained(args.output_dir)
        
        # Save metadata
        metadata = {
            "base_model": args.model_name,
            "training_examples": len(train_data),
            "physics_domains": list(set(ex.get('physics', 'Unknown') for ex in train_data)),
            "categories": list(set(ex.get('category', 'unknown') for ex in train_data)),
            "training_config": training_args.to_dict()
        }
        
        with open(os.path.join(args.output_dir, "training_metadata.json"), 'w') as f:
            json.dump(metadata, f, indent=2)
        
        print("✅ Fine-tuning completed!")
        print(f"Model saved to: {args.output_dir}")
        
        # Quick inference test
        print("\n=== Quick Test ===")
        FastLanguageModel.for_inference(model)
        
        test_prompt = """<|im_start|>system
You are a COMSOL Multiphysics expert that generates MATLAB code for simulation setup.<|im_end|>
<|im_start|>user
Task: Create a new COMSOL model for electrostatics simulation

Context: Model Context: Setting up a basic electrostatics simulation
Physics: Electrostatics
Step Purpose: Initialize the simulation environment
What to do: Create a new COMSOL model for electrostatics simulation

Generate the COMSOL MATLAB code:<|im_end|>
<|im_start|>assistant
"""
        
        inputs = tokenizer(test_prompt, return_tensors="pt").to(model.device)
        with torch.no_grad():
            outputs = model.generate(**inputs, max_new_tokens=100, temperature=0.1, do_sample=True)
        
        result = tokenizer.decode(outputs[0], skip_special_tokens=True)
        print("Test generation:")
        print(result.split("<|im_start|>assistant\n")[-1])
    except Exception as e:
        print(f"Error during training: {e}")

if __name__ == "__main__":
    main() 