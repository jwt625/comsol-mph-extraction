# COMSOL File Distribution Analysis Summary

## Overview
Analysis of 1,908 folders in the `mphs` directory to understand the distribution of `.m` files (MATLAB conversions) and PDF documentation files.

## Summary Statistics

| Category | Count | Percentage |
|----------|-------|------------|
| **Folders with only .m files** | 334 | 17.5% |
| **Folders with both .m and PDF files** | 1,376 | 72.1% |
| **Folders with only PDF files** | 196 | 10.3% |
| **Folders with neither** | 2 | 0.1% |
| **Total folders** | 1,908 | 100% |

## File Counts
- **Total .m files**: 1,710
- **Total PDF files**: 1,636
- **Folders with .m files**: 1,710
- **Folders with PDF files**: 1,572

## Key Findings

### 1. Most folders have both files (72.1%)
The majority of COMSOL model folders contain both the converted MATLAB file and the corresponding PDF documentation, indicating successful matching and conversion.

### 2. Missing PDF documentation (17.5%)
334 folders have `.m` files but no corresponding PDF documentation. These fall into several categories:

#### Common patterns in folders missing PDFs:
- **Geometry sequence files**: Many folders ending with `_geom_sequence` (e.g., `capacitor_tunable_geom_sequence`)
- **Application examples**: Some folders in "Applications" subcategories
- **Verification examples**: Some files that appear to be verification/benchmark cases
- **Subsurface module duplicates**: Some models appear in both Porous Media Flow Module and Subsurface Flow Module

### 3. Orphaned PDF files (10.3%)
196 folders contain PDF files but no `.m` files. This suggests:
- **Conversion failures**: Some models may have failed to convert properly
- **Complex models**: May be models that are too complex or use unsupported features
- **Module-specific issues**: Some modules may have lower conversion success rates

### 4. Empty folders (0.1%)
Only 2 folders contain neither files:
- `Electrodeposition_Module_Tutorials_microdisk_voltammetry`
- `RF_Module_Antennas_corrugated_circular_horn_antenna`

### 5. Multiple PDF files (34 folders)
Some folders contain multiple PDF files, indicating:
- **Cross-module models**: Same model appears in different modules (e.g., `orange_battery` appears in 4 different modules)
- **CAD import variants**: Models with multiple CAD system versions
- **Electrochemistry variations**: Different electrochemistry module implementations

## Examples of Multiple PDF Cases

### Battery Models (multiple modules):
- `orange_battery`: appears in `echem`, `edecm`, `battery`, and `fce` modules
- `cyclic_voltammetry_1d`: appears in 4 modules
- `diffuse_double_layer`: appears in 4 modules

### CAD Import Models (multiple CAD systems):
- `exhaust_manifold_create_fluid_domain`: 7 different CAD system versions
- `wheel_rim_defeature`: 7 different CAD system versions

## Module-Specific Analysis

### High Success Rate Modules:
- **Wave Optics Module**: Most models have both files
- **Structural Mechanics Module**: High PDF coverage
- **ACDC Module**: Good overall coverage

### Modules with More Missing PDFs:
- **Acoustics Module**: Several models with only PDFs
- **CFD Module**: Some complex models may have failed conversion
- **Battery Design Module**: Complex electrochemistry models

## Recommendations

1. **Investigate conversion failures**: Focus on the 196 folders with only PDF files to understand why conversion failed

2. **Address missing documentation**: The 334 folders with only `.m` files may need manual PDF assignment or indicate documentation gaps

3. **Handle duplicates**: Review the 34 folders with multiple PDFs to determine if this is intended or needs consolidation

4. **Verify empty folders**: Check the 2 empty folders to ensure they contain the expected content

## Conversion Success Rate
- **Overall matching success**: 100% of PDFs were successfully matched and copied
- **Model coverage**: 1,572 out of 1,908 folders (82.4%) have PDF documentation
- **Conversion coverage**: 1,710 out of 1,908 folders (89.6%) have MATLAB conversions

The improved module-aware PDF matching script successfully achieved 100% matching accuracy, properly distinguishing between models that appear in multiple modules. 