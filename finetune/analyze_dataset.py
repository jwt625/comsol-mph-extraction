#!/usr/bin/env python3
"""
Comprehensive COMSOL Dataset Analysis
Analyzes the quality, diversity, and potential issues in the training data
"""

import os
import json
import glob
from collections import Counter, defaultdict
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path
import numpy as np

def analyze_comsol_dataset(data_dir="../production_run_01_complete_dataset"):
    """Comprehensive analysis of COMSOL training dataset"""
    
    print("🔍 COMPREHENSIVE COMSOL DATASET ANALYSIS")
    print("="*60)
    
    # Load all data
    jsonl_files = glob.glob(os.path.join(data_dir, "*.jsonl"))
    print(f"📁 Found {len(jsonl_files)} JSONL files")
    
    all_data = []
    physics_counter = Counter()
    category_counter = Counter()
    output_lengths = []
    instruction_lengths = []
    input_lengths = []
    confidence_scores = []
    source_types = Counter()
    comsol_commands = Counter()
    
    duplicate_outputs = defaultdict(int)
    duplicate_instructions = defaultdict(int)
    
    print("📊 Loading and analyzing data...")
    
    for file_path in jsonl_files:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f):
                try:
                    data = json.loads(line.strip())
                    
                    # Basic validation
                    if not all(field in data for field in ['instruction', 'input', 'output']):
                        continue
                    
                    all_data.append(data)
                    
                    # Analyze lengths
                    output_lengths.append(len(data['output']))
                    instruction_lengths.append(len(data['instruction']))
                    input_lengths.append(len(data['input']))
                    
                    # Extract physics information
                    explanation = data.get('explanation', '')
                    if 'Physics:' in explanation:
                        physics = explanation.split('Physics:')[1].split('.')[0].strip()
                        physics_counter[physics] += 1
                    
                    # Category analysis
                    category = data.get('category', 'unknown')
                    category_counter[category] += 1
                    
                    # Confidence analysis
                    confidence = data.get('confidence', 0)
                    confidence_scores.append(confidence)
                    
                    # Source analysis
                    source = data.get('source', 'unknown')
                    source_types[source] += 1
                    
                    # Duplicate analysis
                    output_hash = data['output'].strip()
                    duplicate_outputs[output_hash] += 1
                    
                    instruction_hash = data['instruction'].strip()
                    duplicate_instructions[instruction_hash] += 1
                    
                    # COMSOL command analysis
                    output_lines = data['output'].split('\n')
                    for line in output_lines:
                        line = line.strip()
                        if line.startswith('model.') and '(' in line:
                            command = line.split('(')[0]
                            comsol_commands[command] += 1
                    
                except json.JSONDecodeError as e:
                    print(f"⚠️  JSON error in {file_path}:{line_num+1}")
                    continue
    
    total_examples = len(all_data)
    print(f"✅ Loaded {total_examples:,} total examples")
    
    # Basic Statistics
    print(f"\n📈 BASIC STATISTICS")
    print(f"{'='*40}")
    print(f"Total examples: {total_examples:,}")
    print(f"Total files: {len(jsonl_files)}")
    print(f"Avg examples per file: {total_examples/len(jsonl_files):.1f}")
    
    # Length Analysis
    print(f"\n📏 LENGTH ANALYSIS")
    print(f"{'='*40}")
    print(f"Output lengths - Mean: {np.mean(output_lengths):.1f}, Median: {np.median(output_lengths):.1f}")
    print(f"                Min: {min(output_lengths)}, Max: {max(output_lengths)}")
    print(f"Instruction lengths - Mean: {np.mean(instruction_lengths):.1f}, Median: {np.median(instruction_lengths):.1f}")
    print(f"Input lengths - Mean: {np.mean(input_lengths):.1f}, Median: {np.median(input_lengths):.1f}")
    
    # Diversity Analysis
    unique_outputs = len(set(data['output'] for data in all_data))
    unique_instructions = len(set(data['instruction'] for data in all_data))
    
    print(f"\n🎯 DIVERSITY ANALYSIS")
    print(f"{'='*40}")
    print(f"Output diversity: {unique_outputs/total_examples:.2%} ({unique_outputs:,}/{total_examples:,})")
    print(f"Instruction diversity: {unique_instructions/total_examples:.2%} ({unique_instructions:,}/{total_examples:,})")
    
    # Duplicate Analysis
    output_duplicates = {k: v for k, v in duplicate_outputs.items() if v > 1}
    instruction_duplicates = {k: v for k, v in duplicate_instructions.items() if v > 1}
    
    print(f"\n🔄 DUPLICATE ANALYSIS")
    print(f"{'='*40}")
    print(f"Duplicate outputs: {len(output_duplicates):,} ({len(output_duplicates)/len(duplicate_outputs):.1%})")
    print(f"Duplicate instructions: {len(instruction_duplicates):,} ({len(instruction_duplicates)/len(duplicate_instructions):.1%})")
    
    if output_duplicates:
        top_duplicates = sorted(output_duplicates.items(), key=lambda x: x[1], reverse=True)[:5]
        print(f"Top duplicate outputs:")
        for output, count in top_duplicates:
            print(f"  {count}x: {output[:100]}...")
    
    # Physics Analysis
    print(f"\n⚛️  PHYSICS ANALYSIS")
    print(f"{'='*40}")
    print(f"Physics types: {len(physics_counter)}")
    print("Top physics:")
    for physics, count in physics_counter.most_common(10):
        print(f"  {physics}: {count:,} ({count/total_examples:.1%})")
    
    # Category Analysis  
    print(f"\n📂 CATEGORY ANALYSIS")
    print(f"{'='*40}")
    print("Categories:")
    for category, count in category_counter.most_common():
        print(f"  {category}: {count:,} ({count/total_examples:.1%})")
    
    # Confidence Analysis
    if confidence_scores:
        print(f"\n🎯 CONFIDENCE ANALYSIS")
        print(f"{'='*40}")
        print(f"Mean confidence: {np.mean(confidence_scores):.2f}")
        print(f"Confidence distribution:")
        confidence_bins = Counter([round(c, 1) for c in confidence_scores])
        for conf, count in sorted(confidence_bins.items()):
            print(f"  {conf}: {count:,} ({count/total_examples:.1%})")
    
    # COMSOL Commands Analysis
    print(f"\n🔧 COMSOL COMMANDS ANALYSIS")
    print(f"{'='*40}")
    print(f"Unique COMSOL commands: {len(comsol_commands)}")
    print("Most common commands:")
    for cmd, count in comsol_commands.most_common(15):
        print(f"  {cmd}: {count:,}")
    
    # Quality Recommendations
    print(f"\n💡 QUALITY RECOMMENDATIONS")
    print(f"{'='*40}")
    
    recommendations = []
    
    # Check diversity
    if unique_outputs/total_examples < 0.8:
        recommendations.append(f"⚠️  Low output diversity ({unique_outputs/total_examples:.1%}) - consider deduplication")
    
    # Check duplicates
    if len(output_duplicates)/len(duplicate_outputs) > 0.1:
        recommendations.append(f"⚠️  High duplicate rate ({len(output_duplicates)/len(duplicate_outputs):.1%}) - filter duplicates")
    
    # Check short outputs
    short_outputs = sum(1 for length in output_lengths if length < 50)
    if short_outputs/total_examples > 0.1:
        recommendations.append(f"⚠️  Many short outputs ({short_outputs/total_examples:.1%}) - consider filtering")
    
    # Check very long outputs
    very_long = sum(1 for length in output_lengths if length > 5000)
    if very_long > 0:
        recommendations.append(f"⚠️  Very long outputs ({very_long}) - may cause memory issues")
    
    # Check confidence
    if confidence_scores:
        low_confidence = sum(1 for c in confidence_scores if c < 0.3)
        if low_confidence/total_examples > 0.5:
            recommendations.append(f"⚠️  Many low confidence examples ({low_confidence/total_examples:.1%}) - consider filtering")
    
    if recommendations:
        for rec in recommendations:
            print(rec)
    else:
        print("✅ Dataset quality looks good!")
    
    # Training Recommendations
    print(f"\n🚀 TRAINING RECOMMENDATIONS")
    print(f"{'='*40}")
    
    if total_examples > 50000:
        print("📊 Large dataset - consider:")
        print("  - Start with 10-20k samples for initial training")
        print("  - Use duplicate filtering")
        print("  - Multiple epochs may not be needed")
    
    if unique_outputs/total_examples < 0.5:
        print("🔄 High duplication - consider:")
        print("  - Aggressive duplicate filtering")
        print("  - Quality over quantity approach")
    
    print(f"📈 Suggested batch sizes:")
    print(f"  - Single GPU: batch_size=1, grad_accum=8-16")
    print(f"  - Multi-GPU: batch_size=2, grad_accum=4-8")
    
    return {
        'total_examples': total_examples,
        'physics_distribution': dict(physics_counter),
        'category_distribution': dict(category_counter),
        'duplicate_rate': len(output_duplicates)/len(duplicate_outputs),
        'diversity_score': unique_outputs/total_examples,
        'avg_output_length': np.mean(output_lengths),
        'top_commands': dict(comsol_commands.most_common(20))
    }

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Analyze COMSOL dataset")
    parser.add_argument("--data_dir", type=str, 
                       default="../production_run_01_complete_dataset",
                       help="Directory containing JSONL files")
    
    args = parser.parse_args()
    
    results = analyze_comsol_dataset(args.data_dir)
    
    # Save results
    with open("dataset_analysis_results.json", 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f"\n💾 Analysis results saved to dataset_analysis_results.json") 