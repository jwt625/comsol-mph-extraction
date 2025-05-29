#!/bin/bash
# COMSOL Fine-tuning Environment Setup

set -e

echo "🚀 Setting up COMSOL Fine-tuning Environment"

# Check if we're in a virtual environment
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "Warning: Not in a virtual environment. Consider creating one:"
    echo "  python -m venv finetune-env"
    echo "  source finetune-env/bin/activate"
    echo ""
fi

# Update pip
echo "📦 Updating pip..."
pip install --upgrade pip

# Install base requirements
echo "📦 Installing base requirements..."
pip install -r requirements_finetune.txt

# Install Unsloth (requires special handling)
echo "🔧 Installing Unsloth..."
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"

# Install xformers for memory efficiency (if compatible)
echo "🔧 Installing xformers..."
pip install xformers --index-url https://download.pytorch.org/whl/cu118 || echo "Warning: xformers installation failed, continuing..."

# Verify installations
echo "✅ Verifying installations..."
python -c "import torch; print(f'PyTorch: {torch.__version__}')"
python -c "import transformers; print(f'Transformers: {transformers.__version__}')"
python -c "from unsloth import FastLanguageModel; print('Unsloth: OK')" || echo "Warning: Unsloth not properly installed"

# Check GPU availability
echo "🔍 Checking GPU availability..."
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}'); print(f'GPU count: {torch.cuda.device_count()}' if torch.cuda.is_available() else 'No GPU')"

echo ""
echo "🎉 Setup complete! Ready for fine-tuning."
echo ""
echo "Next steps:"
echo "1. Wait for your production run to complete"
echo "2. Run: python finetune_setup.py --data_dir production_run_01_complete_dataset --install_deps"
echo "3. Or test with existing data: python finetune_setup.py --data_dir test_runs/run_05_physics_completely_fixed --max_samples 100" 