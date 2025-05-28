#!/usr/bin/env python3
"""
llm_assisted_alignment.py

A code-first LLM-assisted pipeline for creating high-quality COMSOL fine-tuning data.
This approach generates descriptions from code, matches to PDF content, then combines both.
OPTIMIZED VERSION: Uses hermes3-70b (fastest model) + parallel processing.
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
from anthropic import Anthropic
from concurrent.futures import ThreadPoolExecutor, as_completed
import time


class CONSOLDataProcessor:
    def __init__(self, llm_provider="lambda", api_key=None, api_base=None):
        self.llm_provider = llm_provider
        
        if llm_provider == "lambda":
            # Lambda AI endpoint using OpenAI-compatible API
            self.client = openai.OpenAI(
                api_key=api_key or os.getenv("LLM_API_KEY"),
                base_url=api_base or os.getenv("LLM_API_BASE", "https://api.lambda.ai/v1")
            )
        elif llm_provider == "anthropic":
            self.client = Anthropic(api_key=api_key)
        elif llm_provider == "openai":
            self.client = openai.OpenAI(api_key=api_key)
        else:
            raise ValueError("Supported providers: 'lambda', 'anthropic', 'openai'")

    def extract_code_descriptions(self, m_path: str, metadata: Dict) -> List[Dict]:
        """CODE-FIRST: Generate descriptions from ALL code segments using LLM understanding with PARALLEL processing."""
        with open(m_path, 'r') as f:
            code = f.read()
        
        # Use improved segmentation to get ALL segments
        code_segments = self._improved_code_segmentation(code)
        print(f"      Found {len(code_segments)} total code segments")
        
        # Create model context for better descriptions
        model_context = f"""
Model: {metadata.get('displayLabel', 'Unknown')}
Description: {metadata.get('description', 'COMSOL simulation model')}
Physics: {metadata.get('physics', 'Multi-physics simulation')}
Purpose: {metadata.get('purpose', 'Engineering simulation and analysis')}
"""
        
        # OPTIMIZED: Parallel processing with controlled concurrency
        enhanced_segments = []
        max_workers = 3  # Based on performance testing - optimal balance
        
        def process_segment(segment):
            """Process a single segment with LLM."""
            prompt = f"""
IMPORTANT: Return ONLY valid JSON, no explanations or markdown.

Context: {model_context.strip()}

Analyze this COMSOL code segment and describe what it does:

{segment['code']}

Return JSON format:
{{
    "segment_id": {segment['segment_id']},
    "start_line": {segment['start_line']},
    "end_line": {segment['end_line']},
    "code_description": "Brief description of what this code accomplishes",
    "modeling_purpose": "Why this step is needed in the simulation (use model context)",
    "comsol_ids": ["id1", "id2"],
    "category": "geometry|materials|physics|boundary_conditions|mesh|study|results|parameters|other",
    "key_operations": ["action1", "action2"]
}}
"""
            
            response = self._call_llm(prompt)
            enhanced = self._extract_json_from_response(response)
            
            if enhanced:
                enhanced['code'] = segment['code']
                return enhanced
            else:
                # Fallback with model context
                segment['code_description'] = f"COMSOL modeling step {segment['segment_id']}"
                segment['modeling_purpose'] = f"Part of {metadata.get('displayLabel', 'model')} simulation setup"
                segment['comsol_ids'] = self._extract_comsol_ids_from_code(segment['code'])
                segment['category'] = self._guess_category_from_code(segment['code'])
                segment['key_operations'] = []
                return segment
        
        # Process segments in parallel batches
        print(f"      ⚡ Using parallel processing with {max_workers} workers...")
        start_time = time.time()
        
        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            # Submit all tasks
            future_to_segment = {executor.submit(process_segment, seg): seg for seg in code_segments}
            
            # Collect results as they complete
            for i, future in enumerate(as_completed(future_to_segment)):
                if i % 20 == 0:  # Progress indicator
                    elapsed = time.time() - start_time
                    rate = (i + 1) / elapsed if elapsed > 0 else 0
                    print(f"         Progress: {i+1}/{len(code_segments)} segments ({rate:.1f} segments/sec)")
                
                try:
                    result = future.result()
                    enhanced_segments.append(result)
                except Exception as e:
                    # Fallback for failed segments
                    segment = future_to_segment[future]
                    print(f"   ⚠️  Segment {segment['segment_id']} failed, using fallback")
                    segment['code_description'] = f"COMSOL modeling step {segment['segment_id']}"
                    segment['modeling_purpose'] = f"Part of {metadata.get('displayLabel', 'model')} simulation setup"
                    segment['comsol_ids'] = self._extract_comsol_ids_from_code(segment['code'])
                    segment['category'] = self._guess_category_from_code(segment['code'])
                    segment['key_operations'] = []
                    enhanced_segments.append(segment)
        
        # Sort by segment_id to maintain order
        enhanced_segments.sort(key=lambda x: x['segment_id'])
        
        elapsed = time.time() - start_time
        rate = len(enhanced_segments) / elapsed if elapsed > 0 else 0
        print(f"      ✅ Successfully processed {len(enhanced_segments)} segments in {elapsed:.1f}s ({rate:.1f} segments/sec)")
        return enhanced_segments

    def extract_pdf_sections(self, pdf_path: str) -> List[Dict]:
        """Extract PDF content as searchable sections for matching."""
        text = extract_text(pdf_path)
        
        # Find modeling instructions section
        start_idx = text.find('Modeling Instructions')
        if start_idx >= 0:
            text = text[start_idx:]
        
        prompt = f"""
