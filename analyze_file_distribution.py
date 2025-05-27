#!/usr/bin/env python3
"""
Script to analyze the distribution of .m files and PDF files across
all folders in the mphs directory.

This script will categorize folders into:
1. Folders with only .m files
2. Folders with both .m files and PDF files  
3. Folders with only PDF files
4. Folders with neither .m files nor PDF files
"""

import os
import sys
from pathlib import Path
from typing import Dict, List, Tuple
import logging

# Configuration
MPHS_DIR = "./mphs"
LOG_FILE = "file_distribution_analysis.txt"

def setup_logging():
    """Setup logging to both console and file."""
    
    # Create logger
    logger = logging.getLogger('file_analyzer')
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

def analyze_folder(folder_path: str) -> Tuple[bool, bool, List[str], List[str]]:
    """
    Analyze a folder to check for .m files and PDF files.
    
    Returns:
        (has_m_files, has_pdf_files, m_files, pdf_files)
    """
    m_files = []
    pdf_files = []
    
    try:
        for item in os.listdir(folder_path):
            item_path = os.path.join(folder_path, item)
            if os.path.isfile(item_path):
                if item.endswith('.m'):
                    m_files.append(item)
                elif item.endswith('.pdf'):
                    pdf_files.append(item)
    except PermissionError:
        pass  # Skip folders we can't read
    
    has_m_files = len(m_files) > 0
    has_pdf_files = len(pdf_files) > 0
    
    return has_m_files, has_pdf_files, m_files, pdf_files

