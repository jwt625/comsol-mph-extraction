#!/usr/bin/env python3
"""
COMSOL Fine-Tuning Setup - Fixed Version
Uses a more robust approach to avoid tokenization issues
"""

import os
import json
import glob
import argparse
from pathlib import Path
import torch
from torch.nn.utils.rnn import pad_sequence
from datasets import Dataset
from transformers import TrainingArguments, Trainer
from transformers.data.data_collator import DataCollatorMixin
from transformers.tokenization_utils_base import PreTrainedTokenizerBase
from typing import Dict, List, Any
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

class COMSOLDataCollator(DataCollatorMixin):
    """
    Custom data collator for COMSOL training that handles variable length sequences properly
    """
    
    def __init__(self, tokenizer: PreTrainedTokenizerBase, max_length: int = 2048):
        self.tokenizer = tokenizer
        self.max_length = max_length
        self.pad_token_id = tokenizer.pad_token_id
        if self.pad_token_id is None:
            self.pad_token_id = tokenizer.eos_token_id
    
    def __call__(self, features: List[Dict[str, Any]]) -> Dict[str, torch.Tensor]:
        # Extract the text and tokenize on the fly
        texts = [feature["text"] for feature in features]
        
        # Tokenize all texts
        batch_encoding = self.tokenizer(
            texts,
            truncation=True,
            padding=True,
            max_length=self.max_length,
            return_tensors="pt"
        )
        
        # For causal LM, labels = input_ids
        batch_encoding["labels"] = batch_encoding["input_ids"].clone()
        
        # Replace padding token ids in labels with -100 so they're ignored in loss
        batch_encoding["labels"][batch_encoding["labels"] == self.pad_token_id] = -100
        
        return batch_encoding

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

def format_training_text(example):
    """Format training examples as plain text for tokenization"""
    
    prompt = f"""### Task: {example['instruction']}

### Context: {example['input']}

### COMSOL MATLAB Code:
{example['output']}"""

    return prompt

def prepare_dataset(train_data):
    """Prepare dataset without tokenization - let data collator handle it"""
    
    # Format all examples but don't tokenize
    formatted_data = []
    for example in train_data:
        text = format_training_text(example)
        formatted_data.append({
            "text": text,
            "length": len(text)  # For analysis purposes
        })
    
    # Create dataset
    dataset = Dataset.from_list(formatted_data)
    
    print(f"Dataset prepared with {len(dataset)} examples")
    print(f"Average text length: {sum(item['length'] for item in formatted_data) / len(formatted_data):.1f} characters")
    
    return dataset

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
    elif available_gpus:
        # Single GPU setup
        os.environ["CUDA_VISIBLE_DEVICES"] = str(available_gpus[0])
        print(f"Using single GPU: {available_gpus[0]}")
    
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=model_name,
        max_seq_length=max_seq_length,
        dtype=None,  # Auto-detect (bf16 for H100)
        load_in_4bit=False,  # Use full precision on H100s
        device_map=device_map,
    )
    
    # Fix tokenizer configuration - use eos_token as pad_token without resizing
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token
        tokenizer.pad_token_id = tokenizer.eos_token_id
    
    # Ensure padding is on the right side for causal LM
    tokenizer.padding_side = "right"
    
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
        lora_dropout=0.05,
        bias="none",
        use_gradient_checkpointing="unsloth",
        random_state=3407,
        use_rslora=False,
        loftq_config=None,
    )
    
    return model, tokenizer