IMPORTANT: Return ONLY valid JSON, no explanations or markdown.

Extract instructional steps from this COMSOL tutorial:

{text[:4000]}

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

        response = self._call_llm(prompt)
        sections = self._extract_json_from_response(response)
        
        if sections and isinstance(sections, list):
            return sections
        else:
            print("   ⚠️  LLM response parsing failed, using fallback PDF extraction")
            return self._fallback_pdf_extraction(text)

    def match_code_to_pdf(self, code_segments: List[Dict], pdf_sections: List[Dict]) -> List[Dict]:
        """Match code descriptions to PDF sections using semantic similarity. EVERY code segment gets a match."""
        
        matches = []
        
        # Track which PDF sections have been used for high-confidence matches
        used_pdf_sections = set()
        
        # Direct ID-based matching first (high confidence)
        for code_seg in code_segments:
            best_match = None
            best_confidence = 0.0
            best_factors = []
            
            for pdf_sec in pdf_sections:
                confidence = 0.0
                factors = []
                
                # Check for COMSOL ID overlap
                code_ids = set(code_seg.get('comsol_ids', []))
                pdf_ids = set(pdf_sec.get('comsol_ids', []))
                if code_ids & pdf_ids:  # Intersection
                    confidence += 0.8
                    factors.append(f"Matching IDs: {code_ids & pdf_ids}")
                
                # Check for keyword similarity
                code_desc = code_seg.get('code_description', '').lower()
                pdf_title = pdf_sec.get('title', '').lower()
                pdf_instr = pdf_sec.get('instructions', '').lower()
                
                if any(word in pdf_title + pdf_instr for word in code_desc.split()[:3]):
                    confidence += 0.3
                    factors.append("Keyword similarity")
                
                # Category matching
                if code_seg.get('category') in pdf_title + pdf_instr:
                    confidence += 0.2
                    factors.append("Category match")
                
                if confidence > best_confidence:
                    best_confidence = confidence
                    best_match = pdf_sec['section_id']
                    best_factors = factors
            
            # If high confidence match, mark PDF section as used
            if best_confidence > 0.7:
                used_pdf_sections.add(best_match)
            
            # Create match entry for EVERY code segment
            matches.append({
                "code_segment_id": code_seg['segment_id'],
                "pdf_section_id": best_match,
                "match_confidence": best_confidence,
                "matching_factors": best_factors if best_confidence > 0 else ["No clear match - using code description"],
                "reasoning": f"Confidence: {best_confidence:.2f}"
            })
        
        # For low-confidence matches, try to distribute unused PDF sections
        low_conf_matches = [m for m in matches if m['match_confidence'] < 0.3]
        unused_pdf_sections = [p['section_id'] for p in pdf_sections if p['section_id'] not in used_pdf_sections]
        
        # Assign unused PDF sections to unmatched code segments
        for i, match in enumerate(low_conf_matches):
            if unused_pdf_sections and i < len(unused_pdf_sections):
                match['pdf_section_id'] = unused_pdf_sections[i]
                match['match_confidence'] = 0.1  # Low but better than none
                match['matching_factors'] = ["Assigned unused PDF section"]
                match['reasoning'] = f"Assigned to unused PDF section {unused_pdf_sections[i]}"
        
        print(f"      Created {len(matches)} matches (all code segments included)")
        high_conf = len([m for m in matches if m['match_confidence'] > 0.7])
        med_conf = len([m for m in matches if 0.3 <= m['match_confidence'] <= 0.7])
        low_conf = len([m for m in matches if m['match_confidence'] < 0.3])
        print(f"      Confidence distribution: {high_conf} high, {med_conf} medium, {low_conf} low")
        
        return matches

    def create_enhanced_training_examples(self, code_segments: List[Dict], pdf_sections: List[Dict], 
                                        matches: List[Dict], metadata: Dict) -> List[Dict]:
        """Combine code understanding with PDF pedagogy to create enhanced training examples for ALL segments."""
        enhanced_examples = []
        
        # Process ALL matches (don't skip low confidence ones)
        for match in matches:
            code_seg = next((c for c in code_segments if c['segment_id'] == match['code_segment_id']), None)
            pdf_sec = next((p for p in pdf_sections if p['section_id'] == match['pdf_section_id']), None) if match['pdf_section_id'] else None
            
            if not code_seg:
                continue
            
            # Use PDF instructions if good match, otherwise use LLM-generated description with model context
            if pdf_sec and match['match_confidence'] > 0.5:
                input_text = pdf_sec.get('instructions', '')
                source_info = f"Matched to PDF section: {pdf_sec.get('title', 'N/A')}"
            else:
                # Use model context to create better input when no good PDF match
                input_text = f"""
Model Context: {metadata.get('description', 'COMSOL simulation')}
Physics: {metadata.get('physics', 'Multi-physics')}
Step Purpose: {code_seg.get('modeling_purpose', 'Modeling step')}
What to do: {code_seg.get('code_description', 'Execute COMSOL operation')}
"""
                source_info = "Generated from code analysis with model context"
            
            # Create enhanced example for EVERY segment
            enhanced_examples.append({
                "instruction": f"[{metadata.get('displayLabel', 'Model')}] {code_seg.get('code_description', 'COMSOL modeling step')}",
                "input": input_text.strip(),
                "output": code_seg['code'],
                "explanation": f"Physics: {metadata.get('physics', 'Unknown')}. Purpose: {code_seg.get('modeling_purpose', 'Modeling step')}",
                "confidence": match['match_confidence'],
                "source": "code_first",
                "category": code_seg.get('category', 'other'),
                "match_info": source_info,
                "comsol_ids": code_seg.get('comsol_ids', [])
            })
        
        print(f"      Created {len(enhanced_examples)} training examples from {len(code_segments)} code segments")
        return enhanced_examples

    def _call_llm(self, prompt: str) -> str:
        """Make API call to chosen LLM provider."""
        try:
            if self.llm_provider == "lambda":
                response = self.client.chat.completions.create(
                    model="hermes3-70b",  # OPTIMIZED: Fastest model (0.48s/call vs 4.24s for llama3.3)
                    messages=[{"role": "user", "content": prompt}],
                    max_tokens=800,  # OPTIMIZED: Reduced for faster responses
                    temperature=0.1
                )
                return response.choices[0].message.content
            elif self.llm_provider == "anthropic":
                response = self.client.messages.create(
                    model="claude-3-sonnet-20241022",
                    max_tokens=2000,
                    messages=[{"role": "user", "content": prompt}]
                )
                return response.content[0].text
            elif self.llm_provider == "openai":
                response = self.client.chat.completions.create(
                    model="gpt-4-turbo-preview",
                    messages=[{"role": "user", "content": prompt}],
                    max_tokens=2000
                )
                return response.choices[0].message.content
        except Exception as e:
            print(f"   ⚠️  LLM API call failed: {str(e)}")
            return ""

    def _extract_json_from_response(self, response: str) -> Optional[Dict]:
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

    def _improved_code_segmentation(self, code: str) -> List[Dict]:
        """Improved code segmentation based on COMSOL patterns."""
        lines = code.split('\n')
        segments = []
        current_segment = []
        segment_id = 1
        
        # Better segmentation based on logical groups
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
        
        return segments

    def _fallback_pdf_extraction(self, text: str) -> List[Dict]:
        """Fallback PDF extraction using regex patterns."""
        # Extract sections using improved patterns
        section_pattern = re.compile(r'^([A-Z][a-zA-Z\s]+\d*\s*\([^)]+\))\s*\n(.*?)(?=\n[A-Z][a-zA-Z\s]+\d*\s*\([^)]+\)|\Z)', 
                                   re.MULTILINE | re.DOTALL)
        matches = section_pattern.findall(text)
        
        sections = []
        for i, (title, content) in enumerate(matches):
            sections.append({
                "section_id": i + 1,
                "title": title.strip(),
                "instructions": content.strip(),
                "comsol_ids": re.findall(r'\(([^)]+)\)', title),
                "purpose": f"Section {i+1} instructions",
                "keywords": title.lower().split()
            })
        return sections

    def _extract_comsol_ids_from_code(self, code: str) -> List[str]:
        """Extract COMSOL IDs from code using regex."""
        # Common patterns: 'geom1', 'mat1', 'solid', 'es', etc.
        id_pattern = r"'([a-zA-Z]+\d*[a-zA-Z]*\d*)'"
        ids = re.findall(id_pattern, code)
        return list(set(ids))  # Remove duplicates
    
    def _guess_category_from_code(self, code: str) -> str:
        """Guess category from code content."""
        code_lower = code.lower()
        if any(word in code_lower for word in ['geom', 'create', 'rectangle', 'circle', 'polygon']):
            return 'geometry'
        elif any(word in code_lower for word in ['material', 'propertygroup', 'density', 'conductivity']):
            return 'materials'
        elif any(word in code_lower for word in ['physics', 'solidmechanics', 'electrostatics', 'fluidflow']):
            return 'physics'
        elif any(word in code_lower for word in ['mesh', 'ftet', 'ftri', 'edge', 'size']):
            return 'mesh'
        elif any(word in code_lower for word in ['study', 'stationary', 'frequency', 'transient']):
            return 'study'
        elif any(word in code_lower for word in ['selection', 'boundary', 'domain']):
            return 'boundary_conditions'
        elif any(word in code_lower for word in ['param', 'set', 'variable']):
            return 'parameters'
        elif any(word in code_lower for word in ['plot', 'export', 'result']):
            return 'results'
        else:
            return 'other'