def main():
    """Main function to analyze file distribution."""
    logger = setup_logging()
    
    logger.info("=== COMSOL File Distribution Analysis ===")
    logger.info(f"Analyzing directory: {MPHS_DIR}")
    logger.info("")
    
    if not os.path.exists(MPHS_DIR):
        logger.error(f"MPHS directory not found: {MPHS_DIR}")
        return 1
    
    # Categories
    folders_with_only_m = []           # Only .m files
    folders_with_both = []             # Both .m and PDF files
    folders_with_only_pdf = []         # Only PDF files  
    folders_with_neither = []          # Neither .m nor PDF files
    
    # Get all subdirectories
    try:
        all_folders = [d for d in os.listdir(MPHS_DIR) 
                      if os.path.isdir(os.path.join(MPHS_DIR, d))]
        all_folders.sort()
    except Exception as e:
        logger.error(f"Error reading MPHS directory: {e}")
        return 1
    
    logger.info(f"Found {len(all_folders)} folders to analyze")
    logger.info("")
    
    # Analyze each folder
    for i, folder_name in enumerate(all_folders, 1):
        if i % 100 == 0:  # Progress indicator
            logger.info(f"Progress: {i}/{len(all_folders)} folders analyzed...")
        
        folder_path = os.path.join(MPHS_DIR, folder_name)
        has_m, has_pdf, m_files, pdf_files = analyze_folder(folder_path)
        
        # Categorize
        if has_m and has_pdf:
            folders_with_both.append({
                'name': folder_name,
                'm_files': m_files,
                'pdf_files': pdf_files
            })
        elif has_m and not has_pdf:
            folders_with_only_m.append({
                'name': folder_name,
                'm_files': m_files,
                'pdf_files': []
            })
        elif not has_m and has_pdf:
            folders_with_only_pdf.append({
                'name': folder_name,
                'm_files': [],
                'pdf_files': pdf_files
            })
        else:
            folders_with_neither.append({
                'name': folder_name,
                'm_files': [],
                'pdf_files': []
            })
    
    # Generate summary
    logger.info("Analysis complete!")
    logger.info("")
    logger.info("=" * 80)
    logger.info("SUMMARY")
    logger.info("=" * 80)
    logger.info(f"Total folders analyzed: {len(all_folders)}")
    logger.info(f"Folders with only .m files: {len(folders_with_only_m)}")
    logger.info(f"Folders with both .m and PDF files: {len(folders_with_both)}")
    logger.info(f"Folders with only PDF files: {len(folders_with_only_pdf)}")
    logger.info(f"Folders with neither .m nor PDF files: {len(folders_with_neither)}")
    logger.info("")
    
    # Calculate percentages
    total = len(all_folders)
    logger.info("PERCENTAGES:")
    logger.info(f"Only .m files: {len(folders_with_only_m)/total*100:.1f}%")
    logger.info(f"Both .m and PDF: {len(folders_with_both)/total*100:.1f}%")
    logger.info(f"Only PDF files: {len(folders_with_only_pdf)/total*100:.1f}%")
    logger.info(f"Neither: {len(folders_with_neither)/total*100:.1f}%")
    logger.info("")
    
    # Detailed listings for small categories (< 20 items)
    categories = [
        ("Folders with only .m files", folders_with_only_m),
        ("Folders with both .m and PDF files", folders_with_both),
        ("Folders with only PDF files", folders_with_only_pdf),
        ("Folders with neither .m nor PDF files", folders_with_neither)
    ]
    
    for category_name, category_list in categories:
        logger.info("-" * 80)
        logger.info(f"{category_name.upper()} ({len(category_list)} folders)")
        logger.info("-" * 80)
        
        if len(category_list) == 0:
            logger.info("None")
        elif len(category_list) <= 20:
            # List all items
            for item in category_list:
                folder_name = item['name']
                m_count = len(item['m_files'])
                pdf_count = len(item['pdf_files'])
                
                logger.info(f"  {folder_name}")
                if m_count > 0:
                    logger.info(f"    .m files ({m_count}): {', '.join(item['m_files'])}")
                if pdf_count > 0:
                    logger.info(f"    PDF files ({pdf_count}): {', '.join(item['pdf_files'])}")
                if m_count == 0 and pdf_count == 0:
                    logger.info(f"    No .m or PDF files found")
                logger.info("")
        else:
            # List first 10 and last 10
            logger.info("First 10:")
            for item in category_list[:10]:
                folder_name = item['name']
                m_count = len(item['m_files'])
                pdf_count = len(item['pdf_files'])
                logger.info(f"  {folder_name} (.m: {m_count}, PDF: {pdf_count})")
            
            logger.info(f"... ({len(category_list) - 20} more) ...")
            
            logger.info("Last 10:")
            for item in category_list[-10:]:
                folder_name = item['name']
                m_count = len(item['m_files'])
                pdf_count = len(item['pdf_files'])
                logger.info(f"  {folder_name} (.m: {m_count}, PDF: {pdf_count})")
        
        logger.info("")
    
    # Additional statistics
    logger.info("=" * 80)
    logger.info("ADDITIONAL STATISTICS")
    logger.info("=" * 80)
    
    total_m_files = sum(len(item['m_files']) for category in [folders_with_only_m, folders_with_both] for item in category)
    total_pdf_files = sum(len(item['pdf_files']) for category in [folders_with_only_pdf, folders_with_both] for item in category)
    
    logger.info(f"Total .m files found: {total_m_files}")
    logger.info(f"Total PDF files found: {total_pdf_files}")
    logger.info(f"Folders with .m files: {len(folders_with_only_m) + len(folders_with_both)}")
    logger.info(f"Folders with PDF files: {len(folders_with_only_pdf) + len(folders_with_both)}")
    
    # Check for multiple files per folder
    folders_with_multiple_m = [item for category in [folders_with_only_m, folders_with_both] 
                              for item in category if len(item['m_files']) > 1]
    folders_with_multiple_pdf = [item for category in [folders_with_only_pdf, folders_with_both] 
                                for item in category if len(item['pdf_files']) > 1]
    
    logger.info(f"Folders with multiple .m files: {len(folders_with_multiple_m)}")
    logger.info(f"Folders with multiple PDF files: {len(folders_with_multiple_pdf)}")
    
    if folders_with_multiple_m:
        logger.info("\nFolders with multiple .m files:")
        for item in folders_with_multiple_m[:10]:  # Show first 10
            logger.info(f"  {item['name']}: {item['m_files']}")
        if len(folders_with_multiple_m) > 10:
            logger.info(f"  ... and {len(folders_with_multiple_m) - 10} more")
    
    if folders_with_multiple_pdf:
        logger.info("\nFolders with multiple PDF files:")
        for item in folders_with_multiple_pdf[:10]:  # Show first 10
            logger.info(f"  {item['name']}: {item['pdf_files']}")
        if len(folders_with_multiple_pdf) > 10:
            logger.info(f"  ... and {len(folders_with_multiple_pdf) - 10} more")
    
    logger.info("")
    logger.info(f"Detailed analysis saved to: {LOG_FILE}")
    
    return 0

if __name__ == "__main__":
    sys.exit(main()) 