#!/usr/bin/env python3
"""
extract_and_align.py

A script to parse COMSOL modeling bundles: raw PDF instructions, .m script, and metadata files,
then align and generate a JSONL fine-tuning dataset with step-to-code alignment using COMSOL IDs.
"""
import os
import re
import json
import glob
import argparse
from pathlib import Path
from pdfminer.high_level import extract_text

def find_model_files(model_dir):
    """Find relevant files in a model directory."""
    pdf_files = list(Path(model_dir).glob("*.pdf"))
    m_files   = list(Path(model_dir).glob("*.m"))
    json_file = Path(model_dir) / "smodel.json"
    if not (pdf_files and m_files and json_file.exists()):
        return None
    return {"pdf": str(pdf_files[0]), "mfile": str(m_files[0]), "json": str(json_file)}


def extract_metadata(json_path):
    """Load metadata from smodel.json."""
    with open(json_path, 'r') as f:
        smodel = json.load(f)
    return {
        "model_name": smodel.get("displayLabel", ""),
        "description": smodel.get("description", ""),
        "physics": smodel.get("physicsInfo", ""),
        "dimension": smodel.get("dimension", "?")
    }


def extract_pdf_chunks(pdf_path):
    """Split PDF text into logical feature-based chunks, capturing COMSOL IDs."""
    raw = extract_text(pdf_path)
    # Focus on 'Modeling Instructions' section if available
    start_idx = raw.find('Modeling Instructions')
    text = raw[start_idx:] if start_idx >= 0 else raw
    # Titles often include a feature name and ID in parentheses
    title_pattern = re.compile(r'^(?P<title>.+?\([^()]+\))\s*$', re.MULTILINE)
    matches = list(title_pattern.finditer(text))
    chunks = []
    for i, m in enumerate(matches):
        title = m.group('title').strip()
        start = m.end()
        end = matches[i+1].start() if i+1 < len(matches) else len(text)
        content = text[start:end].strip().replace('\n', ' ')
        chunks.append({"title": title, "text": content})
    return chunks


def split_m_script(m_path):
    """Break monolithic .m file into COMSOL API code blocks, grouped by 'model.' prefixes."""
    with open(m_path, 'r') as f:
        lines = f.readlines()
    blocks, buffer = [], []
    for line in lines:
        if line.lstrip().startswith('model.') and buffer:
            blocks.append(''.join(buffer).strip())
            buffer = [line]
        else:
            buffer.append(line)
    if buffer:
        blocks.append(''.join(buffer).strip())
    return blocks


def align_and_generate_jsonl(meta, pdf_chunks, code_blocks, output_path):
    """Align PDF chunks to code blocks via ID matching, fallback to sequential unused blocks."""
    used = set()
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, 'w') as wf:
        for chunk in pdf_chunks:
            code = ''
            id_match = re.search(r'\(([^)]+)\)', chunk['title'])
            if id_match:
                cid = id_match.group(1)
                for idx, blk in enumerate(code_blocks):
                    if idx not in used and cid in blk:
                        code = blk
                        used.add(idx)
                        break
            # Fallback to next unused block
            if not code:
                for idx, blk in enumerate(code_blocks):
                    if idx not in used:
                        code = blk
                        used.add(idx)
                        break
            example = {
                "instruction": (
                    f"[Model:{meta['model_name']}]"
                    f"[Physics:{meta['physics']}]"
                    f"[Dim:{meta['dimension']}D] "
                    f"{meta['description']}"
                ),
                "input": f"{chunk['title']}\n{chunk['text']}",
                "output": code
            }
            wf.write(json.dumps(example) + "\n")
    print(f"→ Aligned {len(pdf_chunks)} chunks with {len(used)} code blocks into {output_path}")


def process_model_dir(model_dir, output_dir):
    """Process a single model directory."""
    files = find_model_files(model_dir)
    if not files:
        print(f"⚠️  Skipping {model_dir} - missing files")
        return False
    meta         = extract_metadata(files['json'])
    pdf_chunks   = extract_pdf_chunks(files['pdf'])
    code_blocks  = split_m_script(files['mfile'])
    model_name   = os.path.basename(model_dir)
    output_path  = os.path.join(output_dir, f"{model_name}.jsonl")
    align_and_generate_jsonl(meta, pdf_chunks, code_blocks, output_path)
    print(f"✓ Processed {model_name}")
    return True


def main():
    parser = argparse.ArgumentParser(
        description="Extract metadata, PDF steps, and code blocks to JSONL for fine-tuning."
    )
    parser.add_argument("--mphs_dir",  required=True, help="Directory containing model subfolders")
    parser.add_argument("--output_dir", default="fine_tune_data", help="Output directory for JSONL files")
    args = parser.parse_args()

    os.makedirs(args.output_dir, exist_ok=True)
    model_dirs = [d for d in glob.glob(os.path.join(args.mphs_dir, "*")) if os.path.isdir(d)]
    print(f"Found {len(model_dirs)} model directories")
    success = 0
    for d in model_dirs:
        if process_model_dir(d, args.output_dir):
            success += 1
    print(f"Processing complete: {success}/{len(model_dirs)} models processed successfully")

if __name__ == "__main__":
    main()
