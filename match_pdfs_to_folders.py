#!/usr/bin/env python3
"""
Script to match COMSOL PDF documentation files to their corresponding 
extracted metadata folders and copy them.

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

def extract_model_id_from_pdf(pdf_filename: str) -> Optional[str]:
    """
    Extract model identifier from PDF filename.
    
    Example: 'models.woptics.orbital_angular_momentum.pdf' -> 'orbital_angular_momentum'
    """
    if not pdf_filename.startswith('models.') or not pdf_filename.endswith('.pdf'):
        return None
    
    # Remove 'models.' prefix and '.pdf' suffix
    name_part = pdf_filename[7:-4]  # Remove 'models.' and '.pdf'
    
    # Split by dots and take the last part
    parts = name_part.split('.')
    if len(parts) >= 2:
        return parts[-1]  # Last part is the model identifier
    
    return None

def load_file_list(file_list_path: str) -> Dict[str, str]:
    """
    Load file_list.txt and create a mapping from model_id to file path.
    
    Returns:
        Dict mapping model_id to original file path
    """
    model_id_to_path = {}
    
    try:
        with open(file_list_path, 'r') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line:
                    continue
                
                # Extract model_id from the file path
                # Example: 'Wave_Optics_Module/Beam_Propagation/orbital_angular_momentum.mph'
                if line.endswith('.mph'):
                    model_id = Path(line).stem  # Get filename without extension
                    model_id_to_path[model_id] = line
                    
    except FileNotFoundError:
        raise FileNotFoundError(f"File list not found: {file_list_path}")
    except Exception as e:
        raise Exception(f"Error reading file list: {e}")
    
    return model_id_to_path

def convert_path_to_folder_name(file_path: str) -> str:
    """
    Convert file path to corresponding folder name in mphs directory.
    
    Example: 'Wave_Optics_Module/Beam_Propagation/orbital_angular_momentum.mph'
             -> 'Wave_Optics_Module_Beam_Propagation_orbital_angular_momentum'
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
    
    logger.info("=== COMSOL PDF to Folder Matcher ===")
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
        # Load file list mapping
        logger.info("Loading file list...")
        model_id_to_path = load_file_list(FILE_LIST_PATH)
        logger.info(f"Loaded {len(model_id_to_path)} model entries from file list")
        
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
            'failed_copy': 0
        }
        
        # Process each PDF
        logger.info("\nProcessing PDF files...")
        logger.info("-" * 80)
        
        unmatched_pdfs = []
        matched_but_failed_copy = []
        
        for i, pdf_filename in enumerate(pdf_files, 1):
            logger.info(f"[{i:3d}/{stats['total_pdfs']:3d}] Processing: {pdf_filename}")
            
            # Extract model ID
            model_id = extract_model_id_from_pdf(pdf_filename)
            if not model_id:
                logger.warning(f"    Could not extract model ID from {pdf_filename}")
                stats['failed_match'] += 1
                unmatched_pdfs.append(pdf_filename)
                continue
            
            # Find matching file path
            if model_id not in model_id_to_path:
                logger.warning(f"    No match found for model ID: {model_id}")
                stats['failed_match'] += 1
                unmatched_pdfs.append(pdf_filename)
                continue
            
            # Found match
            file_path = model_id_to_path[model_id]
            folder_name = convert_path_to_folder_name(file_path)
            target_folder = os.path.join(MPHS_DIR, folder_name)
            
            logger.info(f"    Model ID: {model_id}")
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