#!/bin/bash

# MkDocs build script for "Beyond the Burn"
# 
# This script manages its own Python virtual environment and handles
# all MkDocs operations. System requirements: python3, venv, pip
#
# Usage:
#   ./mkdocs-build.sh setup     - Create venv and install dependencies
#   ./mkdocs-build.sh prepare   - Sync manuscript to docs/
#   ./mkdocs-build.sh serve     - Start local dev server
#   ./mkdocs-build.sh build     - Build static site
#   ./mkdocs-build.sh clean     - Remove generated files

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANUSCRIPT_DIR="$SCRIPT_DIR/manuscript"
DOCS_DIR="$SCRIPT_DIR/docs"
VENV_DIR="$SCRIPT_DIR/.venv"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

print_header() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║       Beyond the Burn — MkDocs Build System                ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

#=============================================================================
# Folder and File Mapping
#=============================================================================

# Map manuscript folders to semantic docs folders
declare -A FOLDER_MAP=(
    ["00-frontmatter"]="frontmatter"
    ["01-part-one"]="foundations"
    ["02-part-two"]="history"
    ["03-part-three"]="enemies"
    ["04-part-four"]="chemistry"
    ["05-part-five"]="delivery"
    ["06-part-six"]="botanicals"
    ["07-part-seven"]="innovations"
    ["08-part-eight"]="bigger-picture"
    ["09-part-nine"]="living-it"
    ["10-appendices"]="reference"
)

# Map original filenames to SEO-friendly names
# Format: "src_folder/src_file" -> "new_filename"
declare -A FILE_MAP=(
    # Frontmatter
    ["00-frontmatter/00-foreword.md"]="foreword.md"
    ["00-frontmatter/01-preface.md"]="preface.md"
    ["00-frontmatter/02-introduction.md"]="introduction.md"
    
    # Part I: Foundations
    ["01-part-one/00-part-intro.md"]="index.md"
    ["01-part-one/01-crystal-under-siege.md"]="enamel-crystal-chemistry.md"
    ["01-part-one/02-saliva.md"]="saliva-unsung-hero.md"
    ["01-part-one/03-ecosystem.md"]="oral-microbiome-ecosystem.md"
    ["01-part-one/04-tongue.md"]="tongue-forgotten-reservoir.md"
    
    # Part II: History
    ["02-part-two/00-part-intro.md"]="index.md"
    ["02-part-two/01-history.md"]="chew-sticks-to-chlorhexidine.md"
    ["02-part-two/02-scorched-earth.md"]="problem-with-scorched-earth.md"
    ["02-part-two/03-paradigm-shift.md"]="paradigm-shift-ecological.md"
    
    # Part III: Enemies
    ["03-part-three/00-part-intro.md"]="index.md"
    ["03-part-three/01-acid-equation.md"]="acid-equation-demineralization.md"
    ["03-part-three/02-sugar.md"]="sugar-frequency-over-quantity.md"
    ["03-part-three/03-biofilm.md"]="biofilm-fortress.md"
    
    # Part IV: Chemistry
    ["04-part-four/00-part-intro.md"]="index.md"
    ["04-part-four/01-simple-rinse.md"]="salt-baking-soda-rinse.md"
    ["04-part-four/02-essential-oils.md"]="essential-oils-evidence.md"
    ["04-part-four/03-formulating.md"]="formulating-your-own.md"
    
    # Part V: Delivery
    ["05-part-five/00-part-intro.md"]="index.md"
    ["05-part-five/01-mechanical-disruption.md"]="mechanical-disruption-biofilm.md"
    ["05-part-five/02-water-flossers.md"]="water-flossers-subgingival.md"
    ["05-part-five/03-combination-approach.md"]="combination-approach.md"
    
    # Part VI: Botanicals
    ["06-part-six/00-part-intro.md"]="index.md"
    ["06-part-six/01-miswak.md"]="miswak-salvadora-persica.md"
    ["06-part-six/02-warming-roots.md"]="ginger-warming-roots.md"
    ["06-part-six/03-healing-herbs.md"]="sage-thyme-chamomile.md"
    ["06-part-six/04-sweet-exceptions.md"]="licorice-manuka-honey.md"
    ["06-part-six/05-resins-extracts.md"]="propolis-myrrh-resins.md"
    ["06-part-six/06-green-pharmacy.md"]="green-tea-cranberry-neem.md"
    ["06-part-six/07-oil-pulling.md"]="oil-pulling-coconut-sesame.md"
    ["06-part-six/08-modern-trends.md"]="charcoal-modern-trends.md"
    
    # Part VII: Innovations
    ["07-part-seven/00-part-intro.md"]="index.md"
    ["07-part-seven/01-fluoride-question.md"]="fluoride-question.md"
    ["07-part-seven/02-nano-hydroxyapatite.md"]="nano-hydroxyapatite.md"
    ["07-part-seven/03-emerging-tech.md"]="emerging-probiotics-arginine.md"
    
    # Part VIII: Bigger Picture
    ["08-part-eight/00-part-intro.md"]="index.md"
    ["08-part-eight/01-oral-systemic.md"]="oral-systemic-connection.md"
    ["08-part-eight/02-breath-social.md"]="breath-halitosis-social.md"
    
    # Part IX: Living It
    ["09-part-nine/00-part-intro.md"]="index.md"
    ["09-part-nine/01-day-optimized.md"]="day-in-optimized-mouth.md"
    ["09-part-nine/02-personal-protocol.md"]="building-personal-protocol.md"
    ["09-part-nine/03-children.md"]="children-resilient-teeth.md"
    ["09-part-nine/04-when-professional.md"]="when-to-see-professional.md"
    
    # Reference (Appendices)
    ["10-appendices/01-appendix-a-formulations.md"]="formulations-quick-reference.md"
    ["10-appendices/02-appendix-b-glossary.md"]="glossary-ingredients.md"
    ["10-appendices/03-appendix-c-evidence.md"]="evidence-hierarchy.md"
    ["10-appendices/04-appendix-d-resources.md"]="resources-further-reading.md"
)

