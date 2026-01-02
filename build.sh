#!/bin/bash

# Build script for "Beyond the Burn"
# Requires: pandoc, xelatex (for PDF)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANUSCRIPT_DIR="$SCRIPT_DIR/manuscript"
COMBINED_DIR="$SCRIPT_DIR/combined"
OUTPUT_DIR="$SCRIPT_DIR/output"
METADATA="$SCRIPT_DIR/metadata.yaml"
COMBINED_FILE="$COMBINED_DIR/complete-manuscript.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to combine all manuscript files
combine_manuscript() {
    echo -e "${YELLOW}Combining manuscript files...${NC}"
    
    # Create combined directory if it doesn't exist
    mkdir -p "$COMBINED_DIR"
    
    # Clear existing combined file
    > "$COMBINED_FILE"
    
    # Concatenate all markdown files in order
    for part_dir in "$MANUSCRIPT_DIR"/*/; do
        for chapter_file in "$part_dir"*.md; do
            if [[ -f "$chapter_file" ]]; then
                cat "$chapter_file" >> "$COMBINED_FILE"
                echo -e "\n\n" >> "$COMBINED_FILE"
            fi
        done
    done
    
    echo -e "${GREEN}Combined manuscript created: $COMBINED_FILE${NC}"
}

# Function to build PDF
build_pdf() {
    echo -e "${YELLOW}Building PDF...${NC}"
    pandoc "$COMBINED_FILE" \
        --metadata-file="$METADATA" \
        --pdf-engine=xelatex \
        --toc \
        --top-level-division=chapter \
        -o "$OUTPUT_DIR/beyond-the-burn.pdf"
    echo -e "${GREEN}PDF created: $OUTPUT_DIR/beyond-the-burn.pdf${NC}"
}

# Function to build EPUB
build_epub() {
    echo -e "${YELLOW}Building EPUB...${NC}"
    pandoc "$COMBINED_FILE" \
        --metadata-file="$METADATA" \
        --toc \
        --epub-chapter-level=1 \
        -o "$OUTPUT_DIR/beyond-the-burn.epub"
    echo -e "${GREEN}EPUB created: $OUTPUT_DIR/beyond-the-burn.epub${NC}"
}

# Function to build DOCX
build_docx() {
    echo -e "${YELLOW}Building DOCX...${NC}"
    pandoc "$COMBINED_FILE" \
        --metadata-file="$METADATA" \
        --toc \
        -o "$OUTPUT_DIR/beyond-the-burn.docx"
    echo -e "${GREEN}DOCX created: $OUTPUT_DIR/beyond-the-burn.docx${NC}"
}

# Function to build HTML
build_html() {
    echo -e "${YELLOW}Building HTML...${NC}"
    pandoc "$COMBINED_FILE" \
        --metadata-file="$METADATA" \
        --toc \
        --standalone \
        --self-contained \
        -o "$OUTPUT_DIR/beyond-the-burn.html"
    echo -e "${GREEN}HTML created: $OUTPUT_DIR/beyond-the-burn.html${NC}"
}

# Function to build all formats
build_all() {
    combine_manuscript
    build_pdf
    build_epub
    build_docx
    build_html
}

# Main script
case "${1:-all}" in
    combine)
        combine_manuscript
        ;;
    pdf)
        combine_manuscript
        build_pdf
        ;;
    epub)
        combine_manuscript
        build_epub
        ;;
    docx)
        combine_manuscript
        build_docx
        ;;
    html)
        combine_manuscript
        build_html
        ;;
    all)
        build_all
        ;;
    *)
        echo "Usage: $0 {combine|pdf|epub|docx|html|all}"
        echo ""
        echo "Commands:"
        echo "  combine  - Combine manuscript files into single markdown"
        echo "  pdf      - Generate PDF (requires xelatex)"
        echo "  epub     - Generate EPUB"
        echo "  docx     - Generate Word document"
        echo "  html     - Generate standalone HTML"
        echo "  all      - Generate all formats (default)"
        exit 1
        ;;
esac

echo -e "${GREEN}Build complete!${NC}"
