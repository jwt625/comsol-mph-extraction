# COMSOL PDF Documentation Matching

## Overview
This project successfully matched and copied 1636 COMSOL PDF documentation files to their corresponding extracted metadata folders.

## Files Created
1. **`match_pdfs_to_folders.py`** - Main Python script for matching and copying PDFs
2. **`match_pdfs_to_folders.zsh`** - Alternative zsh shell script version
3. **`pdf_matching_log.txt`** - Detailed log of all operations

## How It Works

### Pattern Matching
The scripts extract model identifiers from PDF filenames:
- PDF filename: `models.woptics.orbital_angular_momentum.pdf`
- Extracted model ID: `orbital_angular_momentum`
- Found in file_list.txt: `Wave_Optics_Module/Beam_Propagation/orbital_angular_momentum.mph`
- Target folder: `Wave_Optics_Module_Beam_Propagation_orbital_angular_momentum`

### Process
1. **Scan PDFs**: Read all PDF files from `/Applications/COMSOL62/Multiphysics/doc/help/wtpwebapps/ROOT/doc/pdfs`
2. **Extract Model ID**: Parse the last section of the PDF filename (after the last dot, before .pdf)
3. **Find Path**: Search `file_list.txt` for the model ID using grep
4. **Locate Folder**: Find corresponding folder in `./mphs` directory
5. **Copy PDF**: Copy the PDF file to the matched folder

## Results
- **Total PDF files processed**: 1636
- **Successfully matched**: 1636 (100%)
- **Successfully copied**: 1636 (100%)
- **Failed to match**: 0
- **Failed to copy**: 0
- **Success rate**: 100%

## Usage

### Python Script
```bash
python3 match_pdfs_to_folders.py
```

### Zsh Script
```bash
./match_pdfs_to_folders.zsh
```

## Example Matches
- `models.woptics.orbital_angular_momentum.pdf` → `Wave_Optics_Module_Beam_Propagation_orbital_angular_momentum/`
- `models.heat.cylinder_conduction.pdf` → `Heat_Transfer_Module_Tutorials,_Conduction_cylinder_conduction/`
- `models.sme.vibrating_beam.pdf` → `Structural_Mechanics_Module_Thermal-Structure_Interaction_vibrating_beam/`

## Logging
Comprehensive logging includes:
- Progress indicators (processing X of Y files)
- Model ID extraction
- File path lookups
- Target folder identification
- Copy operation status
- Summary statistics

All operations are logged to `pdf_matching_log.txt` with timestamps and detailed information for troubleshooting and verification. 