#=============================================================================
# Virtual Environment Management
#=============================================================================

in_venv() {
    [ -n "$VIRTUAL_ENV" ] && [ "$VIRTUAL_ENV" = "$VENV_DIR" ]
}

venv_exists() {
    [ -d "$VENV_DIR" ] && [ -f "$VENV_DIR/bin/activate" ]
}

create_venv() {
    echo -e "${YELLOW}Creating virtual environment...${NC}"
    
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}Error: python3 not found${NC}"
        exit 1
    fi
    
    if ! python3 -c "import venv" &> /dev/null; then
        echo -e "${RED}Error: venv module not available${NC}"
        echo "Install with: sudo apt install python3-venv"
        exit 1
    fi
    
    python3 -m venv "$VENV_DIR"
    echo -e "${GREEN}✓ Virtual environment created at .venv/${NC}"
}

activate_venv() {
    if [ -f "$VENV_DIR/bin/activate" ]; then
        source "$VENV_DIR/bin/activate"
    else
        echo -e "${RED}Error: Virtual environment not found${NC}"
        echo "Run: ./mkdocs-build.sh setup"
        exit 1
    fi
}

install_dependencies() {
    echo -e "${YELLOW}Installing dependencies...${NC}"
    pip install --upgrade pip --quiet
    pip install mkdocs-material mkdocs-minify-plugin --quiet
    echo -e "${GREEN}✓ Dependencies installed${NC}"
}

setup_environment() {
    print_header
    
    if venv_exists; then
        echo -e "${YELLOW}Virtual environment already exists at .venv/${NC}"
        read -p "Recreate it? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$VENV_DIR"
            create_venv
        fi
    else
        create_venv
    fi
    
    activate_venv
    install_dependencies
    
    echo ""
    echo -e "${GREEN}${BOLD}Setup complete!${NC}"
    echo ""
    echo "To start the dev server:"
    echo -e "  ${CYAN}./mkdocs-build.sh serve${NC}"
}

ensure_venv() {
    if ! venv_exists; then
        echo -e "${YELLOW}Virtual environment not found. Setting up...${NC}"
        echo ""
        create_venv
        activate_venv
        install_dependencies
        echo ""
    elif ! in_venv; then
        activate_venv
    fi
}

check_mkdocs() {
    if ! command -v mkdocs &> /dev/null; then
        echo -e "${RED}MkDocs not found in environment${NC}"
        pip install mkdocs-material mkdocs-minify-plugin --quiet
    fi
}

#=============================================================================
# Documentation Preparation
#=============================================================================

