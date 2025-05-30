#!/usr/bin/env python3
"""
Simple test of the fine-tuned model with more aggressive parameters
"""

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "4"

import torch
from unsloth import FastLanguageModel

def simple_test():
    print("Loading fine-tuned model...")
    
    # Load the fine-tuned model
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name="./comsol_finetuned_model_minimal",
        max_seq_length=2048,
        dtype=None,
        load_in_4bit=True,
    )
    
    # Prepare for inference
    FastLanguageModel.for_inference(model)
    
    # Simple test prompt
    prompt = """### Task: Create a new COMSOL model for electrostatics simulation

### Context: Model Context: Setting up a basic electrostatics simulation
Physics: Electrostatics

### COMSOL MATLAB Code:
"""
    
    print("Prompt:")
    print(prompt)
    print("\n" + "="*50)
    
    # Tokenize
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    print(f"Input tokens: {inputs['input_ids'].shape[1]}")
    
    # Try different generation strategies
    strategies = [
        {"name": "Greedy", "temperature": None, "do_sample": False},
        {"name": "Low temp", "temperature": 0.1, "do_sample": True, "top_p": 0.95},
        {"name": "Medium temp", "temperature": 0.7, "do_sample": True, "top_p": 0.9},
        {"name": "High temp", "temperature": 1.0, "do_sample": True, "top_p": 0.8},
    ]
    
    for strategy in strategies:
        print(f"\n--- {strategy['name']} Generation ---")
        
        with torch.no_grad():
            if strategy["temperature"] is None:
                # Greedy decoding
                outputs = model.generate(
                    **inputs,
                    max_new_tokens=100,
                    do_sample=False,
                    pad_token_id=tokenizer.eos_token_id,
                    eos_token_id=tokenizer.eos_token_id,
                )
            else:
                # Sampling
                outputs = model.generate(
                    **inputs,
                    max_new_tokens=100,
                    temperature=strategy["temperature"],
                    do_sample=strategy["do_sample"],
                    top_p=strategy["top_p"],
                    pad_token_id=tokenizer.eos_token_id,
                    eos_token_id=tokenizer.eos_token_id,
                )
        
        # Decode
        generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
        generated_code = generated_text[len(prompt):].strip()
        
        print(f"Output length: {len(generated_code)} characters")
        if generated_code:
            print("Generated:")
            print(generated_code[:200] + ("..." if len(generated_code) > 200 else ""))
        else:
            print("(No output)")
        print("-" * 30)

if __name__ == "__main__":
    simple_test() 