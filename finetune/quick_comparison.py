#!/usr/bin/env python3
"""
Quick comparison of base vs fine-tuned model with simpler prompts
"""

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "4"

import torch
from unsloth import FastLanguageModel

def test_model(model_name, model_type):
    print(f"\n{'='*50}")
    print(f"TESTING {model_type} MODEL: {model_name}")
    print('='*50)
    
    # Load model without 4-bit quantization for better quality
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=model_name,
        max_seq_length=2048,
        dtype=None,
        load_in_4bit=False,  # Full precision for better generation
    )
    
    FastLanguageModel.for_inference(model)
    
    # Simple, direct prompts
    prompts = [
        "% Create COMSOL model\nmodel = ModelUtil.create('Model');\n",
        "import com.comsol.model.*\nmodel = ModelUtil.create('Model');\n",
        "function out = model\nmodel = ModelUtil.create('Model');\n"
    ]
    
    for i, prompt in enumerate(prompts, 1):
        print(f"\n--- Test {i}: {model_type} ---")
        print(f"Prompt: {repr(prompt)}")
        
        inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
        
        # Generate with higher temperature for creativity
        with torch.no_grad():
            outputs = model.generate(
                **inputs,
                max_new_tokens=50,
                temperature=0.7,
                do_sample=True,
                top_p=0.9,
                pad_token_id=tokenizer.eos_token_id,
                eos_token_id=tokenizer.eos_token_id,
            )
        
        generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
        generated_code = generated_text[len(prompt):].strip()
        
        print(f"Generated: {repr(generated_code)}")
        if generated_code:
            print("Formatted output:")
            print(generated_code)
        print("-" * 30)

def main():
    print("QUICK COMPARISON: BASE vs FINE-TUNED")
    
    # Test base model
    try:
        test_model("unsloth/codellama-34b-bnb-4bit", "BASE")
    except Exception as e:
        print(f"Error testing base model: {e}")
    
    # Test fine-tuned model
    try:
        test_model("./comsol_finetuned_model_minimal", "FINE-TUNED")
    except Exception as e:
        print(f"Error testing fine-tuned model: {e}")

if __name__ == "__main__":
    main() 