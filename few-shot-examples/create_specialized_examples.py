#!/usr/bin/env python3
"""
create_specialized_examples.py

Generate specialized COMSOL examples focused on specific physics types.
This script analyzes smodel.json files to identify physics types and allows
users to generate examples for specific domains like electromagnetism.
"""

import os
import re
import json
import glob
import argparse
from pathlib import Path
from typing import List, Dict, Tuple, Optional, Set
import subprocess
from collections import defaultdict

# Import the base example generator
from create_few_shot_examples import HighLevelExampleGenerator


class SpecializedExampleGenerator(HighLevelExampleGenerator):
    def __init__(self, llm_provider="lambda", api_key=None, api_base=None):
        super().__init__(llm_provider, api_key, api_base)
        self.physics_categories = self._define_physics_categories()
    
    def generate_comprehensive_model_description(self, m_path: str, metadata: Dict) -> str:
        """Generate a comprehensive, but concise description of the COMSOL model."""
        
        # Read the complete MATLAB code
        with open(m_path, 'r') as f:
            full_code = f.read()
        
        # Generate concise high-level overview
        overview_prompt = f"""
Analyze this COMSOL MATLAB script and provide a concise, high-level description suitable for few-shot prompting.

Model Information:
- Name: {metadata.get('model_name', 'Unknown')}
- Module: {metadata.get('module', 'Unknown')}
- Category: {metadata.get('category', 'Unknown')}

Complete MATLAB Code:
```matlab
{full_code}
```

Provide a concise overview (aim for 300-500 words) including:

1. **Model Purpose**: What engineering problem does this solve? What is being simulated?

2. **Physics Involved**: What physics interfaces are used (e.g., Solid Mechanics, Heat Transfer, Fluid Flow, Electromagnetism)?

3. **Geometry Description**: Brief description of the geometry being modeled (2D/3D, key features)

4. **Key Features**: What are the main simulation aspects (boundary conditions, materials, multiphysics coupling)?

5. **Study Type**: What type of analysis is performed (stationary, time-dependent, eigenfrequency, parametric)?

6. **Expected Results**: What outputs/insights does this model provide?

Keep the description informative but concise - focus on the engineering significance and key simulation aspects rather than code details.
"""
        
        description = self._call_llm(overview_prompt)
        
        if not description:
            # Fallback to basic description
            description = self.generate_basic_description(m_path, metadata)
        
        return description

    def generate_basic_description(self, m_path: str, metadata: Dict) -> str:
        """Generate a basic description without LLM (fallback)."""
        with open(m_path, 'r') as f:
            code = f.read()
        
        # Extract some basic info from code patterns
        lines = code.split('\n')
        
        # Detect physics types
        physics_types = []
        if 'SolidMechanics' in code:
            physics_types.append('Solid Mechanics')
        if 'HeatTransfer' in code:
            physics_types.append('Heat Transfer')
        if 'LaminarFlow' in code:
            physics_types.append('Fluid Flow')
        if 'Electrostatics' in code or 'ElectromagneticWaves' in code:
            physics_types.append('Electromagnetics')
        if 'DilutedSpecies' in code or 'ConcentratedSpecies' in code:
            physics_types.append('Mass Transport')
        
        # Detect geometry dimension
        if '.geom.create(' in code:
            if ', 3)' in code:
                geometry_dim = "3D"
            elif ', 2)' in code:
                geometry_dim = "2D"
            else:
                geometry_dim = "Unknown dimension"
        else:
            geometry_dim = "Unknown dimension"
        
        # Detect study types
        study_types = []
        if 'Stationary' in code:
            study_types.append('Stationary Analysis')
        if 'Eigenfrequency' in code:
            study_types.append('Modal Analysis')
        if 'TimeDepen' in code:
            study_types.append('Transient Analysis')
        if 'Parametric' in code:
            study_types.append('Parametric Study')
        
        description = f"""
**Model Purpose**: This is a {metadata.get('module', 'COMSOL')} simulation model for {metadata.get('category', 'engineering analysis')}.

**Physics Involved**: {', '.join(physics_types) if physics_types else 'Multiple physics interfaces'}

**Geometry**: {geometry_dim} model with {len(lines)} lines of MATLAB code

**Study Type**: {', '.join(study_types) if study_types else 'Engineering analysis'}

**Model Features**: 
- Model creation and geometry definition
- Material property assignment  
- Physics interface setup
- Boundary condition specification
- Mesh generation
- Study configuration and solving

**Engineering Application**: This model is designed for simulation and analysis in the {metadata.get('module', 'engineering')} domain, providing insights into system behavior and performance characteristics.
"""
        return description.strip()
    
    def _define_physics_categories(self) -> Dict[str, List[str]]:
        """Define physics categories with their associated API types."""
        return {
            "Electromagnetism": [
                "Electrostatics", "ElectrostaticsBoundaryElements", "ConductiveMedia",
                "ElectricCurrentsShell", "ElectricInductionCurrents", "InductionCurrents",
                "MagneticFieldFormulation", "MagneticFieldsCurrentsOnly", 
                "MagneticFieldsNoCurrentsBoundaryElements", "MagnetostaticsNoCurrents",
                "ElectromagneticWaves", "ElectromagneticWavesBEM", 
                "ElectromagneticWavesBeamEnvelopes", "ElectromagneticWavesFrequencyDomain",
                "ElectromagneticWavesTransient", "TransientElectromagneticWaves",
                "MagneticMachineryTimePeriodic", "RotatingMachineryMagnetic"
            ],
            "Fluid_Dynamics": [
                "LaminarFlow", "TurbulentFlowkeps", "TurbulentFlowkomega", "TurbulentFlowSST",
                "TurbulentFlowv2f", "TurbulentFlowAlgebraicYplus", "TurbulentFlowlowRekeps",
                "CreepingFlow", "CompressiblePotentialFlow", "IncompressiblePotentialFlow",
                "HighMachNumberFlow", "HighMachNumberFlowTurbulentSpalartAllmaras",
                "HighMachNumberFlowTurbulentkeps", "FlowInPipes", "NonisothermalPipeFlow",
                "SlipFlow", "FreeMolecularFlow", "LaminarBubblyFlow", "BubblyFlowkeps",
                "LaminarEulerEulerModel", "ViscoelasticFlow", "ThinFilmFlowDomain",
                "ThinFilmFlowEdge", "ThinFilmFlowShell", "HydrodynamicBearing"
            ],
            "Heat_Transfer": [
                "HeatTransfer", "HeatTransferInFluids", "HeatTransferInSolids",
                "HeatTransferInSolidsAndFluids", "HeatTransferInBuildingMaterials",
                "HeatTransferInMoistAir", "HeatTransferInFilmsLM", "HeatTransferInShellsLM",
                "HeatTransferPipes", "PorousMediaHeatTransfer", "BioHeat", "HeatEquation",
                "ParticipatingMediaRadiation", "SurfaceToSurfaceRadiation",
                "NonisothermalPipeFlow", "LumpedThermalSystem"
            ],
            "Structural_Mechanics": [
                "SolidMechanics", "Shell", "LayeredShell", "StructuralMembrane", "Truss",
                "BeamCrossSection", "BeamRotor", "SolidRotor", "SolidRotorFixedFrame",
                "LumpedMechanicalSystem", "MultibodyDynamics", "PipeMechanics",
                "DeformedGeometry", "Fatigue", "Wire"
            ],
            "Acoustics": [
                "PressureAcoustics", "PressureAcousticsBoundaryElements",
                "PressureAcousticsTimeExplicit", "PressureAcousticsAsymptoticScattering",
                "BoundaryModeAcoustics", "LinearizedPotentialFlowBoundaryMode",
                "LinearizedPotentialFlowFrequency", "LinearizedNavierStokesFrequency",
                "ConvectedWaveEquation", "AcousticDiffusionEquation", "RayAcoustics",
                "FrequencyPipeAcoustics", "TransientPipeAcoustics", "TransientPressureAcoustics",
                "ElasticWavesTimeExplicit", "PoroelasticWavesSinglePhysics",
                "ThermoacousticsSinglePhysics", "ThermoacousticsSinglePhysicsTransient",
                "NonlinearPressureAcousticsTimeExplicit", "WaterHammer"
            ],
            "Electrochemistry": [
                "PrimaryCurrentDistribution", "SecondaryCurrentDistribution",
                "TertiaryCurrentDistributionNernstPlanck", "TertiaryElectroanalysis",
                "ElectrodeShell", "CathodicProtection", "CurrentDistributionBEM",
                "CurrentDistributionPipe", "CurrentDistributionShell"
            ],
            "Battery_Technology": [
                "LithiumIonBatteryMPH", "LumpedBattery", "SingleParticleBattery",
                "LeadAcidBattery", "BatteryBinaryElectrolyte", "BatteryPack",
                "HydrogenFuelCell", "WaterElectrolyzer"
            ],
            "Chemical_Reactions": [
                "Chemistry", "DilutedSpecies", "ConcentratedSpecies", "ReactionEng",
                "DilutedSpeciesInPorousMedia", "DilutedSpeciesInPorousCatalysts",
                "ConcentratedSpeciesInPorousMedia", "ConcentratedSpeciesInVapor",
                "SurfaceReactions", "ElectrophoreticTransport", "ChargeTransport",
                "HeavySpeciesTransport", "TransportInSolids"
            ],
            "Semiconductors": [
                "Semiconductor", "SchrodingerEquation", "BoltzmannEquation",
                "ElectricalBreakdownDetection"
            ],
            "Plasma_Physics": [
                "ColdPlasma", "ColdPlasmaTimePeriodic"
            ],
            "Particle_Tracing": [
                "ChargedParticleTracing", "FluidParticleTracing", "MathParticle",
                "GeometricalOptics", "RayAcoustics"
            ],
            "Porous_Media": [
                "PorousMediaFlowDarcy", "PorousMediaFlowBrinkman", "PorousMediaFlowRichards",
                "FreeAndPorousMediaFlow", "DilutedSpeciesInPorousMedia",
                "ConcentratedSpeciesInPorousMedia", "PorousMediaHeatTransfer",
                "PhaseTransportPorousMedia", "PhaseTransportFreePorousMedia",
                "LevelSetPorousMedia"
            ],
            "Multiphase_Flow": [
                "LevelSet", "PhaseField", "TernaryPhaseField", "PhaseTransport",
                "LaminarBubblyFlow", "BubblyFlowkeps", "LaminarEulerEulerModel",
                "VolumeAveragedMixtureModelLaminar", "ShallowWaterEquationsTimeExplicit"
            ],
            "Wave_Optics": [
                "ElectromagneticWaves", "ElectromagneticWavesBEM", 
                "ElectromagneticWavesBeamEnvelopes", "ElectromagneticWavesFrequencyDomain",
                "ElectromagneticWavesTransient", "GeometricalOptics", "HermitianBeam"
            ],
            "Mathematical_Physics": [
                "CoefficientFormPDE", "CoefficientFormBoundaryPDE", "CoefficientFormEdgePDE",
                "GeneralFormPDE", "GeneralFormBoundaryPDE", "WeakFormPDE", "WeakFormBoundaryPDE",
                "ConvectionDiffusionEquation", "StabilizedConvectionDiffusionEquation",
                "LaplaceEquation", "GlobalEquations", "DomainODE", "BoundaryODE", "Events"
            ]
        }
    
    def get_all_physics_types(self, data_dir: str) -> Set[str]:
        """Extract all unique physics types from smodel.json files."""
        physics_types = set()
        smodel_files = glob.glob(os.path.join(data_dir, "**/smodel.json"), recursive=True)
        
        for smodel_file in smodel_files:
            try:
                with open(smodel_file, 'r') as f:
                    content = f.read()
                    # Extract physics API types
                    matches = re.findall(r'"apiClass":"Physics","apiType":"([^"]*)"', content)
                    physics_types.update(matches)
            except Exception as e:
                print(f"   ⚠️ Error reading {smodel_file}: {e}")
        
        return physics_types
    
    def find_models_by_physics(self, data_dir: str, physics_types: List[str]) -> List[str]:
        """Find all models that use specific physics types."""
        matching_models = []
        smodel_files = glob.glob(os.path.join(data_dir, "**/smodel.json"), recursive=True)
        
        print(f"🔍 Searching through {len(smodel_files)} model files...")
        
        for smodel_file in smodel_files:
            try:
                with open(smodel_file, 'r') as f:
                    content = f.read()
                    
                # Check if any of the target physics types are present
                for physics_type in physics_types:
                    pattern = rf'"apiClass":"Physics","apiType":"{physics_type}"'
                    if re.search(pattern, content):
                        # Find corresponding .m file
                        model_dir = os.path.dirname(smodel_file)
                        m_files = glob.glob(os.path.join(model_dir, "*.m"))
                        if m_files:
                            matching_models.append(m_files[0])  # Take the first .m file
                            print(f"   ✅ Found {physics_type} model: {Path(m_files[0]).name}")
                        break
                        
            except Exception as e:
                print(f"   ⚠️ Error processing {smodel_file}: {e}")
                continue
        
        return matching_models
    
    def display_physics_menu(self) -> str:
        """Display available physics categories and get user choice."""
        print("\n🔬 Available Physics Categories:")
        print("=" * 50)
        
        categories = list(self.physics_categories.keys())
        for i, category in enumerate(categories, 1):
            physics_count = len(self.physics_categories[category])
            print(f"{i:2d}. {category.replace('_', ' '):<25} ({physics_count} physics types)")
        
        print(f"{len(categories)+1:2d}. Custom (specify physics types)")
        print(f"{len(categories)+2:2d}. Show all available physics types")
        
        while True:
            try:
                choice = input(f"\nSelect category (1-{len(categories)+2}): ").strip()
                choice_num = int(choice)
                
                if 1 <= choice_num <= len(categories):
                    selected_category = categories[choice_num - 1]
                    print(f"\n✅ Selected: {selected_category.replace('_', ' ')}")
                    print(f"Physics types: {', '.join(self.physics_categories[selected_category])}")
                    return selected_category
                
                elif choice_num == len(categories) + 1:
                    return "Custom"
                
                elif choice_num == len(categories) + 2:
                    return "ShowAll"
                
                else:
                    print(f"❌ Invalid choice. Please enter 1-{len(categories)+2}")
                    
            except ValueError:
                print("❌ Please enter a valid number")
    
    def get_custom_physics_types(self, data_dir: str) -> List[str]:
        """Allow user to specify custom physics types."""
        all_physics = sorted(self.get_all_physics_types(data_dir))
        
        print(f"\n📋 Available physics types ({len(all_physics)} total):")
        print("=" * 60)
        
        # Display in columns
        for i in range(0, len(all_physics), 3):
            row = all_physics[i:i+3]
            print(f"{row[0]:<30} {row[1] if len(row) > 1 else '':<30} {row[2] if len(row) > 2 else ''}")
        
        print("\nEnter physics types separated by commas (or partial names for matching):")
        user_input = input("Physics types: ").strip()
        
        if not user_input:
            return []
        
        # Parse user input
        requested_types = [t.strip() for t in user_input.split(',')]
        matched_types = []
        
        for req_type in requested_types:
            # Exact match first
            if req_type in all_physics:
                matched_types.append(req_type)
            else:
                # Partial match
                matches = [p for p in all_physics if req_type.lower() in p.lower()]
                if matches:
                    print(f"   🔍 '{req_type}' matched: {', '.join(matches)}")
                    matched_types.extend(matches)
                else:
                    print(f"   ⚠️ No matches found for '{req_type}'")
        
        return list(set(matched_types))  # Remove duplicates
    
    def process_specialized_models(self, data_dir: str, category: str = None, 
                                 physics_types: List[str] = None, max_examples: int = 20,
                                 output_file: str = None) -> List[Dict]:
        """Process models for a specific physics category."""
        
        # Handle menu selection
        if category is None:
            category = self.display_physics_menu()
        
        if category == "ShowAll":
            all_physics = sorted(self.get_all_physics_types(data_dir))
            print(f"\n📋 All available physics types ({len(all_physics)} total):")
            print("=" * 60)
            for i, physics_type in enumerate(all_physics, 1):
                print(f"{i:3d}. {physics_type}")
            return []
        
        # Determine physics types to search for
        if category == "Custom":
            target_physics = self.get_custom_physics_types(data_dir)
            category_name = "Custom_Physics"
        elif physics_types:
            target_physics = physics_types
            category_name = "Custom_Physics"
        else:
            target_physics = self.physics_categories.get(category, [])
            category_name = category
        
        if not target_physics:
            print("❌ No physics types specified")
            return []
        
        print(f"\n🎯 Searching for models with: {', '.join(target_physics)}")
        
        # Find matching models
        matching_models = self.find_models_by_physics(data_dir, target_physics)
        
        if not matching_models:
            print(f"❌ No models found with the specified physics types")
            return []
        
        print(f"\n📊 Found {len(matching_models)} matching models")
        
        # Limit examples
        if len(matching_models) > max_examples:
            print(f"📏 Limiting to {max_examples} examples")
            matching_models = matching_models[:max_examples]
        
        # Set output file name
        if output_file is None:
            output_file = f"comsol_{category_name.lower()}_examples.md"
        
        # Process the models
        examples = []
        for i, m_path in enumerate(matching_models, 1):
            print(f"\n📊 Progress: {i}/{len(matching_models)}")
            
            example = self.process_single_model(m_path)
            if example:
                # Add physics category info
                example["physics_category"] = category_name
                example["target_physics"] = target_physics
                examples.append(example)
            
            # Save intermediate results every 5 examples
            if i % 5 == 0:
                self.save_specialized_examples(examples, f"intermediate_{output_file}", category_name)
                print(f"   💾 Saved intermediate results ({len(examples)} examples)")
        
        # Save final results
        self.save_specialized_examples(examples, output_file, category_name)
        print(f"\n✅ Generated {len(examples)} specialized examples for {category_name}")
        print(f"📄 Saved to: {output_file}")
        
        return examples
    
    def save_specialized_examples(self, examples: List[Dict], output_file: str, category: str):
        """Save specialized examples to a markdown file."""
        
        with open(output_file, 'w') as f:
            f.write(f"# COMSOL {category.replace('_', ' ')} Examples\n\n")
            f.write("This file contains concise, high-level COMSOL model descriptions and MATLAB scripts ")
            f.write(f"focused on **{category.replace('_', ' ')}** physics.\n\n")
            
            if examples:
                target_physics = examples[0].get("target_physics", [])
                f.write(f"**Target Physics Types:** {', '.join(target_physics)}\n\n")
            
            f.write(f"**Total Examples:** {len(examples)}\n\n")
            f.write("---\n\n")
            
            for i, example in enumerate(examples, 1):
                f.write(f"# Example {i}: {example['model_name']}\n\n")
                f.write(f"**Module:** {example['module']}  \n")
                f.write(f"**Category:** {example['category']}  \n")
                f.write(f"**Physics Category:** {example.get('physics_category', 'Unknown')}  \n\n")
                
                f.write("## Model Description\n\n")
                f.write(f"{example['description']}\n\n")
                
                f.write("## Complete COMSOL MATLAB Code\n\n")
                f.write("```matlab\n")
                f.write(f"{example['matlab_code']}\n")
                f.write("```\n\n")
                f.write("---\n\n")


