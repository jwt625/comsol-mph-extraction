#!/usr/bin/env python3
"""
test_llm_approach.py

Simple test to demonstrate the LLM-assisted alignment concept without actual LLM calls.
This shows the improved data structure and semantic understanding.
"""

import json
from pathlib import Path

def simulate_llm_step_extraction(pdf_text_sample):
    """Simulate what an LLM would extract from PDF text."""
    return [
        {
            "step_number": 1,
            "title": "Create Rectangle Geometry",
            "description": "Set up the simulation domain as a 2D rectangle",
            "instructions": "Create a rectangle that will serve as the computational domain for electromagnetic wave propagation. The width should be much larger than height to observe wave behavior.",
            "comsol_ids": ["r1", "geom1"],
            "category": "geometry"
        },
        {
            "step_number": 2,
            "title": "Define Material Properties",
            "description": "Set the material properties for the nonlinear optical medium",
            "instructions": "Configure the material with appropriate refractive index and nonlinear coefficients for second harmonic generation.",
            "comsol_ids": ["mat1"],
            "category": "materials"
        },
        {
            "step_number": 3,
            "title": "Set Up Wave Physics",
            "description": "Configure electromagnetic wave interfaces for fundamental and harmonic frequencies",
            "instructions": "Create two Electromagnetic Waves interfaces - one for the fundamental frequency and one for the second harmonic frequency.",
            "comsol_ids": ["ewfd", "ewfd2"],
            "category": "physics"
        }
    ]

def simulate_llm_code_segmentation(code_sample):
    """Simulate what an LLM would extract from code."""
    return [
        {
            "segment_id": 1,
            "description": "Initialize model and create 2D geometry with rectangle",
            "code": """model = ModelUtil.create('Model');
model.geom.create('geom1', 2);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'sim_l', 'sim_h'});""",
            "comsol_ids": ["geom1", "r1"],
            "category": "geometry"
        },
        {
            "segment_id": 2,
            "description": "Create material with optical properties",
            "code": """model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});""",
            "comsol_ids": ["mat1"],
            "category": "materials"
        },
        {
            "segment_id": 3,
            "description": "Set up electromagnetic wave physics for both frequencies",
            "code": """model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd2').field('electric').field('Ey').set('f', 'f2');""",
            "comsol_ids": ["ewfd", "ewfd2"],
            "category": "physics"
        }
    ]

def simulate_llm_alignment(steps, code_segments):
    """Simulate intelligent alignment between steps and code."""
    return [
        {
            "step_id": 1,
            "code_segment_ids": [1],
            "alignment_confidence": 0.95,
            "reasoning": "Perfect match - both deal with creating rectangle geometry r1"
        },
        {
            "step_id": 2,
            "code_segment_ids": [2],
            "alignment_confidence": 0.90,
            "reasoning": "Both handle material creation mat1 with optical properties"
        },
        {
            "step_id": 3,
            "code_segment_ids": [3],
            "alignment_confidence": 0.92,
            "reasoning": "Both set up electromagnetic wave physics with ewfd and ewfd2 interfaces"
        }
    ]

