# LLM-Assisted COMSOL Fine-Tuning Data Architecture

## Problem Analysis

### Current State Issues

1. **Semantic Gap**: PDF instructions describe *what to do* ("Create a rectangle") while code shows *how to do it* (`model.geom('geom1').create('r1', 'Rectangle')`)

2. **Misaligned Granularity**: 
   - PDF steps are high-level conceptual actions
   - Code blocks are low-level API calls
   - No clear 1:1 correspondence

3. **Missing Context**: Current data lacks:
   - Why each step is important for the physics
   - How parameters relate to simulation goals
   - Connection between GUI actions and code

4. **Poor Alignment Quality**: Current regex-based alignment produces training examples where instruction and code don't match semantically

## Proposed Architecture

### Multi-Stage LLM-Assisted Pipeline

```
[PDF + Code + Metadata] 
    ↓
[Stage 1: Semantic Extraction]
    ↓
[Stage 2: Intelligent Alignment] 
    ↓
[Stage 3: Enhanced Training Examples]
    ↓
[High-Quality Fine-Tuning Data]
```

### Stage 1: Semantic Extraction

**Purpose**: Extract semantically meaningful units from both PDF and code

#### PDF Processing (`extract_modeling_steps`)
- **Input**: Raw PDF text
- **LLM Task**: Parse tutorial text into discrete conceptual steps
- **Output**: Structured steps with:
  - Clear action descriptions
  - COMSOL feature IDs
  - Categorization (geometry, physics, materials, etc.)
  - Pedagogical context

**Example Input**:
```
Rectangle 1 (r1)
1. In the Geometry toolbar, click Rectangle.
2. In the Settings window for Rectangle, locate the Size and Shape section.
3. In the Width text field, type sim_l.
```

**Example Output**:
```json
{
  "step_number": 1,
  "title": "Create Rectangle Geometry",
  "description": "Create a rectangular domain for the simulation",
  "instructions": "Set up the basic 2D rectangular geometry...",
  "comsol_ids": ["r1", "geom1"],
  "category": "geometry"
}
```

#### Code Processing (`extract_code_segments`)
- **Input**: COMSOL .m script
- **LLM Task**: Group code lines into logical segments
- **Output**: Semantically coherent code blocks with descriptions

**Example Input**:
```matlab
model.geom.create('geom1', 2);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'sim_l', 'sim_h'});
```

**Example Output**:
```json
{
  "segment_id": 1,
  "description": "Creates 2D geometry and rectangle r1",
  "code": "model.geom.create('geom1', 2);\nmodel.geom('geom1').create('r1', 'Rectangle');...",
  "comsol_ids": ["geom1", "r1"],
  "category": "geometry"
}
```

### Stage 2: Intelligent Alignment (`align_steps_to_code`)

**Purpose**: Create semantically meaningful step-to-code mappings

**LLM Task**: 
- Match steps and code segments by:
  - COMSOL feature ID overlap
  - Functional category similarity  
  - Semantic description matching
- Handle many-to-many relationships
- Provide confidence scores and reasoning

**Example Output**:
```json
{
  "step_id": 1,
  "code_segment_ids": [1, 2],
  "alignment_confidence": 0.9,
  "reasoning": "Both reference rectangle r1 and geometry creation"
}
```

### Stage 3: Enhanced Training Examples (`enhance_instructions`)

**Purpose**: Create pedagogical, context-rich instruction-code pairs

**LLM Task**:
- Enhance instructions with:
  - Physics motivation
  - Parameter explanations
  - Modeling intent
  - COMSOL-specific best practices

**Example Output**:
```json
{
  "instruction": "Create the simulation domain geometry for electromagnetic wave propagation",
  "input": "I need to set up a 2D rectangular domain for modeling second harmonic generation. The domain should be much longer than wide to simulate wave propagation.",
  "output": "// Create 2D geometry for wave propagation\nmodel.geom.create('geom1', 2);\n// Create rectangle with simulation length and height\nmodel.geom('geom1').create('r1', 'Rectangle');\nmodel.geom('geom1').feature('r1').set('size', {'sim_l', 'sim_h'});",
  "explanation": "The rectangular geometry serves as the simulation domain where electromagnetic waves will propagate. The length (sim_l) must be several wavelengths to observe wave behavior, while height (sim_h) can be minimal for 2D analysis."
}
```

## Implementation Details

### LLM Provider Support
- **Anthropic Claude**: Primary choice for advanced reasoning
- **OpenAI GPT-4**: Alternative provider
- **Fallback Mechanisms**: Regex-based extraction if LLM fails

### Quality Assurance
- **Confidence Scoring**: Each alignment gets a confidence score
- **Human Review**: Low-confidence alignments flagged for review  
- **Validation**: Compare against original successful model runs

### Scalability
- **Batch Processing**: Process multiple models in parallel
- **Caching**: Cache LLM responses to avoid re-processing
- **Incremental**: Process new models without re-analyzing existing ones

## Expected Benefits

### 1. Semantic Alignment
- Instructions match code functionality
- No more "Rectangle 1" → `model.physics.create()` mismatches

### 2. Educational Value
- Explains *why* each step matters for physics
- Connects GUI actions to underlying science
- Provides parameter context

### 3. Better Fine-Tuning
- Higher quality instruction-following
- Model learns physics reasoning, not just syntax
- More robust to variations in user queries

### 4. Maintainability
- Clear separation of extraction, alignment, and enhancement
- Easy to improve individual stages
- Comprehensive logging and analysis

## Usage Examples

### Basic Processing
```bash
python llm_assisted_alignment.py \
  --mphs_dir mphs \
  --output_dir enhanced_data \
  --llm_provider anthropic \
  --api_key $ANTHROPIC_API_KEY
```

### Testing on Small Sample
```bash
python llm_assisted_alignment.py \
  --mphs_dir mphs \
  --max_models 5 \
  --output_dir test_data
```

### Quality Analysis
```bash
# Check alignment quality
python analyze_alignments.py enhanced_data/

# Manual review of low-confidence alignments
python review_tool.py enhanced_data/ --confidence_threshold 0.7
```

## Future Enhancements

### Multi-Modal Learning
- Include screenshots/figures from PDFs
- Visual instruction understanding
- GUI → Code mapping

### Physics-Aware Validation
- Verify that generated code produces expected physics
- Cross-reference with simulation results
- Physics equation extraction and validation

### Interactive Refinement
- Human-in-the-loop alignment correction
- Active learning for difficult cases
- Continuous improvement from user feedback

### Domain Expansion
- Extend to other CAE software (ANSYS, Abaqus)
- Multi-physics coupling scenarios
- Industry-specific modeling patterns

## Cost Estimation

### LLM API Costs (for 1000 models)
- **Claude Sonnet**: ~$200-400 (depending on model complexity)
- **GPT-4 Turbo**: ~$150-300
- **Cost per model**: $0.20-0.40

### Processing Time
- **Per model**: 2-5 minutes with LLM calls
- **1000 models**: 35-85 hours with parallelization
- **Caching**: 50% reduction on subsequent runs

## Risk Mitigation

### LLM Reliability
- **Fallback mechanisms** for all LLM calls
- **Output validation** with JSON schema checking
- **Confidence thresholds** for automatic acceptance

### Quality Control
- **Human review** of representative samples
- **A/B testing** against current alignment
- **Physics validation** through simulation

### Cost Management
- **Token optimization** in prompts
- **Batch processing** efficiency
- **Caching strategy** for repeated content

This architecture transforms the COMSOL fine-tuning data from syntactic pattern matching to semantic understanding, creating a robust foundation for training physics-aware AI models. 