#!/usr/bin/env python3
"""
test_llm_endpoint.py

Test the actual prompting strategies we'll use in the LLM-assisted alignment pipeline.
"""

import os
import json
import re
import openai
from anthropic import Anthropic


def extract_json_from_response(response: str):
    """Extract JSON from LLM response that may contain extra text."""
    if not response:
        return None
    
    # Try to find JSON in the response
    json_patterns = [
        r'\{.*\}',  # Single object
        r'\[.*\]',  # Array
    ]
    
    for pattern in json_patterns:
        matches = re.findall(pattern, response, re.DOTALL)
        for match in matches:
            try:
                return json.loads(match)
            except json.JSONDecodeError:
                continue
    
    # Try parsing the whole response
    try:
        return json.loads(response.strip())
    except json.JSONDecodeError:
        return None


def test_code_description_prompt(model_name="hermes3-405b"):
    """Test the actual code description prompt we'll use."""
    print(f"\n🔍 Testing code description prompt with {model_name}...")
    
    try:
        client = openai.OpenAI(
            api_key=os.getenv("LLM_API_KEY"),
            base_url=os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
        )
        
        # Real COMSOL code segment
        sample_code = """model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.1, 0.05]);
model.geom('geom1').feature('r1').set('pos', [0, 0]);"""
        
        # Actual prompt from our pipeline
        prompt = f"""
IMPORTANT: Return ONLY valid JSON, no explanations or markdown.

Analyze this COMSOL code segment and describe what it does:

{sample_code}

Return JSON format:
{{
    "segment_id": 1,
    "start_line": 1,
    "end_line": 3,
    "code_description": "Brief description of what this code accomplishes",
    "modeling_purpose": "Why this step is needed in the simulation",
    "comsol_ids": ["id1", "id2"],
    "category": "geometry|materials|physics|boundary_conditions|mesh|study|results|parameters|other",
    "key_operations": ["action1", "action2"]
}}
"""
        
        print("   📤 Sending code description request...")
        response = client.chat.completions.create(
            model=model_name,
            messages=[{"role": "user", "content": prompt}],
            max_tokens=1000,
            temperature=0.1
        )
        
        response_text = response.choices[0].message.content
        print(f"   📥 Raw response: {response_text[:150]}...")
        
        # Test JSON extraction
        json_result = extract_json_from_response(response_text)
        if json_result:
            print("   ✅ JSON extraction successful!")
            print(f"   📋 Code description: {json_result.get('code_description', 'N/A')}")
            print(f"   🎯 Category: {json_result.get('category', 'N/A')}")
            print(f"   🔧 COMSOL IDs: {json_result.get('comsol_ids', [])}")
            return True
        else:
            print("   ❌ JSON extraction failed")
            return False
            
    except Exception as e:
        print(f"   ❌ Test failed: {str(e)}")
        return False


def test_pdf_extraction_prompt(model_name="hermes3-405b"):
    """Test the PDF section extraction prompt."""
    print(f"\n🔍 Testing PDF extraction prompt with {model_name}...")
    
    try:
        client = openai.OpenAI(
            api_key=os.getenv("LLM_API_KEY"),
            base_url=os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
        )
        
        # Sample PDF text
        sample_text = """
Modeling Instructions

Rectangle (r1)
Create a rectangle that will serve as the computational domain for the electromagnetic simulation.
Set the width to 0.1 m and height to 0.05 m.

Material Properties (mat1)  
Add a dielectric material with relative permittivity of 4.5.
This material will fill the rectangular domain.

Physics Setup (emw)
Define electromagnetic wave physics for the frequency domain analysis.
Set up perfect electric conductor boundary conditions.
"""
        
        prompt = f"""
IMPORTANT: Return ONLY valid JSON, no explanations or markdown.

Extract instructional steps from this COMSOL tutorial:

{sample_text}

Return JSON format:
[
    {{
        "section_id": 1,
        "title": "Step title",
        "instructions": "Detailed instructions",
        "comsol_ids": ["id1"],
        "purpose": "Purpose of this step",
        "keywords": ["key1", "key2"]
    }}
]
"""
        
        print("   📤 Sending PDF extraction request...")
        response = client.chat.completions.create(
            model=model_name,
            messages=[{"role": "user", "content": prompt}],
            max_tokens=1500,
            temperature=0.1
        )
        
        response_text = response.choices[0].message.content
        print(f"   📥 Raw response: {response_text[:150]}...")
        
        # Test JSON extraction
        json_result = extract_json_from_response(response_text)
        if json_result and isinstance(json_result, list):
            print("   ✅ JSON extraction successful!")
            print(f"   📋 Extracted {len(json_result)} sections:")
            for i, section in enumerate(json_result[:2]):  # Show first 2
                print(f"      {i+1}. {section.get('title', 'N/A')}")
                print(f"         IDs: {section.get('comsol_ids', [])}")
            return True
        else:
            print("   ❌ JSON extraction failed or not a list")
            return False
            
    except Exception as e:
        print(f"   ❌ Test failed: {str(e)}")
        return False