def simulate_enhanced_examples(steps, code_segments, alignments, metadata):
    """Simulate LLM enhancement of training examples."""
    enhanced = []
    
    for alignment in alignments:
        step = next(s for s in steps if s['step_number'] == alignment['step_id'])
        code_seg = next(s for s in code_segments if s['segment_id'] in alignment['code_segment_ids'])
        
        if alignment['step_id'] == 1:
            enhanced.append({
                "instruction": f"[Model: {metadata['model_name']}] [Physics: Electromagnetic Waves] Create the simulation domain geometry",
                "input": "I need to set up a 2D rectangular domain for modeling second harmonic generation. The domain should be optimized for wave propagation analysis.",
                "output": f"// Create 2D geometry for electromagnetic wave simulation\n{code_seg['code']}\n// The rectangle dimensions are crucial for capturing wave behavior",
                "explanation": "The rectangular geometry serves as the computational domain where electromagnetic waves propagate. The aspect ratio (sim_l >> sim_h) is designed to observe longitudinal wave propagation while minimizing transverse effects.",
                "physics_context": "In nonlinear optics, the interaction length affects conversion efficiency. A longer domain allows more interaction between fundamental and harmonic waves.",
                "parameters": {
                    "sim_l": "Simulation length - must be several wavelengths",
                    "sim_h": "Simulation height - minimal for 2D analysis"
                }
            })
        elif alignment['step_id'] == 2:
            enhanced.append({
                "instruction": f"[Model: {metadata['model_name']}] [Physics: Electromagnetic Waves] Configure nonlinear optical material properties",
                "input": "I need to define a material with nonlinear optical properties for second harmonic generation. What material parameters should I set?",
                "output": f"// Define material for nonlinear optics\n{code_seg['code']}\n// Set nonlinear coefficient for second harmonic generation",
                "explanation": "The material properties determine how electromagnetic waves interact within the medium. For second harmonic generation, we need a material with appropriate nonlinear susceptibility.",
                "physics_context": "Second harmonic generation requires a non-centrosymmetric material where the second-order nonlinear susceptibility χ⁽²⁾ is non-zero.",
                "parameters": {
                    "relpermittivity": "Relative permittivity - affects wave velocity and impedance"
                }
            })
        else:
            enhanced.append({
                "instruction": f"[Model: {metadata['model_name']}] [Physics: Electromagnetic Waves] Set up coupled wave equations for frequency mixing",
                "input": "How do I set up the physics for modeling second harmonic generation with two different frequencies?",
                "output": f"// Configure electromagnetic wave physics for frequency doubling\n{code_seg['code']}\n// Couple fundamental and second harmonic frequencies",
                "explanation": "Two separate Electromagnetic Waves interfaces are needed: one for the fundamental frequency f1 and one for the second harmonic frequency f2=2*f1. They are coupled through nonlinear polarization terms.",
                "physics_context": "In second harmonic generation, energy transfers from the fundamental wave to the harmonic wave through nonlinear polarization P⁽²⁾ = χ⁽²⁾E₁E₁.",
                "parameters": {
                    "f2": "Second harmonic frequency - exactly twice the fundamental frequency"
                }
            })
    
    return enhanced

def main():
    """Demonstrate the improved approach with realistic examples."""
    
    # Simulate input data
    metadata = {
        "model_name": "second_harmonic_generation_frequency_domain",
        "physics": "Electromagnetic Waves",
        "description": "Second harmonic generation in nonlinear optical medium"
    }
    
    # Stage 1: Extract structured information
    print("🔄 Stage 1: Semantic Extraction")
    steps = simulate_llm_step_extraction("sample PDF text")
    code_segments = simulate_llm_code_segmentation("sample code")
    
    print(f"   Extracted {len(steps)} steps and {len(code_segments)} code segments")
    for step in steps:
        print(f"   Step {step['step_number']}: {step['title']} ({step['category']})")
    
    # Stage 2: Intelligent alignment
    print("\n🔄 Stage 2: Intelligent Alignment")
    alignments = simulate_llm_alignment(steps, code_segments)
    
    for alignment in alignments:
        print(f"   Step {alignment['step_id']} ↔ Code {alignment['code_segment_ids']} "
              f"(confidence: {alignment['alignment_confidence']:.2f})")
        print(f"      Reasoning: {alignment['reasoning']}")
    
    # Stage 3: Enhanced training examples
    print("\n🔄 Stage 3: Enhanced Training Examples")
    enhanced_examples = simulate_enhanced_examples(steps, code_segments, alignments, metadata)
    
    print(f"   Generated {len(enhanced_examples)} enhanced training examples")
    
    # Show example output
    print("\n📄 Sample Enhanced Training Example:")
    example = enhanced_examples[0]
    print(f"Instruction: {example['instruction']}")
    print(f"Input: {example['input']}")
    print(f"Output:\n{example['output']}")
    print(f"Explanation: {example['explanation']}")
    print(f"Physics Context: {example['physics_context']}")
    
    # Save results
    output_path = Path("demo_enhanced_output.jsonl")
    with open(output_path, 'w') as f:
        for example in enhanced_examples:
            f.write(json.dumps(example) + '\n')
    
    print(f"\n✅ Demo complete! Results saved to {output_path}")
    print("\n🎯 Key Improvements:")
    print("   • Semantic alignment based on COMSOL IDs and functionality")
    print("   • Physics context and parameter explanations")
    print("   • Clear connection between modeling intent and implementation")
    print("   • Enhanced instructions that explain 'why' not just 'how'")

if __name__ == "__main__":
    main() 