prepare_docs() {
    echo -e "${YELLOW}Preparing docs/ directory from manuscript...${NC}"
    
    # Create directory structure
    mkdir -p "$DOCS_DIR"/{frontmatter,foundations,history,enemies,chemistry,delivery,botanicals,innovations,bigger-picture,living-it,reference}
    mkdir -p "$DOCS_DIR"/{stylesheets,javascripts,overrides/partials}
    
    # Copy files using the mapping
    for src_key in "${!FILE_MAP[@]}"; do
        local src_folder=$(dirname "$src_key")
        local dest_folder="${FOLDER_MAP[$src_folder]}"
        local dest_file="${FILE_MAP[$src_key]}"
        local src_path="$MANUSCRIPT_DIR/$src_key"
        local dest_path="$DOCS_DIR/$dest_folder/$dest_file"
        
        if [ -f "$src_path" ]; then
            cp "$src_path" "$dest_path"
        fi
    done
    
    echo -e "  ${GREEN}✓${NC} Manuscript files copied"
    
    # Create generated content
    create_index_page
    create_reference_index
    create_custom_css
    create_mathjax_config
    create_theme_overrides
    
    local file_count=$(find "$DOCS_DIR" -name "*.md" | wc -l)
    echo ""
    echo -e "${GREEN}✓ Docs prepared: $file_count markdown files${NC}"
}

#=============================================================================
# Generated Content
#=============================================================================

