#!/usr/bin/env python3
"""
test_performance.py

Test LLM call performance and optimize the pipeline for speed.
"""

import time
import os
import openai
import asyncio
import concurrent.futures
from typing import List
import statistics

def test_sequential_calls(model_name="hermes3-405b", num_calls=10):
    """Test sequential LLM calls to measure baseline performance."""
    print(f"🔍 Testing {num_calls} sequential calls to {model_name}...")
    
    client = openai.OpenAI(
        api_key=os.getenv("LLM_API_KEY"),
        base_url=os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
    )
    
    prompt = """
Analyze this COMSOL code and return JSON:
model.geom('geom1').create('r1', 'Rectangle');

{
    "code_description": "Creates a rectangle geometry",
    "category": "geometry"
}
"""
    
    times = []
    successful_calls = 0
    
    for i in range(num_calls):
        start_time = time.time()
        try:
            response = client.chat.completions.create(
                model=model_name,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=200,
                temperature=0.1,
                timeout=30.0
            )
            end_time = time.time()
            call_time = end_time - start_time
            times.append(call_time)
            successful_calls += 1
            print(f"   Call {i+1}: {call_time:.2f}s")
        except Exception as e:
            end_time = time.time()
            print(f"   Call {i+1}: FAILED ({end_time - start_time:.2f}s) - {str(e)[:50]}...")
    
    if times:
        avg_time = statistics.mean(times)
        print(f"\n📊 Sequential Results:")
        print(f"   Success rate: {successful_calls}/{num_calls} ({successful_calls/num_calls*100:.1f}%)")
        print(f"   Average time: {avg_time:.2f}s per call")
        print(f"   Calls per minute: {60/avg_time:.1f}")
        print(f"   Time for 381 segments: {381 * avg_time / 60:.1f} minutes")
        return avg_time
    else:
        print("   ❌ All calls failed")
        return None

def test_parallel_calls(model_name="hermes3-405b", num_calls=10, max_workers=5):
    """Test parallel LLM calls using ThreadPoolExecutor."""
    print(f"\n🔍 Testing {num_calls} parallel calls to {model_name} (max {max_workers} workers)...")
    
    client = openai.OpenAI(
        api_key=os.getenv("LLM_API_KEY"),
        base_url=os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
    )
    
    prompt = """
Analyze this COMSOL code and return JSON:
model.geom('geom1').create('r1', 'Rectangle');

{
    "code_description": "Creates a rectangle geometry",
    "category": "geometry"
}
"""
    
    def make_llm_call(call_id):
        start_time = time.time()
        try:
            response = client.chat.completions.create(
                model=model_name,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=200,
                temperature=0.1,
                timeout=30.0
            )
            end_time = time.time()
            return {
                'call_id': call_id,
                'success': True,
                'time': end_time - start_time,
                'error': None
            }
        except Exception as e:
            end_time = time.time()
            return {
                'call_id': call_id,
                'success': False,
                'time': end_time - start_time,
                'error': str(e)[:50]
            }
    
    start_total = time.time()
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = [executor.submit(make_llm_call, i) for i in range(num_calls)]
        results = [future.result() for future in concurrent.futures.as_completed(futures)]
    
    end_total = time.time()
    total_time = end_total - start_total
    
    successful_results = [r for r in results if r['success']]
    failed_results = [r for r in results if not r['success']]
    
    print(f"\n📊 Parallel Results:")
    print(f"   Total time: {total_time:.2f}s")
    print(f"   Success rate: {len(successful_results)}/{num_calls} ({len(successful_results)/num_calls*100:.1f}%)")
    
    if successful_results:
        times = [r['time'] for r in successful_results]
        avg_time = statistics.mean(times)
        print(f"   Average call time: {avg_time:.2f}s")
        print(f"   Effective calls per second: {len(successful_results)/total_time:.2f}")
        print(f"   Time for 381 segments: {381 / (len(successful_results)/total_time) / 60:.1f} minutes")
    
    if failed_results:
        print(f"   Failed calls: {len(failed_results)}")
        for r in failed_results[:3]:  # Show first 3 errors
            print(f"      Call {r['call_id']}: {r['error']}...")
    
    return total_time, len(successful_results)

