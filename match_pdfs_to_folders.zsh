#!/bin/zsh

# COMSOL PDF to Folder Matcher - ZSH Version
# Matches PDF files to their corresponding extracted metadata folders

# Configuration
PDF_SOURCE_DIR="/Applications/COMSOL62/Multiphysics/doc/help/wtpwebapps/ROOT/doc/pdfs"
MPHS_DIR="./mphs"
FILE_LIST_PATH="./file_list.txt"
LOG_FILE="pdf_matching_log_zsh.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Initialize log file
echo "=== COMSOL PDF to Folder Matcher - ZSH Version ===" > "$LOG_FILE"
echo "Started: $(date)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Function to log both to console and file
log() {
    echo "$1"
    echo "$1" >> "$LOG_FILE"
}

log_color() {
    echo -e "$1"
    echo "$2" >> "$LOG_FILE"
}

# Function to extract model ID from PDF filename
extract_model_id() {
    local pdf_filename="$1"
    
    # Check if it starts with 'models.' and ends with '.pdf'
    if [[ ! "$pdf_filename" =~ ^models\..+\.pdf$ ]]; then
        return 1
    fi
    
    # Remove 'models.' prefix and '.pdf' suffix
    local name_part="${pdf_filename#models.}"
    name_part="${name_part%.pdf}"
    
    # Split by dots and take the last part
    local model_id="${name_part##*.}"
    
    echo "$model_id"
    return 0
}

# Function to convert file path to folder name
convert_path_to_folder_name() {
    local file_path="$1"
    
    # Remove .mph extension
    local path_without_ext="${file_path%.mph}"
    
    # Replace slashes with underscores
    local folder_name="${path_without_ext//\//_}"
    
    echo "$folder_name"
}

# Check if required directories and files exist
log_color "${BLUE}=== COMSOL PDF to Folder Matcher ===${NC}" "=== COMSOL PDF to Folder Matcher ==="
log "PDF source directory: $PDF_SOURCE_DIR"
log "MPHS directory: $MPHS_DIR"
log "File list: $FILE_LIST_PATH"
log ""

if [[ ! -d "$PDF_SOURCE_DIR" ]]; then
    log_color "${RED}Error: PDF source directory not found: $PDF_SOURCE_DIR${NC}" "Error: PDF source directory not found: $PDF_SOURCE_DIR"
    exit 1
fi

if [[ ! -d "$MPHS_DIR" ]]; then
    log_color "${RED}Error: MPHS directory not found: $MPHS_DIR${NC}" "Error: MPHS directory not found: $MPHS_DIR"
    exit 1
fi

if [[ ! -f "$FILE_LIST_PATH" ]]; then
    log_color "${RED}Error: File list not found: $FILE_LIST_PATH${NC}" "Error: File list not found: $FILE_LIST_PATH"
    exit 1
fi

# Initialize statistics
total_pdfs=0
matched=0
copied=0
failed_match=0
failed_copy=0

# Arrays to store results
declare -a unmatched_pdfs
declare -a matched_but_failed_copy

log "Loading file list and finding PDF files..."

# Count PDF files
total_pdfs=$(ls "$PDF_SOURCE_DIR"/models.*.pdf 2>/dev/null | wc -l)
log "Found $total_pdfs PDF files to process"

if [[ $total_pdfs -eq 0 ]]; then
    log_color "${YELLOW}No PDF files found matching pattern 'models.*.pdf'${NC}" "No PDF files found matching pattern 'models.*.pdf'"
    exit 0
fi

log ""
log "Processing PDF files..."
log "$(printf '%.0s-' {1..80})"

