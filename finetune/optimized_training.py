#!/usr/bin/env python3
"""
OPTIMIZED COMSOL Fine-Tuning Setup
- WandB monitoring
- Improved speed optimizations  
- Better dataset filtering
- Multi-GPU support
- Advanced LoRA settings
"""

import os
import json
import glob
import argparse
from pathlib import Path
from collections import Counter
import random

def main():
    parser = argparse.ArgumentParser(description="Optimized COMSOL Fine-tuning")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing JSONL training files")
    parser.add_argument("--output_dir", type=str, default="./comsol_finetuned_optimized",
                       help="Output directory for the fine-tuned model")
    parser.add_argument("--model_name", type=str, default="unsloth/codellama-34b-bnb-4bit",
                       help="Base model to fine-tune")
    parser.add_argument("--max_samples", type=int, default=None,
                       help="Maximum number of samples to use")
    parser.add_argument("--gpus", type=str, default="4,5,6,7",
                       help="Comma-separated list of GPU IDs to use")
    parser.add_argument("--filter_duplicates", action="store_true",
                       help="Filter out duplicate/repetitive examples")
    parser.add_argument("--fast_mode", action="store_true",
                       help="Use faster settings (lower quality but quicker)")
    parser.add_argument("--wandb_project", type=str, default="comsol-finetuning",
                       help="WandB project name")
    
    args = parser.parse_args()
    
    # Parse GPU list and setup
    available_gpus = [int(gpu.strip()) for gpu in args.gpus.split(",") if gpu.strip()]
    print(f"🚀 Available GPUs: {available_gpus}")
    
    # Use multiple GPUs if available
    if len(available_gpus) > 1:
        os.environ["CUDA_VISIBLE_DEVICES"] = ",".join(map(str, available_gpus))
        print(f"Using multi-GPU setup: {available_gpus}")
    else:
        os.environ["CUDA_VISIBLE_DEVICES"] = str(available_gpus[0])
        print(f"Using single GPU: {available_gpus[0]}")
    
    # Enable WandB
    if args.wandb_project:
        os.environ["WANDB_PROJECT"] = args.wandb_project
        os.environ.pop("WANDB_DISABLED", None)  # Remove disable flag
        print(f"📊 WandB monitoring enabled: {args.wandb_project}")
    
    # Import after GPU setup
    import torch
    from datasets import Dataset
    from transformers import TrainingArguments, Trainer
    from transformers.data.data_collator import DataCollatorMixin
    from transformers.tokenization_utils_base import PreTrainedTokenizerBase
    from typing import Dict, List, Any
    import wandb

    try:
        from unsloth import FastLanguageModel
        UNSLOTH_AVAILABLE = True
    except ImportError:
        print("❌ Unsloth not available")
        return

    class OptimizedDataCollator(DataCollatorMixin):
        """Optimized data collator with better memory handling"""
        
        def __init__(self, tokenizer: PreTrainedTokenizerBase, max_length: int = 2048):
            self.tokenizer = tokenizer
            self.max_length = max_length
            self.pad_token_id = tokenizer.eos_token_id
        
        def __call__(self, features: List[Dict[str, Any]]) -> Dict[str, torch.Tensor]:
            texts = [feature["text"] for feature in features]
            
            # Tokenize efficiently
            batch_encoding = self.tokenizer(
                texts,
                truncation=True,
                padding="max_length",  # Consistent padding
                max_length=self.max_length,
                return_tensors="pt"
            )
            
            # Setup labels for causal LM
            batch_encoding["labels"] = batch_encoding["input_ids"].clone()
            batch_encoding["labels"][batch_encoding["labels"] == self.pad_token_id] = -100
            
            return batch_encoding

    def analyze_dataset_quality(data_dir):
        """Analyze dataset for quality and diversity"""
        print("📊 Analyzing dataset quality...")
        
        jsonl_files = glob.glob(os.path.join(data_dir, "*.jsonl"))
        
        all_instructions = []
        all_outputs = []
        physics_types = []
        categories = []
        
        for file_path in jsonl_files[:10]:  # Sample first 10 files
            with open(file_path, 'r', encoding='utf-8') as f:
                for line in f:
                    try:
                        data = json.loads(line.strip())
                        all_instructions.append(data.get('instruction', ''))
                        all_outputs.append(data.get('output', ''))
                        
                        # Extract physics and category
                        explanation = data.get('explanation', '')
                        if 'Physics:' in explanation:
                            physics = explanation.split('Physics:')[1].split('.')[0].strip()
                            physics_types.append(physics)
                        
                        categories.append(data.get('category', 'unknown'))
                        
                    except json.JSONDecodeError:
                        continue
        
        # Analyze diversity
        instruction_diversity = len(set(all_instructions)) / len(all_instructions) if all_instructions else 0
        output_diversity = len(set(all_outputs)) / len(all_outputs) if all_outputs else 0
        
        print(f"📈 Dataset Analysis:")
        print(f"  - Instruction diversity: {instruction_diversity:.2%}")
        print(f"  - Output diversity: {output_diversity:.2%}")
        print(f"  - Physics types: {len(set(physics_types))}")
        print(f"  - Top physics: {Counter(physics_types).most_common(5)}")
        print(f"  - Categories: {Counter(categories).most_common(5)}")
        
        return instruction_diversity, output_diversity

    def load_and_filter_data(data_dir, max_samples=None, filter_duplicates=False):
        """Load data with optional filtering for better quality"""
        
        jsonl_files = glob.glob(os.path.join(data_dir, "*.jsonl"))
        if not jsonl_files:
            raise ValueError(f"No JSONL files found in {data_dir}")
        
        print(f"📁 Found {len(jsonl_files)} JSONL files")
        
        all_data = []
        seen_outputs = set()
        
        for file_path in jsonl_files:
            with open(file_path, 'r', encoding='utf-8') as f:
                for line in f:
                    try:
                        data = json.loads(line.strip())
                        
                        if not all(field in data for field in ['instruction', 'input', 'output']):
                            continue
                        
                        # Filter duplicates if requested
                        if filter_duplicates:
                            output_hash = hash(data['output'])
                            if output_hash in seen_outputs:
                                continue
                            seen_outputs.add(output_hash)
                        
                        # Skip very short or very repetitive outputs
                        output = data['output'].strip()
                        if len(output) < 20:  # Too short
                            continue
                        if output.count('\n') < 1:  # Single line only
                            continue
                        
                        all_data.append(data)
                        
                        if max_samples and len(all_data) >= max_samples:
                            break
                            
                    except json.JSONDecodeError:
                        continue
                        
            if max_samples and len(all_data) >= max_samples:
                break
        
        # Shuffle for better training
        random.shuffle(all_data)
        
        print(f"📊 Loaded {len(all_data)} training examples")
        if filter_duplicates:
            print(f"🔍 Filtered duplicates, kept {len(all_data)} unique examples")
        
        return all_data

    def format_training_text(example):
        """Enhanced formatting with better structure"""
        
        prompt = f"""### Task: {example['instruction']}

### Context: {example['input']}

### COMSOL MATLAB Code:
{example['output']}</s>"""

        return prompt

    def prepare_dataset(train_data):
        """Prepare optimized dataset"""
        
        formatted_data = []
        for example in train_data:
            text = format_training_text(example)
            formatted_data.append({"text": text})
        
        dataset = Dataset.from_list(formatted_data)
        print(f"✅ Dataset prepared with {len(dataset)} examples")
        
        return dataset
    
    # Create output directory
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    try:
        # Analyze dataset quality first
        analyze_dataset_quality(args.data_dir)
        
        # Load and filter data
        print("🔄 Loading training data...")
        train_data = load_and_filter_data(
            args.data_dir, 
            args.max_samples, 
            args.filter_duplicates
        )
        
        if len(train_data) == 0:
            print("❌ No training data found!")
            return
        
        # Setup model and tokenizer
        print("🤖 Setting up model and tokenizer...")
        
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=args.model_name,
            max_seq_length=2048,
            dtype=None,
            load_in_4bit=True,
        )
        
        print(f"🔧 Model setup complete")
        print(f"  - Vocab size: {len(tokenizer)}")
        print(f"  - Device: {next(model.parameters()).device}")
        
        # Optimized LoRA setup
        if args.fast_mode:
            lora_r = 16  # Smaller for speed
            lora_alpha = 16
        else:
            lora_r = 32  # Balanced
            lora_alpha = 64
        
        model = FastLanguageModel.get_peft_model(
            model,
            r=lora_r,
            target_modules=["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"],
            lora_alpha=lora_alpha,
            lora_dropout=0.05,
            bias="none",
            use_gradient_checkpointing="unsloth",
            random_state=3407,
        )
        
        print(f"🎯 LoRA setup: r={lora_r}, alpha={lora_alpha}")
        
        # Prepare dataset
        print("📝 Preparing dataset...")
        dataset = prepare_dataset(train_data)
        
        # Optimized training arguments
        if args.fast_mode:
            batch_size = 2
            grad_accum = 4
            epochs = 1
        else:
            batch_size = 1 if len(available_gpus) == 1 else 2
            grad_accum = 8 if len(available_gpus) == 1 else 4
            epochs = 3
        
        effective_batch_size = batch_size * grad_accum * len(available_gpus)
        
        training_args = TrainingArguments(
            output_dir=output_dir,
            per_device_train_batch_size=batch_size,
            gradient_accumulation_steps=grad_accum,
            warmup_steps=max(10, len(dataset) // 20),  # 5% warmup
            num_train_epochs=epochs,
            learning_rate=2e-4,
            fp16=False,
            bf16=True,
            logging_steps=max(1, len(dataset) // 100),  # 1% logging frequency
            optim="adamw_8bit",
            weight_decay=0.01,
            lr_scheduler_type="cosine",
            seed=3407,
            save_steps=len(dataset) // epochs,  # Save each epoch
            save_total_limit=2,
            dataloader_num_workers=4,  # Increased for speed
            remove_unused_columns=False,
            report_to="wandb" if args.wandb_project else None,
            dataloader_pin_memory=True,
            max_grad_norm=1.0,
            ddp_find_unused_parameters=False,
            evaluation_strategy="no",
            # Speed optimizations
            dataloader_persistent_workers=True,
            include_inputs_for_metrics=False,
        )
        
        print(f"⚡ Training Configuration:")
        print(f"  - Effective batch size: {effective_batch_size}")
        print(f"  - Epochs: {epochs}")
        print(f"  - Learning rate: {training_args.learning_rate}")
        print(f"  - Warmup steps: {training_args.warmup_steps}")
        print(f"  - Save steps: {training_args.save_steps}")
        
        # Initialize WandB
        if args.wandb_project:
            wandb.init(
                project=args.wandb_project,
                config={
                    "model_name": args.model_name,
                    "dataset_size": len(train_data),
                    "lora_r": lora_r,
                    "lora_alpha": lora_alpha,
                    "effective_batch_size": effective_batch_size,
                    "learning_rate": training_args.learning_rate,
                    "epochs": epochs,
                    "gpus": available_gpus,
                    "fast_mode": args.fast_mode,
                    "filter_duplicates": args.filter_duplicates,
                }
            )
        
        # Data collator
        data_collator = OptimizedDataCollator(
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
        
        print(f"🚀 Starting optimized training...")
        print(f"   Dataset: {len(train_data)} examples")
        print(f"   GPUs: {available_gpus}")
        print(f"   Effective batch: {effective_batch_size}")
        
        # Start training
        trainer.train()
        
        # Save model
        print(f"💾 Saving model to {args.output_dir}")
        trainer.save_model()
        tokenizer.save_pretrained(args.output_dir)
        
        print("✅ Optimized fine-tuning completed!")
        
        # Quick test
        print("\n🧪 Quick inference test:")
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
                temperature=0.3, 
                do_sample=True,
                top_p=0.9
            )
        
        result = tokenizer.decode(outputs[0], skip_special_tokens=True)
        generated = result[len(test_prompt):].strip()
        
        print("Generated code:")
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