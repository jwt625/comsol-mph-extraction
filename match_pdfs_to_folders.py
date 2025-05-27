#!/usr/bin/env python3
"""
Script to match COMSOL PDF documentation files to their corresponding 
extracted metadata folders and copy them.

Updated to handle module distinctions (e.g., models.heat.heat_sink.pdf vs models.cfd.heat_sink.pdf)

Usage:
    python3 match_pdfs_to_folders.py
"""

import os
import re
import shutil
import sys
from pathlib import Path
from typing import Dict, List, Tuple, Optional

# Configuration
PDF_SOURCE_DIR = "/Applications/COMSOL62/Multiphysics/doc/help/wtpwebapps/ROOT/doc/pdfs"
MPHS_DIR = "./mphs"
FILE_LIST_PATH = "./file_list.txt"
LOG_FILE = "pdf_matching_log.txt"

# Module mappings - maps PDF module prefixes to folder module names
MODULE_MAPPINGS = {
    'acdc': 'ACDC_Module',
    'aco': 'Acoustics_Module', 
    'battery': 'Battery_Design_Module',
    'cad': 'CAD_Import_Module',
    'cfd': 'CFD_Module',
    'chemical': 'Chemical_Reaction_Engineering_Module',
    'comsol': 'COMSOL_Multiphysics',
    'corrosion': 'Corrosion_Module',
    'design': 'Design_Module',
    'electrodeposition': 'Electrodeposition_Module',
    'fatigue': 'Fatigue_Module',
    'geomechanics': 'Geomechanics_Module',
    'heat': 'Heat_Transfer_Module',
    'llb': 'Liquid_and_Gas_Properties_Module',
    'lvset': 'Level_Set_Module',
    'mbd': 'Multibody_Dynamics_Module',
    'mems': 'MEMS_Module',
    'mfl': 'Microfluidics_Module',
    'mixer': 'Mixer_Module',
    'molec': 'Molecular_Flow_Module',
    'optimization': 'Optimization_Module',
    'particle': 'Particle_Tracing_Module',
    'pde': 'Mathematics_Module',
    'plasma': 'Plasma_Module',
    'polymer': 'Polymer_Flow_Module',
    'porous': 'Porous_Media_Flow_Module',
    'ray': 'Ray_Optics_Module',
    'rf': 'RF_Module',
    'semicond': 'Semiconductor_Module',
    'sme': 'Structural_Mechanics_Module',
    'subsurface': 'Subsurface_Flow_Module',
    'uq': 'Uncertainty_Quantification_Module',
    'woptics': 'Wave_Optics_Module'
}

def setup_logging():
    """Setup logging to both console and file."""
    import logging
    
    # Create logger
    logger = logging.getLogger('pdf_matcher')
    logger.setLevel(logging.INFO)
    
    # Create formatters
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    
    # Console handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # File handler
    file_handler = logging.FileHandler(LOG_FILE, mode='w')
    file_handler.setLevel(logging.INFO)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    return logger

def extract_model_and_module_from_pdf(pdf_filename: str) -> Optional[Tuple[str, str]]:
    """
    Extract both model identifier and module from PDF filename.
    
    Example: 'models.heat.heat_sink.pdf' -> ('heat_sink', 'heat')
    Example: 'models.cfd.heat_sink.pdf' -> ('heat_sink', 'cfd')
    """
    if not pdf_filename.startswith('models.') or not pdf_filename.endswith('.pdf'):
        return None
    
    # Remove 'models.' prefix and '.pdf' suffix
    name_part = pdf_filename[7:-4]  # Remove 'models.' and '.pdf'
    
    # Split by dots
    parts = name_part.split('.')
    if len(parts) >= 2:
        module = parts[0]  # First part is the module
        model_id = parts[-1]  # Last part is the model identifier
        return (model_id, module)
    
    return None