# Process each PDF file
current=0
for pdf_file in "$PDF_SOURCE_DIR"/models.*.pdf; do
    ((current++))
    pdf_filename=$(basename "$pdf_file")
    
    log_color "${BLUE}[$current/$total_pdfs] Processing: $pdf_filename${NC}" "[$current/$total_pdfs] Processing: $pdf_filename"
    
    # Extract model ID
    model_id=$(extract_model_id "$pdf_filename")
    if [[ $? -ne 0 || -z "$model_id" ]]; then
        log_color "${YELLOW}    Could not extract model ID from $pdf_filename${NC}" "    Could not extract model ID from $pdf_filename"
        ((failed_match++))
        unmatched_pdfs+=("$pdf_filename")
        continue
    fi
    
    # Search for model ID in file list
    file_path=$(grep "/$model_id\.mph$" "$FILE_LIST_PATH" | head -1)
    
    if [[ -z "$file_path" ]]; then
        log_color "${YELLOW}    No match found for model ID: $model_id${NC}" "    No match found for model ID: $model_id"
        ((failed_match++))
        unmatched_pdfs+=("$pdf_filename")
        continue
    fi
    
    # Convert to folder name
    folder_name=$(convert_path_to_folder_name "$file_path")
    target_folder="$MPHS_DIR/$folder_name"
    
    log "    Model ID: $model_id"
    log "    File path: $file_path"
    log "    Target folder: $folder_name"
    
    ((matched++))
    
    # Check if target folder exists
    if [[ ! -d "$target_folder" ]]; then
        log_color "${YELLOW}    Target folder does not exist: $target_folder${NC}" "    Target folder does not exist: $target_folder"
        ((failed_copy++))
        matched_but_failed_copy+=("$pdf_filename -> $target_folder")
        continue
    fi
    
    # Copy PDF file
    target_path="$target_folder/$pdf_filename"
    
    if cp "$pdf_file" "$target_path" 2>/dev/null; then
        # Verify copy
        if [[ -f "$target_path" ]]; then
            source_size=$(stat -f%z "$pdf_file" 2>/dev/null || stat -c%s "$pdf_file" 2>/dev/null)
            target_size=$(stat -f%z "$target_path" 2>/dev/null || stat -c%s "$target_path" 2>/dev/null)
            
            if [[ "$source_size" == "$target_size" ]]; then
                log_color "${GREEN}    ✓ Successfully copied $pdf_filename${NC}" "    ✓ Successfully copied $pdf_filename"
                ((copied++))
            else
                log_color "${RED}    ✗ Size mismatch after copying $pdf_filename${NC}" "    ✗ Size mismatch after copying $pdf_filename"
                ((failed_copy++))
                matched_but_failed_copy+=("$pdf_filename -> $target_folder")
            fi
        else
            log_color "${RED}    ✗ Target file not found after copy: $target_path${NC}" "    ✗ Target file not found after copy: $target_path"
            ((failed_copy++))
            matched_but_failed_copy+=("$pdf_filename -> $target_folder")
        fi
    else
        log_color "${RED}    ✗ Error copying $pdf_filename${NC}" "    ✗ Error copying $pdf_filename"
        ((failed_copy++))
        matched_but_failed_copy+=("$pdf_filename -> $target_folder")
    fi
done

# Calculate success rate
if [[ $total_pdfs -gt 0 ]]; then
    success_rate=$(( copied * 100 / total_pdfs ))
else
    success_rate=0
fi

# Print summary
log ""
log "$(printf '%.0s=' {1..80})"
log "SUMMARY"
log "$(printf '%.0s=' {1..80})"
log "Total PDF files processed: $total_pdfs"
log "Successfully matched: $matched"
log "Successfully copied: $copied"
log "Failed to match: $failed_match"
log "Failed to copy: $failed_copy"
log "Success rate: ${success_rate}%"

# List unmatched PDFs
if [[ ${#unmatched_pdfs[@]} -gt 0 ]]; then
    log ""
    log "Unmatched PDFs (${#unmatched_pdfs[@]}):"
    for i in {1..10}; do
        if [[ $i -le ${#unmatched_pdfs[@]} ]]; then
            log "  - ${unmatched_pdfs[$i]}"
        fi
    done
    if [[ ${#unmatched_pdfs[@]} -gt 10 ]]; then
        log "  ... and $((${#unmatched_pdfs[@]} - 10)) more"
    fi
fi

# List matched but failed to copy
if [[ ${#matched_but_failed_copy[@]} -gt 0 ]]; then
    log ""
    log "Matched but failed to copy (${#matched_but_failed_copy[@]}):"
    for i in {1..10}; do
        if [[ $i -le ${#matched_but_failed_copy[@]} ]]; then
            log "  - ${matched_but_failed_copy[$i]}"
        fi
    done
    if [[ ${#matched_but_failed_copy[@]} -gt 10 ]]; then
        log "  ... and $((${#matched_but_failed_copy[@]} - 10)) more"
    fi
fi

log ""
log "Detailed log saved to: $LOG_FILE"
log "Completed: $(date)"

# Exit with appropriate code
if [[ $failed_match -eq 0 && $failed_copy -eq 0 ]]; then
    log_color "${GREEN}All PDFs processed successfully!${NC}" "All PDFs processed successfully!"
    exit 0
else
    log_color "${YELLOW}Some PDFs could not be processed. Check log for details.${NC}" "Some PDFs could not be processed. Check log for details."
    exit 1
fi 