def extract_physics_from_metadata(metadata: Dict) -> str:
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


def process_model_directory(model_dir: str, processor: CONSOLDataProcessor, 
                          output_dir: str) -> bool:
    """Process a single model directory with CODE-FIRST LLM assistance."""
    try:
        # Find required files
        pdf_files = list(Path(model_dir).glob("*.pdf"))
        m_files = list(Path(model_dir).glob("*.m"))
        json_file = Path(model_dir) / "smodel.json"
        
        if not (pdf_files and m_files and json_file.exists()):
            print(f"⚠️  Skipping {model_dir} - missing required files")
            return False

        # Load metadata
        with open(json_file, 'r') as f:
            metadata = json.load(f)
        
        # Extract physics information early
        physics_info = extract_physics_from_metadata(metadata)
        
        # Create enhanced metadata for processing
        enhanced_metadata = {
            'displayLabel': metadata.get('displayLabel', ''),
            'physics': physics_info,
            'description': metadata.get('description', ''),
            'purpose': metadata.get('purpose', '')
        }
        
        model_name = os.path.basename(model_dir)
        print(f"🔄 Processing {model_name} with CODE-FIRST LLM assistance...")
        print(f"      Physics: {physics_info}")

        # Stage 1: Extract code descriptions (GROUND TRUTH)
        print("   📝 Stage 1: Analyzing code to understand what it does...")
        code_segments = processor.extract_code_descriptions(str(m_files[0]), enhanced_metadata)
        print(f"      Extracted {len(code_segments)} code segments")

        # Stage 2: Extract PDF sections for context
        print("   📖 Stage 2: Extracting PDF instructional content...")
        pdf_sections = processor.extract_pdf_sections(str(pdf_files[0]))
        print(f"      Extracted {len(pdf_sections)} PDF sections")

        # Stage 3: Match code descriptions to PDF content
        print("   🔗 Stage 3: Matching code descriptions to PDF instructions...")
        matches = processor.match_code_to_pdf(code_segments, pdf_sections)
        high_conf_matches = [m for m in matches if m['match_confidence'] > 0.7]
        print(f"      Created {len(matches)} matches ({len(high_conf_matches)} high confidence)")

        # Stage 4: Generate enhanced training examples
        print("   ✨ Stage 4: Creating enhanced training examples...")
        enhanced_examples = processor.create_enhanced_training_examples(
            code_segments, pdf_sections, matches, enhanced_metadata
        )

        # Save results
        output_path = Path(output_dir) / f"{model_name}.jsonl"
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_path, 'w') as f:
            for example in enhanced_examples:
                f.write(json.dumps(example) + '\n')

        # Save detailed analysis
        analysis_path = Path(output_dir) / f"{model_name}_analysis.json"
        with open(analysis_path, 'w') as f:
            json.dump({
                'model_name': model_name,
                'metadata': metadata,
                'code_segments': code_segments,
                'pdf_sections': pdf_sections,
                'matches': matches,
                'enhanced_examples': enhanced_examples,
                'stats': {
                    'total_code_segments': len(code_segments),
                    'total_pdf_sections': len(pdf_sections),
                    'total_matches': len(matches),
                    'high_confidence_matches': len(high_conf_matches),
                    'enhanced_examples': len(enhanced_examples)
                }
            }, f, indent=2)

        print(f"✓ Generated {len(enhanced_examples)} enhanced examples for {model_name}")
        return True

    except Exception as e:
        print(f"⚠️  Error processing {model_dir}: {str(e)}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description="CODE-FIRST LLM-assisted COMSOL fine-tuning data preparation"
    )
    parser.add_argument("--mphs_dir", required=True, help="Directory containing model folders")
    parser.add_argument("--output_dir", default="enhanced_fine_tune_data", help="Output directory")
    parser.add_argument("--llm_provider", choices=["lambda", "anthropic", "openai"], default="lambda")
    parser.add_argument("--api_key", help="API key for LLM provider")
    parser.add_argument("--api_base", help="API base URL for LLM provider")
    parser.add_argument("--max_models", type=int, help="Limit number of models to process (for testing)")
    args = parser.parse_args()

    # Initialize processor
    processor = CONSOLDataProcessor(args.llm_provider, args.api_key, args.api_base)
    
    # Find model directories
    model_dirs = [d for d in glob.glob(os.path.join(args.mphs_dir, "*")) if os.path.isdir(d)]
    if args.max_models:
        model_dirs = model_dirs[:args.max_models]
    
    print(f"🚀 Processing {len(model_dirs)} models with CODE-FIRST {args.llm_provider} LLM assistance")
    print("📋 Approach: Code → Descriptions → PDF Matching → Enhanced Examples")
    
    # Process each directory
    successful = 0
    for model_dir in model_dirs:
        if process_model_directory(model_dir, processor, args.output_dir):
            successful += 1

    print(f"\n✅ Processing complete: {successful}/{len(model_dirs)} models processed successfully")
    print(f"📁 Enhanced data saved to: {args.output_dir}")


if __name__ == "__main__":
    main() 