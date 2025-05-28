#!/usr/bin/env python3
"""
Quick test script to verify physics extraction works correctly.
Processes just a few code segments to check the output format.
"""

import json
import os
from pathlib import Path

def extract_physics_from_metadata(metadata):
    """Extract physics types from metadata by finding apiClass: Physics entries."""
    physics_types = []
    
    def find_physics_in_nodes(nodes):
        if not isinstance(nodes, list):
            return
        
        for node in nodes:
            if isinstance(node, dict):
                if node.get('apiClass') == 'Physics':
                    api_type = node.get('apiType', '')
                    if api_type:
                        physics_types.append(api_type)
                
                # Recursively check child nodes
                if 'nodes' in node:
                    find_physics_in_nodes(node['nodes'])
    
    # Search through the metadata structure
    if 'nodes' in metadata:
        find_physics_in_nodes(metadata['nodes'])
    
    if physics_types:
        return ', '.join(physics_types)
    else:
        return 'Multi-physics'

def simple_code_segmentation(code):
    """Simple code segmentation - just take first few lines."""
    lines = code.split('\n')
    segments = []
    
    # Create a few test segments
    for i in range(0, min(30, len(lines)), 10):  # Take chunks of 10 lines
        segment_lines = lines[i:i+10]
        code_block = '\n'.join(segment_lines).strip()
        if code_block:
            segments.append({
                "segment_id": len(segments) + 1,
                "start_line": i + 1,
                "end_line": min(i + 10, len(lines)),
                "code": code_block,
                "code_description": f"COMSOL modeling step {len(segments) + 1}",
                "modeling_purpose": "Test modeling step",
                "category": "other",
                "comsol_ids": []
            })
    
    return segments[:3]  # Just return first 3 segments

def main():
    # Test with the MEMS model
        # Test with the first available MEMS model we can find
    import glob
    mems_dirs = glob.glob("mphs/MEMS_Module_Actuators_*")
    
    if not mems_dirs:
        print("❌ No MEMS model directories found")
        return
    
    model_dir = mems_dirs[0]  # Use first available
    print(f"🔍 Testing with model: {model_dir}")
    
    if not os.path.exists(model_dir):
        print(f"❌ Model directory not found: {model_dir}")
        return
    
    # Load metadata
    json_file = Path(model_dir) / "smodel.json"
    with open(json_file, 'r') as f:
        metadata = json.load(f)
    
    # Extract physics information
    physics = extract_physics_from_metadata(metadata)
    print(f"✅ Extracted Physics: {physics}")
    
    # Load and segment code
    m_files = list(Path(model_dir).glob("*.m"))
    if m_files:
        with open(m_files[0], 'r') as f:
            code = f.read()
        
        code_segments = simple_code_segmentation(code)
        print(f"✅ Created {len(code_segments)} test segments")
        
        # Create test training examples
        examples = []
        for code_seg in code_segments:
            example = {
                "instruction": f"[{metadata.get('displayLabel', 'Model')}] {code_seg.get('code_description', 'COMSOL modeling step')}",
                "input": f"Test input for segment {code_seg['segment_id']}",
                "output": code_seg['code'],
                "explanation": f"Physics: {physics}. Purpose: {code_seg.get('modeling_purpose', 'Modeling step')}",
                "confidence": 0.5,
                "source": "quick_test",
                "category": code_seg.get('category', 'other'),
                "match_info": "Quick test without LLM",
                "comsol_ids": code_seg.get('comsol_ids', [])
            }
            examples.append(example)
        
        # Save test results
        output_file = "quick_physics_test_result.jsonl"
        with open(output_file, 'w') as f:
            for example in examples:
                f.write(json.dumps(example) + '\n')
        
        print(f"✅ Saved {len(examples)} test examples to {output_file}")
        
        # Show first example
        print(f"\n📝 Sample output:")
        print(f"Physics: {physics}")
        print(f"Instruction: {examples[0]['instruction']}")
        print(f"Explanation: {examples[0]['explanation']}")
        
    else:
        print("❌ No .m files found")

if __name__ == "__main__":
    main()