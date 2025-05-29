#!/usr/bin/env python3
"""
Model recommendations for COMSOL fine-tuning on H100 cluster
"""

import subprocess
import re

def get_gpu_memory():
    """Get available GPU memory"""
    try:
        result = subprocess.run(['nvidia-smi', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], 
                              capture_output=True, text=True)
        memory_values = [int(x.strip()) for x in result.stdout.strip().split('\n')]
        return memory_values
    except:
        return []

def recommend_models():
    """Recommend models based on available hardware"""
    
    gpu_memory = get_gpu_memory()
    available_gpus = [i for i, mem in enumerate(gpu_memory) if mem > 70000]  # >70GB free
    
    print("🚀 COMSOL Fine-tuning Model Recommendations")
    print("=" * 60)
    print(f"Available GPUs with >70GB: {available_gpus}")
    print(f"Free memory per GPU: {[f'{mem//1024}GB' for mem in gpu_memory if mem > 70000]}")
    print()
    
    models = [
        {
            "name": "CodeLlama-34B-Instruct",
            "model_id": "unsloth/codellama-34b-bnb-4bit",
            "gpus_needed": 2,
            "training_time": "4-6 hours",
            "strengths": "🔥 Best for code generation, COMSOL MATLAB understanding",
            "use_case": "Recommended for COMSOL-specific tasks",
            "quality": "⭐⭐⭐⭐⭐"
        },
        {
            "name": "Qwen2.5-Coder-7B",
            "model_id": "unsloth/Qwen2.5-Coder-7B-Instruct",
            "gpus_needed": 1,
            "training_time": "2-3 hours",
            "strengths": "⚡ Code specialist, excellent for scientific computing",
            "use_case": "Best for technical/engineering code tasks",
            "quality": "⭐⭐⭐⭐⭐"
        },
        {
            "name": "Llama-3.3-70B-Instruct",
            "model_id": "unsloth/Llama-3.3-70B-Instruct",
            "gpus_needed": 4,
            "training_time": "8-12 hours",
            "strengths": "🎯 Highest quality, superior reasoning and instruction following",
            "use_case": "Maximum quality for complex tasks",
            "quality": "⭐⭐⭐⭐⭐⭐"
        },
        {
            "name": "CodeLlama-13B-Instruct",
            "model_id": "unsloth/CodeLlama-13b-Instruct-hf",
            "gpus_needed": 1,
            "training_time": "2-3 hours",
            "strengths": "💨 Fast training, good for quick iterations",
            "use_case": "Rapid prototyping and testing",
            "quality": "⭐⭐⭐⭐"
        }
    ]
    
    print("📋 Model Options:")
    print("-" * 60)
    
    for i, model in enumerate(models, 1):
        available = "✅ Available" if len(available_gpus) >= model["gpus_needed"] else "❌ Not enough GPUs"
        
        print(f"{i}. {model['name']} {available}")
        print(f"   Model ID: {model['model_id']}")
        print(f"   GPUs needed: {model['gpus_needed']} | Training time: {model['training_time']}")
        print(f"   Quality: {model['quality']}")
        print(f"   Strengths: {model['strengths']}")
        print(f"   Use case: {model['use_case']}")
        print()
    
    print("🎯 Recommendations based on your setup:")
    print("-" * 60)
    
    if len(available_gpus) >= 4:
        print("1. 🏆 BEST CHOICE: Llama-3.3-70B-Instruct")
        print("   → Highest quality results, uses all 4 available GPUs")
        print("   → Command: --model_name unsloth/Llama-3.3-70B-Instruct --gpus 4,5,6,7")
        print()
        
        print("2. ⚡ SPEED CHOICE: CodeLlama-34B-Instruct")
        print("   → Excellent quality, faster training (uses 2 GPUs)")
        print("   → Command: --model_name unsloth/codellama-34b-bnb-4bit --gpus 4,5")
        print()
        
        print("3. 🔬 SPECIALIST: Qwen2.5-Coder-7B")
        print("   → Code-specialized, great for technical tasks")
        print("   → Command: --model_name unsloth/Qwen2.5-Coder-7B-Instruct --gpus 4,5")
    
    elif len(available_gpus) >= 2:
        print("1. 🏆 BEST CHOICE: CodeLlama-34B-Instruct")
        print("   → Excellent for your use case with available GPUs")
        
        print("2. 🔬 ALTERNATIVE: Qwen2.5-Coder-7B")
        print("   → Code specialist option")
    
    else:
        print("⚠️  Limited GPU availability - consider freeing up more GPUs for better models")
    
    print("\n💡 Pro Tips:")
    print("- Start with 1 epoch for large models (you can always continue training)")
    print("- Use --max_samples 1000 for quick testing first")
    print("- CodeLlama models are specifically designed for code generation")
    print("- Qwen2.5-Coder has excellent scientific computing knowledge")

if __name__ == "__main__":
    recommend_models() 