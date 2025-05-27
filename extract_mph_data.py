#!/usr/bin/env python3
"""
Script to extract valuable data from COMSOL .mph files
.mph files are ZIP archives containing model data
"""

import os
import zipfile
import json
import shutil
from pathlib import Path
from typing import List, Dict, Optional
import logging
from tqdm import tqdm

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('mph_extraction.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class MPHExtractor:
    def __init__(self, file_list_path: str = "file_list.txt", output_dir: str = "mphs"):
        self.file_list_path = file_list_path
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Files to extract from each .mph file
        self.target_files = [
            "modelimage.png",
            "modelimage_large.png", 
            "smodel.json",
            "modelinfo.xml",
            "usedlicenses.txt",
            "index.txt"
        ]
        
        # Statistics tracking
        self.stats = {
            "total_files": 0,
            "processed_files": 0,
            "failed_files": 0,
            "extracted_files": 0,
            "total_size": 0
        }
        
        # Keep track of extracted data for summary
        self.extraction_log = []

    def sanitize_path(self, path: str) -> str:
        """Convert file path to safe directory name"""
        return path.replace('/', '_').replace('\\', '_').replace('.mph', '')

    def extract_from_mph(self, mph_file_path: str) -> Dict:
        """Extract target files from a single .mph file"""
        mph_path = Path(mph_file_path)
        
        if not mph_path.exists():
            logger.warning(f"File not found: {mph_file_path}")
            return {"status": "not_found", "extracted": []}
        
        # Create sanitized directory name
        safe_name = self.sanitize_path(mph_file_path)
        extract_dir = self.output_dir / safe_name
        extract_dir.mkdir(parents=True, exist_ok=True)
        
        extracted_files = []
        
        try:
            # Treat .mph file as ZIP archive
            with zipfile.ZipFile(mph_path, 'r') as zip_ref:
                # Get list of files in the archive
                zip_files = zip_ref.namelist()
                
                # Extract target files
                for target_file in self.target_files:
                    if target_file in zip_files:
                        try:
                            # Extract to the specific directory
                            zip_ref.extract(target_file, extract_dir)
                            extracted_files.append(target_file)
                            logger.debug(f"Extracted {target_file} from {mph_file_path}")
                        except Exception as e:
                            logger.error(f"Failed to extract {target_file} from {mph_file_path}: {e}")
                
                # Create metadata file with source information
                metadata = {
                    "source_file": mph_file_path,
                    "source_size": mph_path.stat().st_size,
                    "extracted_files": extracted_files,
                    "extraction_timestamp": str(Path(mph_path).stat().st_mtime),
                    "total_files_in_archive": len(zip_files)
                }
                
                metadata_file = extract_dir / "extraction_metadata.json"
                with open(metadata_file, 'w') as f:
                    json.dump(metadata, f, indent=2)
                
                extracted_files.append("extraction_metadata.json")
                
        except zipfile.BadZipFile:
            logger.error(f"Not a valid ZIP file: {mph_file_path}")
            return {"status": "bad_zip", "extracted": []}
        except Exception as e:
            logger.error(f"Error processing {mph_file_path}: {e}")
            return {"status": "error", "extracted": [], "error": str(e)}
        
        return {
            "status": "success", 
            "extracted": extracted_files,
            "extract_dir": str(extract_dir),
            "metadata": metadata
        }

    def process_all_files(self):
        """Process all .mph files from the file list"""
        logger.info("Starting .mph file extraction process...")
        
        if not Path(self.file_list_path).exists():
            logger.error(f"File list not found: {self.file_list_path}")
            return
        
        # Read file list
        with open(self.file_list_path, 'r') as f:
            mph_files = [line.strip() for line in f if line.strip()]
        
        self.stats["total_files"] = len(mph_files)
        logger.info(f"Found {len(mph_files)} .mph files to process")
        
        # Create progress bar
        with tqdm(
            total=len(mph_files),
            desc="Extracting .mph files",
            unit="file",
            bar_format="{l_bar}{bar}| {n_fmt}/{total_fmt} [{elapsed}<{remaining}, {rate_fmt}]"
        ) as pbar:
            
            # Process each file
            for i, mph_file in enumerate(mph_files, 1):
                # Update progress bar description with current file
                pbar.set_description(f"Processing: {mph_file.split('/')[-1][:30]}...")
                
                result = self.extract_from_mph(mph_file)
                
                # Update statistics
                if result["status"] == "success":
                    self.stats["processed_files"] += 1
                    self.stats["extracted_files"] += len(result["extracted"])
                    if "metadata" in result:
                        self.stats["total_size"] += result["metadata"]["source_size"]
                else:
                    self.stats["failed_files"] += 1
                
                # Store extraction log
                self.extraction_log.append({
                    "file": mph_file,
                    "result": result
                })
                
                # Update progress bar
                pbar.update(1)
                
                # Update postfix with current stats
                pbar.set_postfix({
                    'Success': self.stats["processed_files"],
                    'Failed': self.stats["failed_files"],
                    'Size(MB)': f"{self.stats['total_size']/(1024*1024):.1f}"
                })

    def generate_summary(self):
        """Generate summary report of extraction process"""
        summary_file = self.output_dir / "extraction_summary.json"
        
        summary = {
            "statistics": self.stats,
            "target_files": self.target_files,
            "output_directory": str(self.output_dir),
            "extraction_log": self.extraction_log
        }
        
        with open(summary_file, 'w') as f:
            json.dump(summary, f, indent=2)
        
        # Also create a human-readable summary
        readable_summary = self.output_dir / "extraction_summary.txt"
        with open(readable_summary, 'w') as f:
            f.write("=== COMSOL .mph File Extraction Summary ===\n\n")
            f.write(f"Total files in list: {self.stats['total_files']}\n")
            f.write(f"Successfully processed: {self.stats['processed_files']}\n")
            f.write(f"Failed to process: {self.stats['failed_files']}\n")
            f.write(f"Total files extracted: {self.stats['extracted_files']}\n")
            f.write(f"Total source size: {self.stats['total_size'] / (1024*1024*1024):.2f} GB\n\n")
            
            f.write("Target files extracted:\n")
            for target in self.target_files:
                f.write(f"  - {target}\n")
            
            f.write(f"\nExtracted data stored in: {self.output_dir}\n")
            
            # List failed files if any
            failed_files = [item for item in self.extraction_log if item["result"]["status"] != "success"]
            if failed_files:
                f.write(f"\nFailed files ({len(failed_files)}):\n")
                for item in failed_files[:10]:  # Show first 10 failed files
                    f.write(f"  - {item['file']}: {item['result']['status']}\n")
                if len(failed_files) > 10:
                    f.write(f"  ... and {len(failed_files) - 10} more (see extraction_summary.json for full list)\n")

    def run(self):
        """Main execution method"""
        print("=== COMSOL .mph Data Extractor ===")
        print(f"Output directory: {self.output_dir}")
        print(f"Log file: mph_extraction.log")
        print()
        
        try:
            self.process_all_files()
            self.generate_summary()
            
            print(f"\n=== Extraction Complete ===")
            print(f"Processed: {self.stats['processed_files']}/{self.stats['total_files']} files")
            print(f"Failed: {self.stats['failed_files']} files")
            print(f"Total extracted files: {self.stats['extracted_files']}")
            print(f"Total size processed: {self.stats['total_size'] / (1024*1024*1024):.2f} GB")
            print(f"Output directory: {self.output_dir}")
            print("Check extraction_summary.txt for detailed results")
            
        except Exception as e:
            logger.error(f"Fatal error during extraction: {e}")
            raise

if __name__ == "__main__":
    extractor = MPHExtractor()
    extractor.run() 