create_index_page() {
    cat > "$DOCS_DIR/index.md" << 'HEREDOC'
# Beyond the Burn

## An Ecological Approach to Oral Health

<div class="hero-section" markdown>

!!! quote "A confession from your midnight visitor"

    I need to tell you something, and I need you to actually listen this time.
    
    **I don't want your teeth.**
    
    I know, I know—that's a strange thing for the Tooth Fairy to say. You've been leaving them under pillows for me since before your great-grandparents were born. I've got teeth. I've got so many teeth. What I don't have is job satisfaction.
    
    Every tooth I take is a small tragedy.

</div>

---

## What This Book Is About

Your mouth isn't a war zone. It's an **ecosystem**. A garden. A coral reef, if you want to get poetic about it. 

There are over seven hundred species of bacteria in there, and most of them are trying to help you. When you napalm the whole system with antiseptic mouthwash, you don't create health. You create chaos.

This book is about understanding what's actually happening in your mouth—and working *with* it rather than against it.

---

## The Journey

<div class="grid cards" markdown>

-   :material-tooth:{ .lg .middle } __Part I: Foundations__

    ---

    Enamel chemistry, the remineralization cycle, saliva's superpowers, and the ecosystem living in your mouth.

    [:octicons-arrow-right-24: The Science](foundations/index.md)

-   :material-history:{ .lg .middle } __Part II: How We Got Here__

    ---

    From chew sticks to chlorhexidine—and why the "kill everything" approach may have been a mistake.

    [:octicons-arrow-right-24: The History](history/index.md)

-   :material-bacteria:{ .lg .middle } __Part III: The Enemies__

    ---

    Acid, sugar, and biofilm—understanding what actually causes decay and gum disease.

    [:octicons-arrow-right-24: Know Your Enemy](enemies/index.md)

-   :material-flask:{ .lg .middle } __Part IV: Chemistry of Care__

    ---

    Salt, baking soda, essential oils—build your own rinses and understand what each ingredient actually does.

    [:octicons-arrow-right-24: The Chemistry](chemistry/index.md)

-   :material-toothbrush:{ .lg .middle } __Part V: Delivery__

    ---

    Mechanical disruption, water flossers, and getting beneficial compounds where they need to go.

    [:octicons-arrow-right-24: Application Methods](delivery/index.md)

-   :material-leaf:{ .lg .middle } __Part VI: Botanicals__

    ---

    Miswak, sage, propolis, green tea—traditional remedies with modern evidence.

    [:octicons-arrow-right-24: Plant Allies](botanicals/index.md)

-   :material-atom:{ .lg .middle } __Part VII: Modern Innovations__

    ---

    Fluoride, nano-hydroxyapatite, probiotics—cutting-edge approaches to remineralization.

    [:octicons-arrow-right-24: New Frontiers](innovations/index.md)

-   :material-heart-pulse:{ .lg .middle } __Part VIII: The Bigger Picture__

    ---

    The oral-systemic connection, halitosis, and why your mouth affects your whole body.

    [:octicons-arrow-right-24: Beyond the Mouth](bigger-picture/index.md)

-   :material-calendar-check:{ .lg .middle } __Part IX: Living It__

    ---

    Daily protocols, building your personal routine, children's teeth, and when to see a professional.

    [:octicons-arrow-right-24: Practical Application](living-it/index.md)

-   :material-bookshelf:{ .lg .middle } __Reference__

    ---

    Formulations, ingredient glossary, evidence hierarchy, and resources for further reading.

    [:octicons-arrow-right-24: Quick Reference](reference/index.md)

</div>

---

## Start Reading

<div class="grid" markdown>

[:material-book-open-variant: **Read the Foreword** — Why this book exists](frontmatter/foreword.md){ .md-button .md-button--primary }

[:material-book-open-page-variant: **Read the Preface** — The Tooth Fairy's confession](frontmatter/preface.md){ .md-button }

[:material-format-list-numbered: **Jump to Formulations** — Practical recipes](reference/formulations-quick-reference.md){ .md-button }

</div>

---

<div class="closing-note" markdown>

*"Read carefully. Apply wisely. And for the love of everything—stop burning your mouth with products that destroy the very ecosystem trying to protect you."*

*— The Tooth Fairy, who has been doing this for far too long, and would like very much to stop*

</div>
HEREDOC
    echo -e "  ${GREEN}✓${NC} Homepage created"
}

create_reference_index() {
    cat > "$DOCS_DIR/reference/index.md" << 'HEREDOC'
# Reference

Quick reference materials and resources to support your oral health journey.

<div class="grid cards" markdown>

-   :material-flask-outline:{ .lg .middle } __Formulations__

    ---

    Ready-to-use recipes for rinses, protocols, and preparations.

    [:octicons-arrow-right-24: Quick Reference Formulations](formulations-quick-reference.md)

-   :material-book-alphabet:{ .lg .middle } __Glossary__

    ---

    Comprehensive glossary of ingredients, compounds, and botanicals.

    [:octicons-arrow-right-24: Ingredient Glossary](glossary-ingredients.md)

-   :material-scale-balance:{ .lg .middle } __Evidence__

    ---

    How to evaluate claims and understand the hierarchy of evidence.

    [:octicons-arrow-right-24: Understanding the Evidence](evidence-hierarchy.md)

-   :material-bookshelf:{ .lg .middle } __Resources__

    ---

    Scientific papers, books, suppliers, and further reading.

    [:octicons-arrow-right-24: Resources & Further Reading](resources-further-reading.md)

</div>
HEREDOC
    echo -e "  ${GREEN}✓${NC} Reference index created"
}

create_custom_css() {
    cat > "$DOCS_DIR/stylesheets/extra.css" << 'HEREDOC'
:root {
  --md-primary-fg-color: #009688;
  --md-primary-fg-color--light: #4DB6AC;
  --md-primary-fg-color--dark: #00796B;
  --md-accent-fg-color: #FFC107;
}

.hero-section {
  background: linear-gradient(135deg, #e0f2f1 0%, #b2dfdb 100%);
  padding: 2rem;
  border-radius: 12px;
  margin: 2rem 0;
}

[data-md-color-scheme="slate"] .hero-section {
  background: linear-gradient(135deg, #1a3a38 0%, #0d2624 100%);
}

.closing-note {
  font-style: italic;
  text-align: center;
  padding: 2rem;
  margin-top: 3rem;
  border-top: 1px solid var(--md-default-fg-color--lightest);
}

blockquote {
  border-left: 4px solid var(--md-primary-fg-color);
  background-color: var(--md-code-bg-color);
  padding: 1rem 1.5rem;
  margin: 1.5rem 0;
  font-style: italic;
}

th {
  background-color: var(--md-primary-fg-color);
  color: white;
  font-weight: 600;
}

[data-md-color-scheme="slate"] th {
  background-color: var(--md-primary-fg-color--dark);
}

.md-typeset .grid.cards > ul > li {
  border: 1px solid var(--md-default-fg-color--lightest);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.md-typeset .grid.cards > ul > li:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.md-typeset strong {
  color: var(--md-primary-fg-color--dark);
}

[data-md-color-scheme="slate"] .md-typeset strong {
  color: var(--md-primary-fg-color--light);
}

html {
  scroll-behavior: smooth;
}
HEREDOC
    echo -e "  ${GREEN}✓${NC} Custom CSS created"
}

create_mathjax_config() {
    cat > "$DOCS_DIR/javascripts/mathjax.js" << 'HEREDOC'
window.MathJax = {
  tex: {
    inlineMath: [["\\(", "\\)"]],
    displayMath: [["\\[", "\\]"]],
    processEscapes: true,
    processEnvironments: true
  },
  options: {
    ignoreHtmlClass: ".*|",
    processHtmlClass: "arithmatex"
  }
};

document$.subscribe(() => {
  MathJax.typesetPromise()
})
HEREDOC
    echo -e "  ${GREEN}✓${NC} MathJax config created"
}

create_theme_overrides() {
    mkdir -p "$DOCS_DIR/overrides/partials"
    cat > "$DOCS_DIR/overrides/partials/copyright.html" << 'HEREDOC'
<div class="md-copyright">
  {% if config.copyright %}
    <div class="md-copyright__highlight">
      {{ config.copyright }}
    </div>
  {% endif %}
</div>
HEREDOC
    echo -e "  ${GREEN}✓${NC} Theme overrides created"
}

#=============================================================================
# Build Commands
#=============================================================================

build_site() {
    echo -e "${YELLOW}Building MkDocs site...${NC}"
    cd "$SCRIPT_DIR"
    mkdocs build --strict
    echo -e "${GREEN}✓ Site built: $SCRIPT_DIR/site/${NC}"
}

serve_site() {
    echo -e "${YELLOW}Starting development server...${NC}"
    echo ""
    echo -e "${BOLD}Site will be available at:${NC}"
    echo -e "  ${CYAN}http://127.0.0.1:8000${NC}"
    echo ""
    echo -e "${YELLOW}Press Ctrl+C to stop${NC}"
    echo ""
    cd "$SCRIPT_DIR"
    mkdocs serve
}

clean_all() {
    echo -e "${YELLOW}Cleaning build artifacts...${NC}"
    rm -rf "$SCRIPT_DIR/site"
    rm -rf "$DOCS_DIR"
    echo -e "${GREEN}✓ Cleaned docs/ and site/${NC}"
}

clean_venv() {
    echo -e "${YELLOW}Removing virtual environment...${NC}"
    rm -rf "$VENV_DIR"
    echo -e "${GREEN}✓ Removed .venv/${NC}"
}

open_shell() {
    ensure_venv
    echo -e "${GREEN}Entering virtual environment...${NC}"
    echo -e "Type ${CYAN}exit${NC} to leave"
    echo ""
    exec "$SHELL"
}

#=============================================================================
# Main
#=============================================================================

show_help() {
    echo "Usage: $0 <command>"
    echo ""
    echo "Environment:"
    echo "  setup       Create virtual environment and install dependencies"
    echo "  shell       Open a shell with the virtual environment activated"
    echo ""
    echo "Build:"
    echo "  prepare     Sync manuscript files to docs/ directory"
    echo "  serve       Start local development server (http://127.0.0.1:8000)"
    echo "  build       Build static site to site/ directory"
    echo ""
    echo "Cleanup:"
    echo "  clean       Remove docs/ and site/ directories"
    echo "  clean-all   Remove docs/, site/, and .venv/"
    echo ""
    echo "Quick start:"
    echo "  $0 setup    # First time only"
    echo "  $0 serve    # Start previewing"
}

main() {
    case "${1:-help}" in
        setup)
            setup_environment
            ;;
        prepare)
            print_header
            ensure_venv
            prepare_docs
            echo ""
            echo -e "${GREEN}Run './mkdocs-build.sh serve' to preview${NC}"
            ;;
        build)
            print_header
            ensure_venv
            check_mkdocs
            [ ! -d "$DOCS_DIR" ] && prepare_docs
            build_site
            ;;
        serve)
            print_header
            ensure_venv
            check_mkdocs
            [ ! -d "$DOCS_DIR" ] && prepare_docs
            serve_site
            ;;
        clean)
            print_header
            clean_all
            ;;
        clean-all)
            print_header
            clean_all
            clean_venv
            ;;
        shell)
            print_header
            ensure_venv
            open_shell
            ;;
        help|--help|-h)
            print_header
            show_help
            ;;
        *)
            print_header
            echo -e "${RED}Unknown command: $1${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main "$@"
