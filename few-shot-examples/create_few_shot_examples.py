#!/usr/bin/env python3
"""
create_few_shot_examples.py

Generate high-level COMSOL model descriptions paired with complete MATLAB scripts
for few-shot prompting. This creates comprehensive model summaries instead of 
line-by-line code explanations.
"""

import os
import re
import json
import glob
import argparse
from pathlib import Path
from pdfminer.high_level import extract_text
from typing import List, Dict, Tuple, Optional
import openai
from concurrent.futures import ThreadPoolExecutor, as_completed
import time


class HighLevelExampleGenerator:
    def __init__(self, llm_provider="lambda", api_key=None, api_base=None):
        self.llm_provider = llm_provider
        
        if llm_provider == "lambda":
            # Lambda AI endpoint using OpenAI-compatible API
            self.client = openai.OpenAI(
                api_key=api_key or os.getenv("LLM_API_KEY"),
                base_url=api_base or os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
            )
        else:
            raise ValueError("Currently only supporting 'lambda' provider")

    def _call_llm(self, prompt: str, model: str = "hermes3-70b") -> str:
        """Call the LLM with the given prompt."""
        try:
            response = self.client.chat.completions.create(
                model=model,
                messages=[{"role": "user", "content": prompt}],
                temperature=0.3,
                max_tokens=4000,
            )
            return response.choices[0].message.content.strip()
        except Exception as e:
            print(f"   ⚠️ LLM call failed: {e}")
            return ""

    def extract_model_metadata(self, m_path: str, pdf_path: str = None) -> Dict:
        """Extract basic metadata about the model."""
        # Extract from file path
        path_parts = Path(m_path).parts
        model_name = Path(m_path).stem
        
        # Try to extract module and category from path
        module = "Unknown_Module"
        category = "Unknown_Category"
        
        for part in path_parts:
            if "_Module" in part:
                module = part
            elif part not in ["mphs", "models", model_name + ".m"]:
                category = part
        
        metadata = {
            "model_name": model_name,
            "module": module,
            "category": category,
            "file_path": str(m_path)
        }
        
        # If PDF exists, extract additional info
        if pdf_path and os.path.exists(pdf_path):
            try:
                pdf_text = extract_text(pdf_path)
                # Extract title and description from PDF
                lines = pdf_text.split('\n')[:20]  # First 20 lines usually contain title/description
                
                for line in lines:
                    line = line.strip()
                    if len(line) > 20 and not line.isupper():  # Skip headers
                        metadata["description"] = line
                        break
                        
            except Exception as e:
                print(f"   ⚠️ PDF extraction failed: {e}")
        
        return metadata

    def analyze_code_segments(self, code: str) -> List[Dict]:
        """Segment the code into functional blocks for detailed analysis."""
        lines = code.split('\n')
        segments = []
        current_segment = []
        current_segment_type = "unknown"
        
        # Define patterns that indicate new segments
        segment_patterns = {
            'model_creation': r'model\s*=\s*ModelUtil\.create',
            'geometry': r'model\.geom\(',
            'material': r'model\.material\(',
            'physics': r'model\.physics\(',
            'mesh': r'model\.mesh\(',
            'study': r'model\.study\(',
            'solver': r'model\.sol\(',
            'results': r'model\.result\(',
            'parameters': r'model\.param\(',
            'variables': r'model\.variable\(',
            'component': r'model\.component\(',
            'selection': r'model\.selection\(',
            'function': r'model\.func\(',
        }
        
        for i, line in enumerate(lines):
            line_stripped = line.strip()
            if not line_stripped or line_stripped.startswith('%'):
                current_segment.append((i+1, line))
                continue
            
            # Check if this line starts a new segment
            new_segment_type = None
            for seg_type, pattern in segment_patterns.items():
                if re.search(pattern, line_stripped):
                    new_segment_type = seg_type
                    break
            
            # If we found a new segment type and we have a current segment, save it
            if new_segment_type and current_segment and new_segment_type != current_segment_type:
                segments.append({
                    'type': current_segment_type,
                    'start_line': current_segment[0][0],
                    'end_line': current_segment[-1][0],
                    'lines': current_segment,
                    'code': '\n'.join([l[1] for l in current_segment])
                })
                current_segment = []
            
            current_segment.append((i+1, line))
            if new_segment_type:
                current_segment_type = new_segment_type
        
        # Add the last segment
        if current_segment:
            segments.append({
                'type': current_segment_type,
                'start_line': current_segment[0][0],
                'end_line': current_segment[-1][0],
                'lines': current_segment,
                'code': '\n'.join([l[1] for l in current_segment])
            })
        
        return segments

    def generate_detailed_segment_description(self, segment: Dict, metadata: Dict) -> str:
        """Generate detailed description for a code segment."""
        
        prompt = f"""
Analyze this COMSOL MATLAB code segment and provide a VERY DETAILED, almost line-by-line explanation.

Model Context:
- Name: {metadata.get('model_name', 'Unknown')}
- Module: {metadata.get('module', 'Unknown')}
- Segment Type: {segment['type']}
- Lines: {segment['start_line']}-{segment['end_line']}

Code Segment:
```matlab
{segment['code']}
```

Provide a detailed explanation that includes:

1. **Purpose**: What is this code segment accomplishing?
2. **Step-by-Step Analysis**: Go through the code almost line-by-line, explaining:
   - What each major command does
   - What parameters are being set and why
   - What properties or configurations are being defined
   - How each line contributes to the overall modeling goal
3. **COMSOL Context**: Explain the COMSOL-specific commands and their significance
4. **Physical Meaning**: What does this represent in the physical simulation?
5. **Dependencies**: How does this segment relate to other parts of the model?

Be very specific about parameter values, object names, and the purpose of each configuration. Explain technical details that a COMSOL expert would need to understand the implementation.
"""
        
        response = self._call_llm(prompt)
        return response

    def generate_comprehensive_model_description(self, m_path: str, metadata: Dict) -> str:
        """Generate a comprehensive, detailed description of the entire COMSOL model."""
        
        # Read the complete MATLAB code
        with open(m_path, 'r') as f:
            full_code = f.read()
        
        # Analyze code segments
        print("   📊 Analyzing code segments...")
        segments = self.analyze_code_segments(full_code)
        print(f"   📝 Found {len(segments)} functional segments")
        
        # Generate high-level overview first
        overview_prompt = f"""
Analyze this complete COMSOL MATLAB script and provide a high-level overview.

Model Information:
- Name: {metadata.get('model_name', 'Unknown')}
- Module: {metadata.get('module', 'Unknown')}
- Category: {metadata.get('category', 'Unknown')}

Complete MATLAB Code:
```matlab
{full_code}
```

Provide a comprehensive overview including:
1. **Model Overview**: What physical phenomena is being simulated?
2. **Engineering Application**: What real-world problem does this solve?
3. **Key Physics**: What physics interfaces and equations are involved?
4. **Geometry Summary**: What is the geometric setup?
5. **Analysis Type**: What type of study is performed?
6. **Expected Outputs**: What results does this model produce?

Keep this section concise but comprehensive.
"""
        
        overview = self._call_llm(overview_prompt)
        
        # Generate detailed descriptions for each segment
        detailed_descriptions = []
        for i, segment in enumerate(segments, 1):
            print(f"   🔍 Analyzing segment {i}/{len(segments)}: {segment['type']}")
            seg_description = self.generate_detailed_segment_description(segment, metadata)
            if seg_description:
                detailed_descriptions.append({
                    'type': segment['type'],
                    'start_line': segment['start_line'],
                    'end_line': segment['end_line'],
                    'description': seg_description,
                    'code': segment['code']
                })
        
        # Combine everything into a comprehensive description
        full_description = f"""# Model Overview

{overview}

# Detailed Code Analysis

The MATLAB script is organized into {len(detailed_descriptions)} functional segments:

"""
        
        for i, seg_desc in enumerate(detailed_descriptions, 1):
            full_description += f"""## Segment {i}: {seg_desc['type'].replace('_', ' ').title()} (Lines {seg_desc['start_line']}-{seg_desc['end_line']})

{seg_desc['description']}

"""
        
        return full_description

    def generate_basic_description(self, m_path: str, metadata: Dict) -> str:
        """Generate a basic description without LLM (fallback)."""
        with open(m_path, 'r') as f:
            code = f.read()
        
        # Extract some basic info from code
        lines = code.split('\n')
        
        description = f"""
**Model Overview**: This is a {metadata.get('module', 'COMSOL')} simulation model for {metadata.get('category', 'engineering analysis')}.

**Model Name**: {metadata.get('model_name', 'Unknown')}

**Code Analysis**: The MATLAB script contains {len(lines)} lines of code implementing a COMSOL simulation setup.

**Key Components**:
- Model creation and geometry definition
- Material property assignment
- Physics interface setup
- Boundary condition specification
- Mesh generation
- Study configuration and solving

**Engineering Application**: This model is designed for simulation and analysis in the {metadata.get('module', 'engineering')} domain.
"""
        return description.strip()

    def clean_matlab_code(self, code: str) -> str:
        """Clean and format the MATLAB code for better presentation."""
        # Remove excessive whitespace
        lines = []
        for line in code.split('\n'):
            stripped = line.rstrip()
            if stripped or (lines and lines[-1].strip()):  # Keep empty lines only if previous line has content
                lines.append(stripped)
        
        # Remove trailing empty lines
        while lines and not lines[-1].strip():
            lines.pop()
        
        return '\n'.join(lines)

    def process_single_model(self, m_path: str) -> Optional[Dict]:
        """Process a single model to create a description-code pair."""
        try:
            print(f"📁 Processing: {Path(m_path).name}")
            
            # Find corresponding PDF
            pdf_path = m_path.replace('.m', '.pdf')
            if not os.path.exists(pdf_path):
                # Try alternative PDF locations
                pdf_candidates = [
                    m_path.replace('.m', '.pdf'),
                    str(Path(m_path).parent / f"models.*.{Path(m_path).stem}.pdf"),
                ]
                
                for pattern in pdf_candidates:
                    matches = glob.glob(pattern)
                    if matches:
                        pdf_path = matches[0]
                        break
                else:
                    pdf_path = None
            
            # Extract metadata
            metadata = self.extract_model_metadata(m_path, pdf_path)
            
            # Generate comprehensive description
            print("   🤖 Generating model description...")
            description = self.generate_comprehensive_model_description(m_path, metadata)
            
            if not description:
                print("   🔄 Using basic description fallback...")
                description = self.generate_basic_description(m_path, metadata)
            
            if not description:
                print("   ❌ Failed to generate any description")
                return None
            
            # Read and clean the MATLAB code
            with open(m_path, 'r') as f:
                matlab_code = self.clean_matlab_code(f.read())
            
            # Create the example pair
            example = {
                "model_name": metadata["model_name"],
                "module": metadata["module"],
                "category": metadata["category"],
                "description": description,
                "matlab_code": matlab_code,
                "file_path": str(m_path)
            }
            
            print(f"   ✅ Generated example ({len(description)} chars description, {len(matlab_code)} chars code)")
            return example
            
        except Exception as e:
            print(f"   ❌ Error processing {m_path}: {e}")
            return None

    def process_models(self, data_dir: str, max_examples: int = 50, output_file: str = "few_shot_examples.md") -> List[Dict]:
        """Process multiple models to create few-shot examples."""
        
        # Find all MATLAB files
        matlab_files = glob.glob(os.path.join(data_dir, "**/*.m"), recursive=True)
        print(f"🔍 Found {len(matlab_files)} MATLAB files")
        
        # Limit the number of files to process
        if len(matlab_files) > max_examples:
            print(f"📏 Limiting to {max_examples} examples")
            matlab_files = matlab_files[:max_examples]
        
        examples = []
        
        # Process files sequentially for now (can parallelize later if needed)
        for i, m_path in enumerate(matlab_files, 1):
            print(f"\n📊 Progress: {i}/{len(matlab_files)}")
            
            example = self.process_single_model(m_path)
            if example:
                examples.append(example)
            
            # Save intermediate results every 10 examples
            if i % 10 == 0:
                self.save_examples_to_markdown(examples, f"intermediate_{output_file}")
                print(f"   💾 Saved intermediate results ({len(examples)} examples)")
        
        # Save final results
        self.save_examples_to_markdown(examples, output_file)
        print(f"\n✅ Generated {len(examples)} few-shot examples")
        print(f"📄 Saved to: {output_file}")
        
        return examples

    def save_examples_to_markdown(self, examples: List[Dict], output_file: str):
        """Save examples to a markdown file for few-shot prompting."""
        
        with open(output_file, 'w') as f:
            f.write("# COMSOL Few-Shot Examples (Detailed Analysis)\n\n")
            f.write("This file contains highly detailed model descriptions paired with complete MATLAB scripts ")
            f.write("for few-shot prompting with language models. Each description includes segment-by-segment ")
            f.write("analysis of the code.\n\n")
            f.write(f"**Total Examples:** {len(examples)}\n\n")
            f.write("---\n\n")
            
            for i, example in enumerate(examples, 1):
                f.write(f"# Example {i}: {example['model_name']}\n\n")
                f.write(f"**Module:** {example['module']}  \n")
                f.write(f"**Category:** {example['category']}  \n\n")
                
                f.write("## Model Description\n\n")
                f.write(f"{example['description']}\n\n")
                
                f.write("## Complete COMSOL MATLAB Code\n\n")
                f.write("```matlab\n")
                f.write(f"{example['matlab_code']}\n")
                f.write("```\n\n")
                f.write("---\n\n")