def load_file_list_with_modules(file_list_path: str) -> Dict[Tuple[str, str], str]:
    """
    Load file_list.txt and create a mapping from (model_id, module) to file path.
    
    Returns:
        Dict mapping (model_id, module_name) to original file path
    """
    model_module_to_path = {}
    
    try:
        with open(file_list_path, 'r') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line:
                    continue
                
                # Extract model_id and module from the file path
                # Example: 'Heat_Transfer_Module/Tutorials,_Forced_and_Natural_Convection/heat_sink.mph'
                if line.endswith('.mph'):
                    path_parts = line.split('/')
                    if len(path_parts) >= 1:
                        module_name = path_parts[0]  # e.g., 'Heat_Transfer_Module'
                        model_id = Path(line).stem  # Get filename without extension
                        
                        # Create key as (model_id, module_name)
                        key = (model_id, module_name)
                        model_module_to_path[key] = line
                        
    except FileNotFoundError:
        raise FileNotFoundError(f"File list not found: {file_list_path}")
    except Exception as e:
        raise Exception(f"Error reading file list: {e}")
    
    return model_module_to_path

def find_best_match(model_id: str, pdf_module: str, model_module_to_path: Dict[Tuple[str, str], str], logger) -> Optional[str]:
    """
    Find the best matching file path for a given model_id and PDF module.
    
    Args:
        model_id: The model identifier (e.g., 'heat_sink')
        pdf_module: The module from PDF filename (e.g., 'heat', 'cfd')
        model_module_to_path: Dictionary mapping (model_id, module) to file paths
        
    Returns:
        Best matching file path or None if no match found
    """
    
    # First, try exact module mapping
    if pdf_module in MODULE_MAPPINGS:
        target_module = MODULE_MAPPINGS[pdf_module]
        exact_key = (model_id, target_module)
        if exact_key in model_module_to_path:
            logger.info(f"    Found exact match: {pdf_module} -> {target_module}")
            return model_module_to_path[exact_key]
    
    # If no exact module mapping, look for partial matches in folder names
    matching_keys = [key for key in model_module_to_path.keys() if key[0] == model_id]
    
    if len(matching_keys) == 0:
        return None
    elif len(matching_keys) == 1:
        logger.info(f"    Found unique model match: {matching_keys[0][1]}")
        return model_module_to_path[matching_keys[0]]
    else:
        # Multiple matches - need to find the right module
        logger.info(f"    Multiple matches found for {model_id}: {[key[1] for key in matching_keys]}")
        
        # Extended module mappings for special cases
        extended_mappings = {
            'echem': ['Electrochemistry_Module', 'Chemical_Reaction_Engineering_Module'],
            'edecm': ['Electrodeposition_Module'],
            'fce': ['Fuel_Cell_and_Electrolyzer_Module'],
            'battery': ['Battery_Design_Module'],
            'corrosion': ['Corrosion_Module'],
            'llrevit': ['CAD_Import_Module'],
            'llac': ['CAD_Import_Module'],
            'llcreop': ['CAD_Import_Module'],
            'llinventor': ['CAD_Import_Module'],
            'llse': ['CAD_Import_Module'],
            'llsw': ['CAD_Import_Module'],
            'cad': ['CAD_Import_Module'],
            'compmat': ['Composite_Materials_Module', 'ACDC_Module'],
            'lgp': ['Liquid_and_Gas_Properties_Module', 'Acoustics_Module']
        }
        
        # Try extended mappings first
        if pdf_module in extended_mappings:
            possible_modules = extended_mappings[pdf_module]
            for possible_module in possible_modules:
                for key in matching_keys:
                    if key[1] == possible_module:
                        logger.info(f"    Selected via extended mapping: {pdf_module} -> {possible_module}")
                        return model_module_to_path[key]
        
        # If still no match, try partial string matching
        for key in matching_keys:
            module_name = key[1].lower()
            pdf_module_lower = pdf_module.lower()
            
            # Check for partial matches
            if (pdf_module_lower in module_name or 
                any(part in module_name for part in pdf_module_lower.split('_')) or
                module_name.replace('_', '').startswith(pdf_module_lower[:4])):
                logger.info(f"    Selected based on partial matching: {key[1]}")
                return model_module_to_path[key]
        
        # Special case handling for known ambiguous mappings
        if pdf_module == 'echem' and any('Electrochemistry_Module' in key[1] for key in matching_keys):
            for key in matching_keys:
                if 'Electrochemistry_Module' in key[1]:
                    logger.info(f"    Selected Electrochemistry_Module for echem: {key[1]}")
                    return model_module_to_path[key]
        
        # If no clear match found, log warning and skip
        logger.warning(f"    No clear module match found for {pdf_module} with model {model_id}")
        logger.warning(f"    Available modules: {[key[1] for key in matching_keys]}")
        return None
    
    return None