def test_different_models():
    """Test different models to find the fastest one."""
    models = [
        "llama3.3-70b-instruct-fp8",  # Smaller, should be faster
        "qwen25-coder-32b-instruct",  # Code specialist, smaller
        "hermes3-70b",                # Medium size
        "hermes3-405b",               # Largest
    ]
    
    print(f"\n🔍 Testing different models for speed...")
    
    results = {}
    
    for model in models:
        print(f"\n   Testing {model}...")
        try:
            avg_time = test_sequential_calls(model, num_calls=3)
            results[model] = avg_time
        except Exception as e:
            print(f"      ❌ {model} failed: {str(e)[:50]}...")
            results[model] = None
    
    print(f"\n📊 Model Performance Comparison:")
    sorted_models = sorted([(k, v) for k, v in results.items() if v is not None], key=lambda x: x[1])
    
    for model, avg_time in sorted_models:
        calls_per_min = 60 / avg_time if avg_time else 0
        print(f"   {model}: {avg_time:.2f}s/call ({calls_per_min:.1f} calls/min)")
    
    if sorted_models:
        fastest_model, fastest_time = sorted_models[0]
        print(f"\n🚀 Fastest model: {fastest_model}")
        print(f"   Time for 381 segments: {381 * fastest_time / 60:.1f} minutes")
        return fastest_model
    
    return None

def test_batch_processing():
    """Test processing multiple code segments in a single LLM call."""
    print(f"\n🔍 Testing batch processing (multiple segments per call)...")
    
    client = openai.OpenAI(
        api_key=os.getenv("LLM_API_KEY"),
        base_url=os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
    )
    
    # Test processing 5 segments at once
    batch_prompt = """
Analyze these 5 COMSOL code segments and return JSON array:

1. model.geom('geom1').create('r1', 'Rectangle');
2. model.geom('geom1').feature('r1').set('size', [0.1, 0.05]);
3. model.material.create('mat1', 'Common');
4. model.physics.create('solid', 'SolidMechanics', 'geom1');
5. model.mesh.create('mesh1', 'geom1');

Return as JSON array:
[
    {"id": 1, "description": "Creates rectangle geometry", "category": "geometry"},
    {"id": 2, "description": "Sets rectangle size", "category": "geometry"},
    ...
]
"""
    
    start_time = time.time()
    try:
        response = client.chat.completions.create(
            model="llama3.3-70b-instruct-fp8",  # Use faster model
            messages=[{"role": "user", "content": batch_prompt}],
            max_tokens=1000,
            temperature=0.1,
            timeout=30.0
        )
        end_time = time.time()
        
        batch_time = end_time - start_time
        print(f"   Batch processing 5 segments: {batch_time:.2f}s")
        print(f"   Time per segment: {batch_time/5:.2f}s")
        print(f"   Estimated time for 381 segments: {381 * batch_time / 5 / 60:.1f} minutes")
        
        # Try to parse response
        print(f"   Response preview: {response.choices[0].message.content[:200]}...")
        
        return batch_time / 5  # Time per segment
        
    except Exception as e:
        print(f"   ❌ Batch processing failed: {str(e)}")
        return None

def main():
    print("⚡ LLM Performance Analysis")
    print("=" * 60)
    
    # Test 1: Sequential calls with current model
    seq_time = test_sequential_calls("hermes3-405b", num_calls=5)
    
    # Test 2: Parallel calls
    if seq_time:
        test_parallel_calls("hermes3-405b", num_calls=10, max_workers=3)
    
    # Test 3: Different models
    fastest_model = test_different_models()
    
    # Test 4: Batch processing
    batch_time = test_batch_processing()
    
    # Summary and recommendations
    print(f"\n🎯 Performance Optimization Recommendations:")
    print("=" * 60)
    
    if fastest_model and fastest_model != "hermes3-405b":
        print(f"1. 🚀 Switch to faster model: {fastest_model}")
    
    if batch_time and seq_time and batch_time < seq_time:
        print(f"2. 📦 Use batch processing: {batch_time:.2f}s vs {seq_time:.2f}s per segment")
    
    print(f"3. 🔄 Use parallel processing with 3-5 workers")
    print(f"4. 💰 Limit LLM calls to first 50 segments, use patterns for rest")
    print(f"5. ⚡ Reduce max_tokens to 300-500 for faster responses")

if __name__ == "__main__":
    main() 