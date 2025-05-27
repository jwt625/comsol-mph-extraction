#!/bin/zsh

# Script to copy all .mph files listed in file_list.txt to mphs folder
# Preserves directory structure

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${BLUE}Starting .mph file copy process...${NC}"

# Check if file_list.txt exists
if [[ ! -f "file_list.txt" ]]; then
    echo "${RED}Error: file_list.txt not found in current directory${NC}"
    exit 1
fi

# Create mphs directory if it doesn't exist
if [[ ! -d "mphs" ]]; then
    echo "${YELLOW}Creating mphs directory...${NC}"
    mkdir -p mphs
fi

# Initialize counters
total_files=0
copied_files=0
skipped_files=0
total_size=0

echo "${BLUE}Reading file list and copying files...${NC}"

# Read each line from file_list.txt
while IFS= read -r file_path; do
    # Skip empty lines
    [[ -z "$file_path" ]] && continue
    
    ((total_files++))
    
    # Check if source file exists
    if [[ -f "$file_path" ]]; then
        # Get file size for progress tracking
        file_size=$(stat -f%z "$file_path" 2>/dev/null || echo 0)
        ((total_size += file_size))
        
        # Create destination directory structure
        dest_dir="mphs/$(dirname "$file_path")"
        mkdir -p "$dest_dir"
        
        # Copy the file
        dest_file="mphs/$file_path"
        if cp "$file_path" "$dest_file"; then
            ((copied_files++))
            echo "${GREEN}✓${NC} Copied: $file_path"
        else
            echo "${RED}✗${NC} Failed to copy: $file_path"
        fi
    else
        ((skipped_files++))
        echo "${YELLOW}⚠${NC} File not found: $file_path"
    fi
    
    # Show progress every 100 files
    if (( total_files % 100 == 0 )); then
        echo "${BLUE}Progress: $total_files files processed...${NC}"
    fi
    
done < file_list.txt

# Final summary
echo
echo "${BLUE}=== Copy Summary ===${NC}"
echo "Total files in list: $total_files"
echo "${GREEN}Successfully copied: $copied_files${NC}"
echo "${YELLOW}Skipped (not found): $skipped_files${NC}"
echo "Total size copied: $(( total_size / 1024 / 1024 )) MB ($(( total_size / 1024 / 1024 / 1024 )) GB)"
echo
echo "${GREEN}All .mph files have been copied to the 'mphs' directory!${NC}" 