#!/usr/bin/env python3
"""
COMSOL Model Inference Script
Use the fine-tuned model to generate COMSOL MATLAB code
"""

import torch
import argparse
import json
from transformers import AutoTokenizer, AutoModelForCausalLM
from peft import PeftModel
import re

def load_model(model_path, base_model=None):
    """Load the fine-tuned model for inference"""
    
    try:
        # Try loading as Unsloth model first
        from unsloth import FastLanguageModel
        
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name=model_path,
            max_seq_length=2048,
            dtype=None,
            load_in_4bit=False,  # For inference, use full precision if possible
        )
        FastLanguageModel.for_inference(model)
        print("✅ Loaded as Unsloth model")
        
    except Exception as e:
        print(f"Unsloth loading failed: {e}")
        print("Trying standard transformers loading...")
        
        # Load metadata to get base model
        try:
            with open(f"{model_path}/training_metadata.json", 'r') as f:
                metadata = json.load(f)
                base_model = base_model or metadata.get("base_model", "unsloth/CodeLlama-7b-Instruct-hf")
        except:
            base_model = base_model or "unsloth/CodeLlama-7b-Instruct-hf"
        
        # Load with transformers + PEFT
        tokenizer = AutoTokenizer.from_pretrained(model_path)
        base_model_obj = AutoModelForCausalLM.from_pretrained(
            base_model,
            torch_dtype=torch.float16 if torch.cuda.is_available() else torch.float32,
            device_map="auto" if torch.cuda.is_available() else None,
        )
        
        # Load LoRA weights
        model = PeftModel.from_pretrained(base_model_obj, model_path)
        model.eval()
        print("✅ Loaded as PEFT model")
    
    return model, tokenizer

def create_prompt(task, context, physics="Unknown"):
    """Create a properly formatted prompt for the model"""
    
    system_prompt = """You are a COMSOL Multiphysics expert that generates MATLAB code for simulation setup. 
You understand physics domains like SolidMechanics, Electrostatics, FluidFlow, HeatTransfer, etc.
Generate precise COMSOL MATLAB commands that accomplish the given task."""

    user_message = f"""Task: {task}

Context: {context}

Generate the COMSOL MATLAB code:"""

    prompt = f"""<|im_start|>system
{system_prompt}<|im_end|>
<|im_start|>user
{user_message}<|im_end|>
<|im_start|>assistant
"""

    return prompt

def generate_code(model, tokenizer, prompt, max_length=512, temperature=0.1, top_p=0.9):
    """Generate COMSOL code using the fine-tuned model"""
    
    inputs = tokenizer(prompt, return_tensors="pt")
    
    # Move to GPU if available
    if torch.cuda.is_available():
        inputs = {k: v.to(model.device) for k, v in inputs.items()}
    
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=max_length,
            temperature=temperature,
            top_p=top_p,
            do_sample=True,
            pad_token_id=tokenizer.eos_token_id,
            repetition_penalty=1.1,
            length_penalty=1.0,
        )
    
    # Decode the full response
    full_response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    
    # Extract just the assistant's response
    if "<|im_start|>assistant\n" in full_response:
        generated_code = full_response.split("<|im_start|>assistant\n")[-1]
    else:
        generated_code = full_response[len(prompt):]
    
    # Clean up the response
    generated_code = generated_code.strip()
    if generated_code.endswith("<|im_end|>"):
        generated_code = generated_code[:-10].strip()
    
    return generated_code

def interactive_mode(model, tokenizer):
    """Interactive mode for generating COMSOL code"""
    
    print("\n🔧 COMSOL Code Generator - Interactive Mode")
    print("Type 'quit' to exit")
    print("-" * 50)
    
    while True:
        print("\n📝 Enter your COMSOL task:")
        task = input("> ").strip()
        
        if task.lower() == 'quit':
            break
            
        print("\n📋 Enter context (optional):")
        context = input("> ").strip()
        if not context:
            context = "COMSOL Multiphysics simulation setup"
        
        print("\n⚡ Enter physics domain (optional):")
        physics = input("> ").strip()
        if not physics:
            physics = "Unknown"
        
        # Create full context
        full_context = f"Model Context: {context}\nPhysics: {physics}\nStep Purpose: {task}\nWhat to do: {task}"
        
        print("\n🤖 Generating code...")
        prompt = create_prompt(task, full_context, physics)
        generated_code = generate_code(model, tokenizer, prompt)
        
        print("\n✅ Generated COMSOL Code:")
        print("-" * 40)
        print(generated_code)
        print("-" * 40)

def batch_mode(model, tokenizer, input_file, output_file):
    """Batch mode for processing multiple requests"""
    
    print(f"📁 Processing batch file: {input_file}")
    
    with open(input_file, 'r') as f:
        requests = json.load(f)
    
    results = []
    
    for i, request in enumerate(requests):
        print(f"Processing request {i+1}/{len(requests)}: {request.get('task', '')[:50]}...")
        
        task = request['task']
        context = request.get('context', 'COMSOL simulation setup')
        physics = request.get('physics', 'Unknown')
        
        full_context = f"Model Context: {context}\nPhysics: {physics}\nStep Purpose: {task}\nWhat to do: {task}"
        
        prompt = create_prompt(task, full_context, physics)
        generated_code = generate_code(
            model, tokenizer, prompt,
            max_length=request.get('max_length', 512),
            temperature=request.get('temperature', 0.1)
        )
        
        results.append({
            'request': request,
            'generated_code': generated_code,
            'prompt_used': prompt
        })
    
    # Save results
    with open(output_file, 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f"✅ Results saved to: {output_file}")

def main():
    parser = argparse.ArgumentParser(description="COMSOL Code Generation with Fine-tuned Model")
    parser.add_argument("--model_path", type=str, required=True,
                       help="Path to the fine-tuned model")
    parser.add_argument("--base_model", type=str, default=None,
                       help="Base model name (if not in metadata)")
    parser.add_argument("--interactive", action="store_true",
                       help="Run in interactive mode")
    parser.add_argument("--batch_input", type=str, default=None,
                       help="JSON file with batch requests")
    parser.add_argument("--batch_output", type=str, default="batch_results.json",
                       help="Output file for batch results")
    parser.add_argument("--task", type=str, default=None,
                       help="Single task to generate code for")
    parser.add_argument("--context", type=str, default="COMSOL simulation setup",
                       help="Context for the task")
    parser.add_argument("--physics", type=str, default="Unknown",
                       help="Physics domain")
    parser.add_argument("--max_length", type=int, default=512,
                       help="Maximum tokens to generate")
    parser.add_argument("--temperature", type=float, default=0.1,
                       help="Generation temperature")
    
    args = parser.parse_args()
    
    # Load model
    print("🔄 Loading fine-tuned model...")
    model, tokenizer = load_model(args.model_path, args.base_model)
    
    if args.interactive:
        interactive_mode(model, tokenizer)
    elif args.batch_input:
        batch_mode(model, tokenizer, args.batch_input, args.batch_output)
    elif args.task:
        # Single task mode
        full_context = f"Model Context: {args.context}\nPhysics: {args.physics}\nStep Purpose: {args.task}\nWhat to do: {args.task}"
        prompt = create_prompt(args.task, full_context, args.physics)
        generated_code = generate_code(model, tokenizer, prompt, args.max_length, args.temperature)
        
        print("\n✅ Generated COMSOL Code:")
        print("-" * 40)
        print(generated_code)
        print("-" * 40)
    else:
        print("❌ Please specify --interactive, --batch_input, or --task")

if __name__ == "__main__":
    main() 