def convert_path_to_folder_name(file_path: str) -> str:
    """
    Convert file path to corresponding folder name in mphs directory.
    
    Example: 'Heat_Transfer_Module/Tutorials,_Forced_and_Natural_Convection/heat_sink.mph'
             -> 'Heat_Transfer_Module_Tutorials,_Forced_and_Natural_Convection_heat_sink'
    """
    # Remove .mph extension
    path_without_ext = file_path.replace('.mph', '')
    
    # Replace slashes with underscores
    folder_name = path_without_ext.replace('/', '_').replace('\\', '_')
    
    return folder_name

def find_pdf_files(pdf_dir: str) -> List[str]:
    """Find all PDF files in the source directory."""
    try:
        pdf_files = [f for f in os.listdir(pdf_dir) 
                    if f.endswith('.pdf') and f.startswith('models.')]
        return sorted(pdf_files)
    except FileNotFoundError:
        raise FileNotFoundError(f"PDF directory not found: {pdf_dir}")

def copy_pdf_to_folder(pdf_source_path: str, target_folder: str, pdf_filename: str, logger) -> bool:
    """
    Copy PDF file to target folder.
    
    Returns:
        True if successful, False otherwise
    """
    try:
        # Create target folder if it doesn't exist
        os.makedirs(target_folder, exist_ok=True)
        
        # Define target path
        target_path = os.path.join(target_folder, pdf_filename)
        
        # Copy file
        shutil.copy2(pdf_source_path, target_path)
        
        # Verify copy
        if os.path.exists(target_path):
            source_size = os.path.getsize(pdf_source_path)
            target_size = os.path.getsize(target_path)
            if source_size == target_size:
                logger.info(f"✓ Successfully copied {pdf_filename} to {target_folder}")
                return True
            else:
                logger.error(f"✗ Size mismatch after copying {pdf_filename}")
                return False
        else:
            logger.error(f"✗ Target file not found after copy: {target_path}")
            return False
            
    except Exception as e:
        logger.error(f"✗ Error copying {pdf_filename}: {e}")
        return False

