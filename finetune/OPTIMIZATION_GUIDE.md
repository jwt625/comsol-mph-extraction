# COMSOL Fine-tuning Optimization Guide

## 🔍 Dataset Analysis Results

Our analysis of 91,572 training examples reveals:

### Key Findings:
- **50.8% output diversity** - Significant duplication 
- **20.3% duplicate rate** - High redundancy
- **15% short outputs** - Many trivial examples
- **64 very long outputs** - Memory bottlenecks
- **Mean confidence: 0.52** - Mixed quality

### Physics Distribution:
- **SolidMechanics**: 8.6% (most common)
- **Electrostatics**: 3.9% 
- **ElectromagneticWaves**: 2.3%
- **217 total physics types** - Good diversity

### Category Distribution:
- **Materials**: 25.2%
- **Study**: 22.7% 
- **Physics**: 16.5%
- **Geometry**: 14.3%

## ⚡ Speed Optimization Strategies

### 1. Dataset Filtering (🎯 **HIGHEST IMPACT**)
```bash
# Use duplicate filtering - can reduce dataset by ~20%
python optimized_training.py --filter_duplicates \
  --data_dir ../production_run_01_complete_dataset \
  --max_samples 20000
```

**Why**: Removes redundant examples, faster training, better diversity

### 2. Multi-GPU Training (🚀 **MAJOR SPEEDUP**)
```bash
# Use all free GPUs (4,5,6,7)
python optimized_training.py --gpus "4,5,6,7" \
  --data_dir ../production_run_01_complete_dataset
```

**Expected Speedup**: 3-4x faster with 4 GPUs

### 3. Optimized LoRA Settings
```python
# Current: r=64 (too high)
# Optimized: r=16-32 (faster, similar quality)
```

**Why**: Lower rank = fewer parameters = faster training

### 4. Batch Size Optimization
```python
# Single GPU: batch_size=1, grad_accum=16
# Multi-GPU: batch_size=2, grad_accum=8
# Effective batch size: 32-64
```

### 5. Memory Optimizations
- ✅ 4-bit quantization (already using)
- ✅ Gradient checkpointing (already using)
- ✅ BF16 precision (already using)
- 🆕 Persistent dataloader workers
- 🆕 Pin memory for faster GPU transfer

## 📊 WandB Monitoring Setup

### Enable Monitoring:
```bash
# Login to WandB (one time)
wandb login

# Run with monitoring
python optimized_training.py \
  --wandb_project "comsol-finetuning" \
  --data_dir ../production_run_01_complete_dataset
```

### Key Metrics to Watch:
- **Training Loss**: Should decrease consistently
- **Learning Rate**: Should follow cosine schedule
- **GPU Utilization**: Should be >90%
- **Memory Usage**: Should be stable
- **Throughput**: Samples/second

## 🎯 Dataset Quality Issues

### Problems Identified:
1. **High Duplication**: 20.3% duplicate outputs
   - Many `model.sol('sol1').study('std1');` repeats
   - Solution: Use `--filter_duplicates`

2. **Short Outputs**: 15% under 50 characters
   - Often single-line commands
   - Solution: Filter in `load_and_filter_data()`

3. **Very Long Outputs**: 64 examples >5000 characters
   - Can cause OOM errors
   - Solution: Truncate or filter

### Recommended Filtering:
```python
# In optimized_training.py
if len(output) < 50:  # Skip very short
    continue
if len(output) > 3000:  # Skip very long
    continue
if output.count('\n') < 2:  # Skip single-line
    continue
```

## 🚀 Recommended Training Strategies

### Strategy 1: Quick Iteration (30 minutes)
```bash
python optimized_training.py \
  --fast_mode \
  --filter_duplicates \
  --max_samples 5000 \
  --gpus "4" \
  --wandb_project "comsol-quick"
```
- **Time**: 20-30 minutes
- **Purpose**: Test setup and format
- **Settings**: r=16, 1 epoch, small dataset

### Strategy 2: Balanced Training (2-3 hours)
```bash
python optimized_training.py \
  --filter_duplicates \
  --max_samples 20000 \
  --gpus "4,5" \
  --wandb_project "comsol-balanced"
```
- **Time**: 2-3 hours
- **Purpose**: Good quality with reasonable time
- **Settings**: r=32, 3 epochs, filtered dataset

### Strategy 3: Full Dataset (8-12 hours)
```bash
python optimized_training.py \
  --filter_duplicates \
  --gpus "4,5,6,7" \
  --wandb_project "comsol-full"
```
- **Time**: 8-12 hours  
- **Purpose**: Maximum quality
- **Settings**: r=32, 3 epochs, full dataset

## 📈 Expected Performance Gains

### Baseline vs Optimized:
| Optimization | Speedup | Time Reduction |
|-------------|---------|----------------|
| Remove duplicates | 1.25x | 20% faster |
| Multi-GPU (4x) | 3.5x | 71% faster |
| Lower LoRA rank | 1.3x | 23% faster |
| Batch optimization | 1.2x | 17% faster |
| **Combined** | **5.5x** | **82% faster** |

### From 11 minutes (1k samples) to:
- **5k samples**: ~30 minutes (vs 55 min baseline)
- **20k samples**: ~2 hours (vs 11 hours baseline)
- **Full dataset**: ~8 hours (vs 44 hours baseline)

## 🔧 Troubleshooting

### Common Issues:
1. **CUDA OOM**: Reduce batch size or max_length
2. **Slow data loading**: Increase `dataloader_num_workers`
3. **WandB issues**: Check `wandb login` status
4. **Poor generation**: Try different LoRA settings

### Performance Monitoring:
```bash
# Check GPU usage
nvidia-smi -l 1

# Check memory usage  
watch -n 1 'free -h'

# Monitor training
tail -f nohup.out
```

## 🎯 Next Steps

1. **Start with Strategy 1** (quick test)
2. **Analyze WandB results** 
3. **Scale to Strategy 2** if results look good
4. **Consider smaller models** (7B/13B) if 34B is too slow
5. **Experiment with prompt formats** based on generation quality

## 📝 Alternative Approaches

If training is still too slow:

1. **Switch to smaller model**: `Qwen2.5-Coder-7B` (2-3x faster)
2. **Use QLoRA**: Even more memory efficient
3. **Distributed training**: Scale across multiple nodes
4. **Progressive training**: Start small, increase complexity

Remember: **Quality > Speed**. Better to train on 20k high-quality filtered examples than 90k noisy ones! 