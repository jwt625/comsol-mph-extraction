#!/usr/bin/env python3
"""
Final test of fine-tuned model with proper settings
"""

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "4"
os.environ["CUDA_LAUNCH_BLOCKING"] = "1"  # For debugging

import torch
from unsloth import FastLanguageModel

def final_test():
    print("🔬 FINAL FINE-TUNED MODEL TEST")
    print("="*50)
    
    try:
        # Load with 4-bit quantization (same as training)
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name="./comsol_finetuned_model_minimal",
            max_seq_length=2048,
            dtype=None,
            load_in_4bit=True,  # Same as training
        )
        
        FastLanguageModel.for_inference(model)
        print("✅ Model loaded successfully!")
        
        # Very simple COMSOL prompts
        simple_prompts = [
            "model = ModelUtil.create('Model');",
            "% COMSOL model\nmodel =",
            "import com.comsol.model.*\n",
        ]
        
        print("\n🧪 Testing with simple prompts...")
        
        for i, prompt in enumerate(simple_prompts, 1):
            print(f"\n--- Test {i} ---")
            print(f"Prompt: {repr(prompt)}")
            
            try:
                inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
                
                # Simple generation
                with torch.no_grad():
                    outputs = model.generate(
                        **inputs,
                        max_new_tokens=30,
                        temperature=0.8,
                        do_sample=True,
                        pad_token_id=tokenizer.eos_token_id,
                    )
                
                generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
                generated_part = generated_text[len(prompt):].strip()
                
                print(f"Generated: {repr(generated_part)}")
                if generated_part:
                    print("Output:")
                    print(generated_part)
                else:
                    print("(No output)")
                    
            except Exception as e:
                print(f"Error in generation: {e}")
            
            print("-" * 30)
        
        # Test with training format
        print(f"\n🎯 Testing with training format...")
        training_prompt = """### Task: Create a new COMSOL model

### Context: Basic model setup

### COMSOL MATLAB Code:
"""
        
        try:
            inputs = tokenizer(training_prompt, return_tensors="pt").to(model.device)
            
            with torch.no_grad():
                outputs = model.generate(
                    **inputs,
                    max_new_tokens=50,
                    temperature=0.5,
                    do_sample=True,
                    pad_token_id=tokenizer.eos_token_id,
                )
            
            generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
            generated_part = generated_text[len(training_prompt):].strip()
            
            print(f"Training format result: {repr(generated_part)}")
            if generated_part:
                print("Generated code:")
                print(generated_part)
            
        except Exception as e:
            print(f"Error with training format: {e}")
            
    except Exception as e:
        print(f"❌ Error loading model: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    final_test() 