def main():
    parser = argparse.ArgumentParser(description="Fine-tune model on COMSOL data (Fixed Version)")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing JSONL training files")
    parser.add_argument("--output_dir", type=str, default="./comsol_finetuned_model_fixed",
                       help="Output directory for the fine-tuned model")
    parser.add_argument("--model_name", type=str, default="unsloth/codellama-34b-bnb-4bit",
                       help="Base model to fine-tune")
    parser.add_argument("--max_samples", type=int, default=None,
                       help="Maximum number of samples to use (for testing)")
    parser.add_argument("--gpus", type=str, default="4,5,6,7",
                       help="Comma-separated list of GPU IDs to use (default: 4,5,6,7)")
    parser.add_argument("--epochs", type=int, default=1,
                       help="Number of training epochs (default: 1 for large models)")
    
    args = parser.parse_args()
    
    # Parse GPU list
    available_gpus = [int(gpu.strip()) for gpu in args.gpus.split(",") if gpu.strip()]
    print(f"Available GPUs: {available_gpus}")
    
    # Validate output directory
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    try:
        # Load data
        print("Loading training data...")
        train_data = load_jsonl_data(args.data_dir, args.max_samples)
        
        if len(train_data) == 0:
            print("No training data found!")
            return
        
        print(f"Training on {len(train_data)} examples")
        
        # Setup model and tokenizer
        print("Setting up model and tokenizer...")
        model, tokenizer = setup_model_and_tokenizer(args.model_name, available_gpus)
        
        # Prepare dataset
        print("Preparing dataset...")
        dataset = prepare_dataset(train_data)
        
        # Training arguments
        batch_size = 1 if "70b" in args.model_name.lower() else 2
        gradient_accumulation_steps = 8 if "70b" in args.model_name.lower() else 4
        learning_rate = 1e-4 if "70b" in args.model_name.lower() else 2e-4
        
        training_args = TrainingArguments(
            output_dir=output_dir,
            per_device_train_batch_size=batch_size,
            gradient_accumulation_steps=gradient_accumulation_steps,
            warmup_steps=min(100, len(dataset) // 10),
            num_train_epochs=args.epochs,
            learning_rate=learning_rate,
            fp16=False,  # Use bf16 on H100
            bf16=True,   # Better for H100s
            logging_steps=10,
            optim="adamw_8bit",
            weight_decay=0.01,
            lr_scheduler_type="cosine",
            seed=3407,
            save_steps=min(500, len(dataset) // 4),
            save_total_limit=3,
            dataloader_num_workers=0,  # Avoid multiprocessing issues
            remove_unused_columns=False,  # Keep our custom format
            report_to=None,  # Disable wandb
            dataloader_pin_memory=False,  # Can cause issues with custom collator
        )
        
        # Custom data collator
        data_collator = COMSOLDataCollator(
            tokenizer=tokenizer,
            max_length=2048 if "70b" in args.model_name.lower() else 4096
        )
        
        # Initialize trainer
        trainer = Trainer(
            model=model,
            args=training_args,
            train_dataset=dataset,
            data_collator=data_collator,
        )
        
        print(f"Starting training with {len(train_data)} examples...")
        print(f"Effective batch size: {training_args.per_device_train_batch_size * training_args.gradient_accumulation_steps}")
        print(f"Total training steps: {len(dataset) // (training_args.per_device_train_batch_size * training_args.gradient_accumulation_steps) * args.epochs}")
        
        # Start training
        trainer.train()
        
        # Save the final model
        print(f"Saving model to {args.output_dir}")
        trainer.save_model()
        tokenizer.save_pretrained(args.output_dir)
        
        print("✅ Fine-tuning completed!")
        print(f"Model saved to: {args.output_dir}")
        
        # Quick inference test
        print("\n=== Quick Test ===")
        FastLanguageModel.for_inference(model)
        
        test_prompt = """### Task: Create a new COMSOL model for electrostatics simulation

### Context: Model Context: Setting up a basic electrostatics simulation
Physics: Electrostatics
Step Purpose: Initialize the simulation environment

### COMSOL MATLAB Code:
"""
        
        inputs = tokenizer(test_prompt, return_tensors="pt").to(model.device)
        with torch.no_grad():
            outputs = model.generate(**inputs, max_new_tokens=100, temperature=0.1, do_sample=True)
        
        result = tokenizer.decode(outputs[0], skip_special_tokens=True)
        print("Test generation:")
        print(result[len(test_prompt):])
        
    except Exception as e:
        print(f"Error during training: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main() 