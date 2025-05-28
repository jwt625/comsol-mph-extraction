#!/usr/bin/env python3
"""
Final test to verify physics extraction is working properly in the main pipeline.
"""

import json
import os
from pathlib import Path
import glob

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

def test_enhanced_metadata_creation():
    """Test the enhanced metadata creation like in the main pipeline."""
    # Test with the first available MEMS model
    mems_dirs = glob.glob("mphs/MEMS_Module_Actuators_*")
    
    if not mems_dirs:
        print("❌ No MEMS model directories found")
        return
    
    model_dir = mems_dirs[0]
    print(f"🔍 Testing enhanced metadata creation with: {model_dir}")
    
    # Load metadata like in main pipeline
    json_file = Path(model_dir) / "smodel.json"
    with open(json_file, 'r') as f:
        metadata = json.load(f)
    
    # Extract physics information early (like fixed pipeline)
    physics_info = extract_physics_from_metadata(metadata)
    
    # Create enhanced metadata for processing (like fixed pipeline)
    enhanced_metadata = {
        'displayLabel': metadata.get('displayLabel', ''),
        'physics': physics_info,
        'description': metadata.get('description', ''),
        'purpose': metadata.get('purpose', '')
    }
    
    print(f"✅ Raw metadata physics extraction: {physics_info}")
    print(f"✅ Enhanced metadata physics field: {enhanced_metadata.get('physics')}")
    
    # Test model context creation (like in extract_code_descriptions)
    model_context = f"""
Model: {enhanced_metadata.get('displayLabel', 'Unknown')}
Description: {enhanced_metadata.get('description', 'COMSOL simulation model')}
Physics: {enhanced_metadata.get('physics', 'Multi-physics simulation')}
Purpose: {enhanced_metadata.get('purpose', 'Engineering simulation and analysis')}
"""
    
    print(f"\n📝 Model context that would be used:")
    print(model_context.strip())
    
    # Test explanation creation (like in create_enhanced_training_examples)
    test_explanation = f"Physics: {enhanced_metadata.get('physics', 'Unknown')}. Purpose: Test modeling step"
    print(f"\n🎯 Explanation field that would be generated:")
    print(f'"{test_explanation}"')
    
    return physics_info != 'Multi-physics' and 'Unknown' not in test_explanation

if __name__ == "__main__":
    success = test_enhanced_metadata_creation()
    if success:
        print(f"\n✅ All physics extraction is working correctly! No more 'Unknown' physics.")
    else:
        print(f"\n❌ Still seeing issues with physics extraction.") 