def main():
    parser = argparse.ArgumentParser(description="Generate specialized COMSOL examples by physics type")
    parser.add_argument("--data_dir", type=str, required=True,
                       help="Directory containing COMSOL models (searches recursively)")
    parser.add_argument("--category", type=str, default=None,
                       help="Physics category (Electromagnetism, Fluid_Dynamics, etc.)")
    parser.add_argument("--physics_types", type=str, nargs="+", default=None,
                       help="Specific physics types to search for")
    parser.add_argument("--max_examples", type=int, default=20,
                       help="Maximum number of examples to generate")
    parser.add_argument("--output_file", type=str, default=None,
                       help="Output markdown file")
    parser.add_argument("--api_key", type=str, default=None,
                       help="API key for LLM (or set LLM_API_KEY env var)")
    parser.add_argument("--api_base", type=str, default=None,
                       help="API base URL (or set LLM_API_BASE env var)")
    parser.add_argument("--interactive", action="store_true",
                       help="Show interactive menu for physics selection")
    
    args = parser.parse_args()
    
    # Initialize generator
    print("🚀 Initializing Specialized Example Generator...")
    generator = SpecializedExampleGenerator(
        llm_provider="lambda",
        api_key=args.api_key,
        api_base=args.api_base
    )
    
    # Process models
    if args.interactive or (not args.category and not args.physics_types):
        category = None  # Will show menu
    else:
        category = args.category
    
    examples = generator.process_specialized_models(
        data_dir=args.data_dir,
        category=category,
        physics_types=args.physics_types,
        max_examples=args.max_examples,
        output_file=args.output_file
    )
    
    if examples:
        print(f"\n🎉 Successfully generated {len(examples)} specialized examples!")
        if args.output_file:
            print(f"📁 Output saved to: {args.output_file}")


if __name__ == "__main__":
    main() 