def main():
    """Main function to match and copy PDF files."""
    logger = setup_logging()
    
    logger.info("=== COMSOL PDF to Folder Matcher (Module-Aware) ===")
    logger.info(f"PDF source directory: {PDF_SOURCE_DIR}")
    logger.info(f"MPHS directory: {MPHS_DIR}")
    logger.info(f"File list: {FILE_LIST_PATH}")
    logger.info("")
    
    # Verify directories exist
    if not os.path.exists(PDF_SOURCE_DIR):
        logger.error(f"PDF source directory not found: {PDF_SOURCE_DIR}")
        return 1
    
    if not os.path.exists(MPHS_DIR):
        logger.error(f"MPHS directory not found: {MPHS_DIR}")
        return 1
    
    if not os.path.exists(FILE_LIST_PATH):
        logger.error(f"File list not found: {FILE_LIST_PATH}")
        return 1
    
    try:
        # Load file list mapping with module information
        logger.info("Loading file list with module information...")
        model_module_to_path = load_file_list_with_modules(FILE_LIST_PATH)
        logger.info(f"Loaded {len(model_module_to_path)} model entries from file list")
        
        # Find PDF files
        logger.info("Finding PDF files...")
        pdf_files = find_pdf_files(PDF_SOURCE_DIR)
        logger.info(f"Found {len(pdf_files)} PDF files")
        
        # Statistics
        stats = {
            'total_pdfs': len(pdf_files),
            'matched': 0,
            'copied': 0,
            'failed_match': 0,
            'failed_copy': 0,
            'exact_matches': 0,
            'partial_matches': 0
        }
        
        # Process each PDF
        logger.info("\nProcessing PDF files...")
        logger.info("-" * 80)
        
        unmatched_pdfs = []
        matched_but_failed_copy = []
        
        for i, pdf_filename in enumerate(pdf_files, 1):
            logger.info(f"[{i:3d}/{stats['total_pdfs']:3d}] Processing: {pdf_filename}")
            
            # Extract model ID and module
            result = extract_model_and_module_from_pdf(pdf_filename)
            if not result:
                logger.warning(f"    Could not extract model info from {pdf_filename}")
                stats['failed_match'] += 1
                unmatched_pdfs.append(pdf_filename)
                continue
            
            model_id, pdf_module = result
            logger.info(f"    Model ID: {model_id}, Module: {pdf_module}")
            
            # Find matching file path
            file_path = find_best_match(model_id, pdf_module, model_module_to_path, logger)
            
            if not file_path:
                logger.warning(f"    No match found for model ID: {model_id} in module: {pdf_module}")
                stats['failed_match'] += 1
                unmatched_pdfs.append(pdf_filename)
                continue
            
            # Found match
            folder_name = convert_path_to_folder_name(file_path)
            target_folder = os.path.join(MPHS_DIR, folder_name)
            
            logger.info(f"    File path: {file_path}")
            logger.info(f"    Target folder: {folder_name}")
            
            stats['matched'] += 1
            
            # Check if target folder exists
            if not os.path.exists(target_folder):
                logger.warning(f"    Target folder does not exist: {target_folder}")
                stats['failed_copy'] += 1
                matched_but_failed_copy.append((pdf_filename, target_folder))
                continue
            
            # Copy PDF file
            pdf_source_path = os.path.join(PDF_SOURCE_DIR, pdf_filename)
            if copy_pdf_to_folder(pdf_source_path, target_folder, pdf_filename, logger):
                stats['copied'] += 1
            else:
                stats['failed_copy'] += 1
                matched_but_failed_copy.append((pdf_filename, target_folder))
        
        # Print summary
        logger.info("\n" + "=" * 80)
        logger.info("SUMMARY")
        logger.info("=" * 80)
        logger.info(f"Total PDF files processed: {stats['total_pdfs']}")
        logger.info(f"Successfully matched: {stats['matched']}")
        logger.info(f"Successfully copied: {stats['copied']}")
        logger.info(f"Failed to match: {stats['failed_match']}")
        logger.info(f"Failed to copy: {stats['failed_copy']}")
        logger.info(f"Success rate: {stats['copied']/stats['total_pdfs']*100:.1f}%")
        
        # List unmatched PDFs
        if unmatched_pdfs:
            logger.info(f"\nUnmatched PDFs ({len(unmatched_pdfs)}):")
            for pdf in unmatched_pdfs[:10]:  # Show first 10
                logger.info(f"  - {pdf}")
            if len(unmatched_pdfs) > 10:
                logger.info(f"  ... and {len(unmatched_pdfs) - 10} more")
        
        # List matched but failed to copy
        if matched_but_failed_copy:
            logger.info(f"\nMatched but failed to copy ({len(matched_but_failed_copy)}):")
            for pdf, folder in matched_but_failed_copy[:10]:  # Show first 10
                logger.info(f"  - {pdf} -> {folder}")
            if len(matched_but_failed_copy) > 10:
                logger.info(f"  ... and {len(matched_but_failed_copy) - 10} more")
        
        logger.info(f"\nDetailed log saved to: {LOG_FILE}")
        
        return 0 if stats['failed_match'] == 0 and stats['failed_copy'] == 0 else 1
        
    except Exception as e:
        logger.error(f"Fatal error: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main()) 