def test_model_comparison():
    """Compare different models for our task."""
    print("\n🔍 Comparing models for COMSOL analysis...")
    
    models_to_test = [
        "hermes3-405b",      # Best reasoning
        "qwen25-coder-32b-instruct",  # Code specialist
        "llama3.3-70b-instruct-fp8",  # Good general model
    ]
    
    results = {}
    
    for model in models_to_test:
        print(f"\n   Testing {model}...")
        try:
            code_result = test_code_description_prompt(model)
            pdf_result = test_pdf_extraction_prompt(model)
            
            results[model] = {
                "code_analysis": code_result,
                "pdf_extraction": pdf_result,
                "overall": code_result and pdf_result
            }
            
            if results[model]["overall"]:
                print(f"   ✅ {model}: Both tests passed")
            else:
                print(f"   ⚠️  {model}: Some tests failed")
                
        except Exception as e:
            print(f"   ❌ {model}: Error - {str(e)}")
            results[model] = {"code_analysis": False, "pdf_extraction": False, "overall": False}
    
    return results


def test_simple_segmentation():
    """Test code segmentation logic without LLM."""
    print("\n🔍 Testing improved code segmentation...")
    
    sample_code = """
% Sample COMSOL script
model = ModelUtil.create('Model');

% Create geometry
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.1, 0.05]);

% Add materials  
model.material.create('mat1', 'Common');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.5'});

% Define physics
model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').create('pec1', 'PerfectElectricConductor', 1);

% Create mesh
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run();

% Run study
model.study('std1').create('freq', 'Frequency');
model.study('std1').run();
"""
    
    # Improved segmentation logic
    lines = sample_code.split('\n')
    segments = []
    current_segment = []
    segment_id = 1
    
    for i, line in enumerate(lines):
        line_stripped = line.strip()
        
        # Skip empty lines and comments at segment boundaries
        if not line_stripped or line_stripped.startswith('%'):
            current_segment.append(line)
            continue
        
        # Start new segment on major model operations
        if (line_stripped.startswith('model.') and current_segment and 
            any(op in line_stripped for op in ['.create(', '.geom(', '.material(', '.physics(', '.mesh(', '.study('])):
            
            # Save previous segment if it has content
            code_block = '\n'.join(current_segment).strip()
            if code_block and not code_block.startswith('%'):
                segments.append({
                    "segment_id": segment_id,
                    "start_line": i - len(current_segment) + 1,
                    "end_line": i,
                    "code": code_block
                })
                segment_id += 1
            
            current_segment = [line]
        else:
            current_segment.append(line)
    
    # Add final segment
    if current_segment:
        code_block = '\n'.join(current_segment).strip()
        if code_block and not code_block.startswith('%'):
            segments.append({
                "segment_id": segment_id,
                "start_line": len(lines) - len(current_segment) + 1,
                "end_line": len(lines),
                "code": code_block
            })
    
    print(f"   ✅ Created {len(segments)} segments from sample code")
    for i, seg in enumerate(segments):
        preview = seg['code'][:60].replace('\n', ' ')
        print(f"   📦 Segment {i+1}: Lines {seg['start_line']}-{seg['end_line']}")
        print(f"      Preview: {preview}...")
    
    return len(segments)


def test_api_key_env():
    """Test if environment variables are set."""
    print("🔍 Testing environment variables...")
    
    api_key = os.getenv("LLM_API_KEY")
    api_base = os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
    
    if api_key:
        print(f"   ✅ LLM_API_KEY found: {api_key[:10]}...")
    else:
        print("   ⚠️  LLM_API_KEY not found")
    
    print(f"   📡 API Base URL: {api_base}")
    
    return bool(api_key)


def main():
    print("🧪 COMSOL LLM Pipeline Testing Suite")
    print("=" * 60)
    
    # Test 1: Environment setup
    env_ok = test_api_key_env()
    
    if not env_ok:
        print("\n⚠️  Set LLM_API_KEY environment variable first")
        print("   export LLM_API_KEY='your_lambda_ai_key'")
        return
    
    # Test 2: Segmentation logic
    segments_count = test_simple_segmentation()
    
    # Test 3: Model comparison
    model_results = test_model_comparison()
    
    # Test 4: Summary and recommendations
    print("\n📊 Test Results Summary")
    print("=" * 60)
    print(f"Environment: ✅ OK")
    print(f"Segmentation: ✅ OK ({segments_count} segments)")
    
    print("\nModel Performance:")
    for model, results in model_results.items():
        status = "✅ PASS" if results["overall"] else "❌ FAIL"
        print(f"   {model}: {status}")
        print(f"      Code Analysis: {'✅' if results['code_analysis'] else '❌'}")
        print(f"      PDF Extraction: {'✅' if results['pdf_extraction'] else '❌'}")
    
    # Recommendation
    best_models = [model for model, results in model_results.items() if results["overall"]]
    
    if best_models:
        print(f"\n🚀 Recommended model: {best_models[0]}")
        print("   Ready to run full pipeline!")
    else:
        print("\n⚠️  No models passed all tests - may need prompt adjustments")


if __name__ == "__main__":
    main() 