def main():
    parser = argparse.ArgumentParser(description="Generate COMSOL few-shot examples")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing COMSOL models (searches recursively for .m files)")
    parser.add_argument("--max_examples", type=int, default=20,
                       help="Maximum number of examples to generate")
    parser.add_argument("--output_file", type=str, default="comsol_few_shot_examples.md",
                       help="Output markdown file")
    parser.add_argument("--api_key", type=str, default=None,
                       help="API key for LLM (or set LLM_API_KEY env var)")
    parser.add_argument("--api_base", type=str, default=None,
                       help="API base URL (or set LLM_API_BASE env var)")
    parser.add_argument("--detailed", action="store_true",
                       help="Generate detailed segment-by-segment analysis (default: True)")
    
    args = parser.parse_args()
    
    # Initialize generator
    print("🚀 Initializing High-Level Example Generator...")
    generator = HighLevelExampleGenerator(
        llm_provider="lambda",
        api_key=args.api_key,
        api_base=args.api_base
    )
    
    # Process models
    examples = generator.process_models(
        data_dir=args.data_dir,
        max_examples=args.max_examples,
        output_file=args.output_file
    )
    
    print(f"\n🎉 Successfully generated {len(examples)} few-shot examples!")
    print(f"📁 Output saved to: {args.output_file}")


if __name__ == "__main__":
    main() 