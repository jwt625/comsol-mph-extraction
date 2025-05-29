#!/usr/bin/env python3
"""
COMSOL Fine-Tuning Setup - Minimal Version
Uses original tokenizer without modifications to avoid resize issues
"""

import os
import json
import glob
import argparse
from pathlib import Path

# Set environment variables to avoid warnings
os.environ["TOKENIZERS_PARALLELISM"] = "false"
os.environ["WANDB_DISABLED"] = "false"

def main():
    parser = argparse.ArgumentParser(description="Fine-tune model on COMSOL data (Minimal Version)")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing JSONL training files")
    parser.add_argument("--output_dir", type=str, default="./comsol_finetuned_model_minimal",
                       help="Output directory for the fine-tuned model")
    parser.add_argument("--model_name", type=str, default="unsloth/codellama-34b-bnb-4bit",
                       help="Base model to fine-tune")
    parser.add_argument("--max_samples", type=int, default=None,
                       help="Maximum number of samples to use (for testing)")
    parser.add_argument("--gpus", type=str, default="4",
                       help="Comma-separated list of GPU IDs to use (default: 4)")
    
    args = parser.parse_args()
    
    # Parse GPU list and set CUDA_VISIBLE_DEVICES BEFORE importing anything else
    available_gpus = [int(gpu.strip()) for gpu in args.gpus.split(",") if gpu.strip()]
    print(f"Available GPUs: {available_gpus}")
    
    # Set GPU BEFORE any CUDA/torch imports
    if available_gpus:
        os.environ["CUDA_VISIBLE_DEVICES"] = str(available_gpus[0])
        print(f"Using GPU: {available_gpus[0]} (mapped to cuda:0)")
    
    # NOW import torch and other CUDA-dependent libraries
    import torch
    from datasets import Dataset
    from transformers import TrainingArguments, Trainer
    from transformers.data.data_collator import DataCollatorMixin
    from transformers.tokenization_utils_base import PreTrainedTokenizerBase
    from typing import Dict, List, Any

    # Import unsloth after setting GPU
    try:
        from unsloth import FastLanguageModel
        UNSLOTH_AVAILABLE = True
    except ImportError:
        print("Warning: Unsloth not available, falling back to standard training")
        UNSLOTH_AVAILABLE = False

    class COMSOLDataCollator(DataCollatorMixin):
        """
        Custom data collator that handles CodeLlama tokenization properly
        """
        
        def __init__(self, tokenizer: PreTrainedTokenizerBase, max_length: int = 2048):
            self.tokenizer = tokenizer
            self.max_length = max_length
            # Use eos_token_id for padding, CodeLlama doesn't have a separate pad token
            self.pad_token_id = tokenizer.eos_token_id
        
        def __call__(self, features: List[Dict[str, Any]]) -> Dict[str, torch.Tensor]:
            # Extract the text and tokenize on the fly
            texts = [feature["text"] for feature in features]
            
            # Tokenize all texts
            batch_encoding = self.tokenizer(
                texts,
                truncation=True,
                padding="longest",  # Pad to longest in batch
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
{example['output']}</s>"""  # Add explicit end token

        return prompt

    def prepare_dataset(train_data):
        """Prepare dataset without tokenization - let data collator handle it"""
        
        # Format all examples but don't tokenize
        formatted_data = []
        for example in train_data:
            text = format_training_text(example)
            formatted_data.append({"text": text})
        
        # Create dataset
        dataset = Dataset.from_list(formatted_data)
        
        print(f"Dataset prepared with {len(dataset)} examples")
        
        return dataset
    
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
        
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=args.model_name,
            max_seq_length=2048,  # Conservative for 34B
            dtype=None,  # Auto-detect
            load_in_4bit=True,  # Use 4-bit to fit in memory
        )
        
        # DON'T modify the tokenizer - use it as-is
        print(f"Tokenizer vocab size: {len(tokenizer)}")
        print(f"EOS token: {tokenizer.eos_token} (ID: {tokenizer.eos_token_id})")
        print(f"Model device: {next(model.parameters()).device}")
        
        # Setup LoRA 
        model = FastLanguageModel.get_peft_model(
            model,
            r=64,
            target_modules=["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"],
            lora_alpha=64,
            lora_dropout=0.05,
            bias="none",
            use_gradient_checkpointing="unsloth",
            random_state=3407,
        )
        
        # Prepare dataset
        print("Preparing dataset...")
        dataset = prepare_dataset(train_data)
        
        # Training arguments
        training_args = TrainingArguments(
            output_dir=output_dir,
            per_device_train_batch_size=1,  # Reduced to fit in memory
            gradient_accumulation_steps=8,  # Increased to maintain effective batch size
            warmup_steps=10,
            num_train_epochs=1,
            learning_rate=2e-4,
            fp16=False,
            bf16=True,
            logging_steps=1,
            optim="adamw_8bit",
            weight_decay=0.01,
            lr_scheduler_type="cosine",
            seed=3407,
            save_steps=len(dataset),  # Save at end only
            save_total_limit=1,
            dataloader_num_workers=0,
            remove_unused_columns=False,
            report_to=None,
            dataloader_pin_memory=False,
            max_grad_norm=1.0,  # Gradient clipping
            ddp_find_unused_parameters=False,
        )
        
        # Custom data collator
        data_collator = COMSOLDataCollator(
            tokenizer=tokenizer,
            max_length=2048
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

### COMSOL MATLAB Code:
"""
        
        inputs = tokenizer(test_prompt, return_tensors="pt").to(model.device)
        with torch.no_grad():
            outputs = model.generate(**inputs, max_new_tokens=50, temperature=0.1, do_sample=True)
        
        result = tokenizer.decode(outputs[0], skip_special_tokens=True)
        print("Test generation:")
        print(result[len(test_prompt):])
        
    except Exception as e:
        print(f"Error during training: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main() 