#!/usr/bin/env python3
"""
Monitor fine-tuning progress
"""

import subprocess
import time
import os
from pathlib import Path

def check_training_progress():
    """Check training progress"""
    
    print("🔥 COMSOL Fine-tuning Monitor")
    print("=" * 50)
    
    # Check if training process is running
    try:
        result = subprocess.run(['pgrep', '-f', 'finetune_setup.py'], 
                              capture_output=True, text=True)
        if result.stdout.strip():
            print("✅ Training process is running")
            pids = result.stdout.strip().split('\n')
            print(f"   PIDs: {', '.join(pids)}")
        else:
            print("❌ No training process found")
    except:
        print("⚠️  Could not check process status")
    
    print()
    
    # Check GPU usage
    try:
        result = subprocess.run(['nvidia-smi', '--query-gpu=index,memory.used,memory.total,utilization.gpu', 
                               '--format=csv,noheader,nounits'], 
                              capture_output=True, text=True)
        print("🖥️  GPU Status:")
        print("   GPU | Memory Used/Total | GPU Util")
        print("   " + "-" * 35)
        
        for line in result.stdout.strip().split('\n'):
            parts = [p.strip() for p in line.split(',')]
            if len(parts) == 4:
                gpu_id, mem_used, mem_total, gpu_util = parts
                print(f"   {gpu_id:3} | {mem_used:5}/{mem_total:5} MB | {gpu_util:3}%")
    except:
        print("⚠️  Could not check GPU status")
    
    print()
    
    # Check training output directories
    print("📁 Training Outputs:")
    output_dirs = [
        "test_comsol_34b_quick",
        "comsol_production_model", 
        "comsol_llama70b_production"
    ]
    
    for dir_name in output_dirs:
        if Path(dir_name).exists():
            size = sum(f.stat().st_size for f in Path(dir_name).rglob('*') if f.is_file())
            print(f"   ✅ {dir_name}: {size/1024/1024:.1f} MB")
        else:
            print(f"   ⭕ {dir_name}: Not found")
    
    print()
    
    # Check for recent log files or checkpoints
    print("📊 Recent Activity:")
    try:
        # Look for recent files in current directory
        recent_files = []
        for item in Path('.').iterdir():
            if item.is_file() and item.stat().st_mtime > time.time() - 3600:  # Last hour
                recent_files.append((item.name, item.stat().st_mtime))
        
        if recent_files:
            recent_files.sort(key=lambda x: x[1], reverse=True)
            for filename, mtime in recent_files[:5]:
                age = int((time.time() - mtime) / 60)
                print(f"   📄 {filename} (updated {age}m ago)")
        else:
            print("   No recent files in last hour")
    except:
        print("   Could not check recent files")

def watch_training():
    """Watch training progress continuously"""
    print("🔄 Watching training progress (Ctrl+C to stop)...")
    print()
    
    try:
        while True:
            check_training_progress()
            print("\n" + "="*50)
            print("🕐 Refreshing in 30 seconds...")
            time.sleep(30)
            print("\033[H\033[J")  # Clear screen
    except KeyboardInterrupt:
        print("\n👋 Monitoring stopped")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == "--watch":
        watch_training()
    else:
        check_training_progress()
        print("\n💡 Use 'python monitor_training.py --watch' for continuous monitoring") 