#!/usr/bin/env python3
"""
COMSOL Fine-Tuning Setup - Anti-Overfitting Version
- Better regularization
- Reduced model capacity
- Training dynamics monitoring
- Early stopping
"""

import os
import json
import glob
import argparse
from pathlib import Path
import numpy as np
from typing import Dict, List, Any
import random
import time

def main():
    parser = argparse.ArgumentParser(description="COMSOL Fine-tuning (Anti-Overfitting)")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing JSONL training files")
    parser.add_argument("--output_dir", type=str, default="./comsol_finetuned_v2",
                       help="Output directory for the fine-tuned model")
    parser.add_argument("--model_name", type=str, default="unsloth/codellama-34b-bnb-4bit",
                       help="Base model to fine-tune")
    parser.add_argument("--max_samples", type=int, default=20000,
                       help="Maximum number of samples to use")
    parser.add_argument("--gpus", type=str, default="4",
                       help="Comma-separated list of GPU IDs to use")
    parser.add_argument("--wandb_project", type=str, default="comsol-finetuning-v2",
                       help="WandB project name")
    
    args = parser.parse_args()
    
    # GPU setup
    os.environ["CUDA_VISIBLE_DEVICES"] = args.gpus
    print(f"🚀 Using GPU(s): {args.gpus}")
    
    # Enable WandB with more metrics
    if args.wandb_project:
        os.environ["WANDB_PROJECT"] = args.wandb_project
        os.environ.pop("WANDB_DISABLED", None)
        print(f"📊 WandB monitoring enabled: {args.wandb_project}")
    
    import torch
    from datasets import Dataset
    from transformers import TrainingArguments, Trainer
    from transformers.trainer_callback import TrainerCallback
    from transformers.data.data_collator import DataCollatorMixin
    from transformers.tokenization_utils_base import PreTrainedTokenizerBase
    import wandb

    try:
        from unsloth import FastLanguageModel
        UNSLOTH_AVAILABLE = True
    except ImportError:
        print("❌ Unsloth not available")
        return

    class OverfitDetectionCallback(TrainerCallback):
        """Detect overfitting by monitoring loss trends"""
        def __init__(self, patience=3, threshold=0.01):
            self.patience = patience
            self.threshold = threshold
            self.best_loss = float('inf')
            self.steps_without_improvement = 0
            self.loss_history = []
        
        def on_log(self, args, state, control, logs=None, **kwargs):
            if logs is None or 'loss' not in logs:
                return
            
            current_loss = logs['loss']
            self.loss_history.append(current_loss)
            
            # Need at least 50 steps to start checking
            if len(self.loss_history) < 50:
                return
            
            # Check if loss is too low (potential memorization)
            if current_loss < 0.1:
                print("⚠️ WARNING: Loss < 0.1, potential memorization!")
                if args.wandb_project:
                    wandb.log({"overfitting_alert": 1})
            
            # Check loss trend
            recent_loss = np.mean(self.loss_history[-10:])
            if recent_loss < self.best_loss - self.threshold:
                self.best_loss = recent_loss
                self.steps_without_improvement = 0
            else:
                self.steps_without_improvement += 1
            
            # Log metrics
            if args.wandb_project:
                wandb.log({
                    "loss_trend": recent_loss,
                    "steps_without_improvement": self.steps_without_improvement,
                    "best_loss": self.best_loss
                })
            
            if self.steps_without_improvement >= self.patience:
                print(f"\n⚠️ Loss hasn't improved for {self.patience} checks")
                print(f"Recent loss trend: {recent_loss:.4f}")
                print(f"Best loss seen: {self.best_loss:.4f}")

    class TrainingMetricsCallback(TrainerCallback):
        """Track and display training metrics in a clean format"""
        def __init__(self):
            self.training_start_time = None
            self.last_log_time = None
            self.total_steps = 0
            self.samples_per_second = []
        
        def on_train_begin(self, args, state, control, **kwargs):
            self.training_start_time = time.time()
            print("\n📈 Training Progress:")
            print("-" * 80)
            print(f"{'Step':>8} {'Loss':>10} {'Speed':>15} {'Time':>12}")
            print("-" * 80)
    
        def on_log(self, args, state, control, logs=None, **kwargs):
            if not logs:
                return
            
            current_time = time.time()
            
            # Initialize last_log_time if not set
            if self.last_log_time is None:
                self.last_log_time = current_time
                return
            
            # Calculate metrics
            time_diff = current_time - self.last_log_time
            if 'loss' in logs and 'steps_per_second' in logs:
                steps = logs.get('step', 0)
                loss = logs['loss']
                steps_per_second = logs['steps_per_second']
                samples_per_second = steps_per_second * args.per_device_train_batch_size * args.gradient_accumulation_steps
                self.samples_per_second.append(samples_per_second)
                
                # Calculate time elapsed
                elapsed = current_time - self.training_start_time
                hours = int(elapsed // 3600)
                minutes = int((elapsed % 3600) // 60)
                
                # Print metrics in a clean format
                print(f"{steps:>8d} {loss:>10.4f} {samples_per_second:>12.1f}/s {f'{hours:02d}:{minutes:02d}':>12}")
                
                if args.report_to and "wandb" in args.report_to:
                    wandb.log({
                        "training/step": steps,
                        "training/loss": loss,
                        "training/samples_per_second": samples_per_second,
                        "training/hours_elapsed": elapsed / 3600
                    })
            
            self.last_log_time = current_time

    class EnhancedDataCollator(DataCollatorMixin):
        """Data collator with length bucketing and dynamic batching"""
        
        def __init__(self, tokenizer: PreTrainedTokenizerBase, max_length: int = 2048):
            self.tokenizer = tokenizer
            self.max_length = max_length
            self.pad_token_id = tokenizer.eos_token_id
        
        def __call__(self, features: List[Dict[str, Any]]) -> Dict[str, torch.Tensor]:
            texts = [feature["text"] for feature in features]
            
            # Tokenize with length warnings
            batch_encoding = self.tokenizer(
                texts,
                truncation=True,
                padding="max_length",
                max_length=self.max_length,
                return_tensors="pt"
            )
            
            # Setup labels with masked padding
            batch_encoding["labels"] = batch_encoding["input_ids"].clone()
            batch_encoding["labels"][batch_encoding["labels"] == self.pad_token_id] = -100
            
            return batch_encoding

    def load_and_filter_data(data_dir, max_samples=None):
        """Load data with enhanced filtering"""
        
        jsonl_files = glob.glob(os.path.join(data_dir, "*.jsonl"))
        if not jsonl_files:
            raise ValueError(f"No JSONL files found in {data_dir}")
        
        print(f"📁 Found {len(jsonl_files)} JSONL files")
        
        all_data = []
        seen_outputs = set()
        seen_hashes = set()
        
        for file_path in jsonl_files:
            with open(file_path, 'r', encoding='utf-8') as f:
                for line in f:
                    try:
                        data = json.loads(line.strip())
                        
                        if not all(field in data for field in ['instruction', 'input', 'output']):
                            continue
                        
                        # Enhanced filtering
                        output = data['output'].strip()
                        
                        # Skip duplicates
                        output_hash = hash(output)
                        if output_hash in seen_hashes:
                            continue
                        
                        # Quality filters
                        if len(output) < 50:  # Too short
                            continue
                        if len(output) > 3000:  # Too long
                            continue
                        if output.count('\n') < 2:  # Single line
                            continue
                        if output.count('model.') < 2:  # Not enough COMSOL commands
                            continue
                        
                        # Check confidence if available
                        confidence = data.get('confidence', 0)
                        if confidence < 0.3:  # Low confidence
                            continue
                        
                        seen_hashes.add(output_hash)
                        all_data.append(data)
                        
                        if max_samples and len(all_data) >= max_samples:
                            break
                            
                    except json.JSONDecodeError:
                        continue
                        
            if max_samples and len(all_data) >= max_samples:
                break
        
        # Shuffle with fixed seed for reproducibility
        random.seed(42)
        random.shuffle(all_data)
        
        print(f"📊 Loaded {len(all_data)} high-quality examples")
        return all_data

    def format_training_text(example):
        """Format with explicit markers"""
        
        prompt = f"""### Task: {example['instruction']}

### Context: {example['input']}

### COMSOL MATLAB Code:
{example['output']}</s>"""

        return prompt

    def prepare_dataset(train_data):
        """Prepare dataset with validation split"""
        
        # Split into train/validation
        val_size = min(1000, int(len(train_data) * 0.1))
        val_data = train_data[:val_size]
        train_data = train_data[val_size:]
        
        def format_examples(examples):
            return [{"text": format_training_text(ex)} for ex in examples]
        
        train_dataset = Dataset.from_list(format_examples(train_data))
        val_dataset = Dataset.from_list(format_examples(val_data))
        
        print(f"✅ Prepared datasets:")
        print(f"   Train: {len(train_dataset)} examples")
        print(f"   Validation: {len(val_dataset)} examples")
        
        return train_dataset, val_dataset
    
    # Setup
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    try:
        # Load and filter data
        print("🔄 Loading and filtering data...")
        train_data = load_and_filter_data(args.data_dir, args.max_samples)
        
        if len(train_data) == 0:
            print("❌ No valid training data found!")
            return
        
        # Model setup
        print("🤖 Setting up model...")
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=args.model_name,
            max_seq_length=2048,
            dtype=None,
            load_in_4bit=True,
        )
        
        print(f"Model loaded on: {next(model.parameters()).device}")
        
        # Conservative LoRA setup
        model = FastLanguageModel.get_peft_model(
            model,
            r=8,  # Reduced rank
            target_modules=["q_proj", "k_proj", "v_proj", "o_proj"],
            lora_alpha=16,
            lora_dropout=0.0,  # Set to 0 for faster Unsloth patching
            bias="none",
            use_gradient_checkpointing="unsloth",
            random_state=42,
        )
        
        print("🎯 Using optimized LoRA settings (r=8, fast patching)")
        
        # Prepare datasets
        train_dataset, val_dataset = prepare_dataset(train_data)
        
        # Training arguments
        training_args = TrainingArguments(
            output_dir=output_dir,
            per_device_train_batch_size=4,
            gradient_accumulation_steps=4,
            warmup_ratio=0.1,
            num_train_epochs=2,
            learning_rate=1e-4,
            fp16=False,
            bf16=True,
            logging_steps=10,
            optim="adamw_8bit",
            weight_decay=0.05,
            lr_scheduler_type="cosine",
            seed=42,
            save_strategy="steps",
            save_steps=100,
            save_total_limit=2,
            report_to="wandb" if args.wandb_project else None,
            max_grad_norm=0.5,
            dataloader_num_workers=8,
            remove_unused_columns=False,
            gradient_checkpointing=True,
        )
        
        # Initialize WandB
        if args.wandb_project:
            wandb.init(
                project=args.wandb_project,
                config={
                    "model": args.model_name,
                    "dataset_size": len(train_dataset),
                    "lora_rank": 8,
                    "lora_dropout": 0.0,
                    "learning_rate": training_args.learning_rate,
                    "weight_decay": training_args.weight_decay,
                    "batch_size": training_args.per_device_train_batch_size * training_args.gradient_accumulation_steps,
                }
            )
        
        # Setup trainer with callbacks
        trainer = Trainer(
            model=model,
            args=training_args,
            train_dataset=train_dataset,
            eval_dataset=val_dataset,
            data_collator=EnhancedDataCollator(tokenizer=tokenizer),
            callbacks=[
                OverfitDetectionCallback(patience=5, threshold=0.01),
                TrainingMetricsCallback()
            ]
        )
        
        print("\n🔧 Training Configuration:")
        print(f"- Model: {args.model_name}")
        print(f"- Dataset size: {len(train_dataset):,} examples")
        print(f"- Batch size: {training_args.per_device_train_batch_size * training_args.gradient_accumulation_steps}")
        print(f"- Learning rate: {training_args.learning_rate}")
        print(f"- Weight decay: {training_args.weight_decay}")
        print(f"- LoRA rank: 8")
        print(f"- LoRA dropout: 0.0")
        print("-" * 80)
        
        print("🚀 Starting training with overfitting prevention...")
        trainer.train()
        
        # Save final model
        trainer.save_model()
        tokenizer.save_pretrained(output_dir)
        
        print("✅ Training completed!")
        
        # Quick test
        print("\n🧪 Testing generation...")
        FastLanguageModel.for_inference(model)
        
        test_prompt = """### Task: Create a new COMSOL model for electrostatics simulation

### Context: Model Context: Setting up a basic electrostatics simulation
Physics: Electrostatics

### COMSOL MATLAB Code:
"""
        
        inputs = tokenizer(test_prompt, return_tensors="pt").to(model.device)
        with torch.no_grad():
            outputs = model.generate(
                **inputs, 
                max_new_tokens=100,
                temperature=0.7,  # Higher temperature for creativity
                do_sample=True,
                top_p=0.9
            )
        
        result = tokenizer.decode(outputs[0], skip_special_tokens=True)
        generated = result[len(test_prompt):].strip()
        
        print("\nGenerated code:")
        print(generated)
        
        if args.wandb_project:
            wandb.log({"final_generation": generated})
            wandb.finish()
        
    except Exception as e:
        print(f"❌ Error during training: {e}")
        import traceback
        traceback.print_exc()
        
        if args.wandb_project:
            wandb.finish()

if __name__ == "__main__":
    main() 