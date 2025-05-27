#!/usr/bin/env python3
"""
extract_and_align.py

A script to parse COMSOL modeling bundles: raw PDF, .m script, and metadata files,
then align and generate a JSONL fine-tuning dataset.
"""
import os
import re
import json
import glob
import argparse
from pathlib import Path
from pdfminer.high_level import extract_text
import xml.etree.ElementTree as ET


def find_model_files(model_dir):
    """Find relevant files in a model directory."""
    # Find PDF file (there should be only one)
    pdf_files = list(Path(model_dir).glob("*.pdf"))
    if not pdf_files:
        return None
    
    # Find .m file (there should be only one)
    m_files = list(Path(model_dir).glob("*.m"))
    if not m_files:
        return None
    
    # Get metadata files
    json_file = Path(model_dir) / "smodel.json"
    if not json_file.exists():
        return None

    return {
        "pdf": str(pdf_files[0]),
        "mfile": str(m_files[0]),
        "json": str(json_file),
    }


def extract_metadata(json_path):
    """Load metadata from smodel.json."""
    with open(json_path, 'r') as f:
        smodel = json.load(f)
    # Basic JSON metadata
    meta = {
        "model_name": smodel.get("displayLabel", ""),
        "description": smodel.get("description", ""),
        "physics": smodel.get("physicsInfo", ""),
        "dimension": smodel.get("dimension", "?")
    }
    return meta


def extract_pdf_chunks(pdf_path):
    """Split PDF text into logical 'Step:' chunks."""
    text = extract_text(pdf_path)
    # Split on lines starting with "Step:" (case-insensitive)
    parts = re.split(r'(?i)\n(?=Step:)', text)
    chunks = []
    for part in parts:
        lines = part.strip().splitlines()
        if not lines:
            continue
        title = lines[0].strip()
        content = "\n".join(lines[1:]).strip()
        chunks.append({"title": title, "text": content})
    return chunks


def split_m_script(m_path):
    """Break monolithic .m file into COMSOL API code blocks."""
    with open(m_path, 'r') as f:
        code = f.read()
    # Split blocks by 'model.' calls
    pattern = r'(model\.[\s\S]*?)(?=(?:model\.)|\Z)'
    matches = re.findall(pattern, code, flags=re.MULTILINE)
    blocks = [m.strip() for m in matches if m.strip()]
    return blocks


def align_and_generate_jsonl(meta, pdf_chunks, code_blocks, output_path):
    """Naively align PDF chunks with code blocks and write JSONL."""
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, 'w') as wf:
        for i, chunk in enumerate(pdf_chunks):
            code = code_blocks[i] if i < len(code_blocks) else ""
            example = {
                "instruction": (
                    f"[Model:{meta['model_name']}]"
                    f"[Physics:{meta['physics']}]"
                    f"[Dim:{meta.get('dimension','?')}D] "
                    f"{meta['description']}"
                ),
                "input": f"{chunk['title']}\n{chunk['text']}",
                "output": code
            }
            wf.write(json.dumps(example) + "\n")
    print(f"→ Wrote {len(pdf_chunks)} examples to {output_path}")


def process_model_dir(model_dir, output_dir):
    """Process a single model directory."""
    files = find_model_files(model_dir)
    if not files:
        print(f"⚠️  Skipping {model_dir} - missing required files")
        return False

    try:
        # Create output filename based on model directory name
        model_name = os.path.basename(model_dir)
        output_path = os.path.join(output_dir, f"{model_name}.jsonl")

        # Extract and align
        meta = extract_metadata(files["json"])
        pdf_chunks = extract_pdf_chunks(files["pdf"])
        code_blocks = split_m_script(files["mfile"])
        
        # Generate output
        align_and_generate_jsonl(meta, pdf_chunks, code_blocks, output_path)
        print(f"✓ Processed {model_name}")
        return True
        
    except Exception as e:
        print(f"⚠️  Error processing {model_dir}: {str(e)}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description="Extract metadata, PDF steps, and code blocks to JSONL for fine-tuning."
    )
    parser.add_argument("--mphs_dir", required=True, help="Path to the mphs directory containing model folders")
    parser.add_argument("--output_dir", default="fine_tune_data", help="Output directory for JSONL files")
    args = parser.parse_args()

    # Ensure output directory exists
    os.makedirs(args.output_dir, exist_ok=True)

    # Find all model directories
    model_dirs = [d for d in glob.glob(os.path.join(args.mphs_dir, "*")) if os.path.isdir(d)]
    print(f"Found {len(model_dirs)} potential model directories")

    # Process each directory
    successful = 0
    for model_dir in model_dirs:
        if process_model_dir(model_dir, args.output_dir):
            successful += 1

    print(f"\nProcessing complete: {successful}/{len(model_dirs)} models processed successfully")


if __name__ == "__main__":
    main()
