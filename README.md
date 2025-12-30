# Beyond the Burn

## An Ecological Approach to Oral Health

*As narrated by The Tooth Fairy*

---

## About This Project

This book challenges the antiseptic paradigm that has dominated oral health for over a century. It argues for an ecological approach—understanding the mouth as an ecosystem rather than a battlefield, and working with the body's natural processes rather than against them.

Written from the perspective of the Tooth Fairy—an ancient, weary collector who would rather retire than keep gathering teeth that could have been saved—it blends rigorous science with accessible storytelling.

## Book Statistics

- **Word count:** ~70,000 words
- **Chapters:** 33 + 4 appendices
- **Parts:** 9 thematic sections

---

## Contents

### Part I: Foundations — What's Actually Happening in Your Mouth
1. The Crystal Under Siege (enamel chemistry)
2. Saliva: The Unsung Hero
3. The Ecosystem in Your Mouth (the oral microbiome)
4. The Tongue: The Forgotten Reservoir

### Part II: How We Got Here — A Brief History of Getting It Wrong
5. From Chew Sticks to Chlorhexidine
6. The Problem with Scorched Earth
7. The Paradigm Shift

### Part III: The Enemies — Understanding What Actually Causes Damage
8. The Acid Equation
9. Sugar: Frequency Over Quantity
10. The Biofilm Fortress

### Part IV: The Chemistry of Care — Building a Better Rinse
11. A Simple Rinse, Deeply Understood
12. Essential Oils: Evidence vs. Aromatherapy
13. Formulating Your Own

### Part V: Delivery — Getting Solutions Where They Need to Go
14. Mechanical Disruption
15. Water Flossers and Subgingival Reach
16. The Combination Approach

### Part VI: Botanicals and Traditional Wisdom
17. The Miswak Tradition
18. The Warming Roots: Ginger and Its Kin
19. The Healing Herbs: Sage, Thyme, and Chamomile
20. The Sweet Exceptions: Licorice and Manuka Honey
21. Resins and Extracts: Propolis, Myrrh, and Bloodroot
22. The Green Pharmacy: Tea, Cranberry, and Neem
23. Oil Pulling: More Interesting Than Expected
24. Modern Trends: Charcoal, Coconut, and Marketing

### Part VII: Modern Innovations — Remineralization Technologies
25. The Fluoride Question
26. Nano-Hydroxyapatite: The Space-Age Alternative
27. Emerging Technologies

### Part VIII: The Bigger Picture — Why This Matters Beyond Your Mouth
28. The Oral-Systemic Connection
29. Breath and the Social Mouth

### Part IX: Living It — Your Practical Protocol
30. A Day in the Optimized Mouth
31. Building Your Personal Protocol
32. Raising Resilient Teeth (Children's Oral Health)
33. When to See a Professional

### Appendices
- A: Quick Reference Formulations
- B: Ingredient Glossary
- C: The Evidence Hierarchy
- D: Resources and Further Reading

---

## Building the Book

This project supports two build systems:

1. **Pandoc** — Generate PDF, EPUB, DOCX, and standalone HTML
2. **MkDocs** — Generate a beautiful documentation website with Material theme

---

### Option 1: Pandoc (Traditional Book Formats)

#### Prerequisites

- [Pandoc](https://pandoc.org/) (document converter)
- XeLaTeX (for PDF generation) — install via TeX Live or MiKTeX
- Recommended fonts: Linux Libertine, Linux Biolinum, Fira Code

#### Quick Start

```bash
# Make build script executable
chmod +x build.sh

# Generate all formats
./build.sh all

# Generate specific format
./build.sh pdf
./build.sh epub
./build.sh docx
./build.sh html

# Just combine manuscript files into single markdown
./build.sh combine
```

#### Output Files

After building, find your documents in the `output/` directory:
- `beyond-the-burn.pdf` — Print-ready PDF
- `beyond-the-burn.epub` — E-reader format
- `beyond-the-burn.docx` — Microsoft Word format
- `beyond-the-burn.html` — Web-readable single HTML file

---

### Option 2: MkDocs (Documentation Website)

Generate a modern, searchable documentation website using MkDocs with the Material theme.

#### Prerequisites

- Python 3.8+
- venv module (usually included with Python)
- pip

That's it! The build script manages its own virtual environment.

#### Quick Start

```bash
# Make build script executable
chmod +x mkdocs-build.sh

# First time: set up environment (creates .venv/, installs dependencies)
./mkdocs-build.sh setup

# Start local preview server
./mkdocs-build.sh serve

# Open http://127.0.0.1:8000 in your browser
```

The script automatically:
1. Creates a `.venv/` virtual environment if it doesn't exist
2. Installs `mkdocs-material` and plugins into it
3. Activates the environment for each command
4. Syncs manuscript files to `docs/` format

#### MkDocs Commands

| Command | Description |
|---------|-------------|
| `./mkdocs-build.sh setup` | Create venv and install dependencies |
| `./mkdocs-build.sh serve` | Start local dev server (auto-setup if needed) |
| `./mkdocs-build.sh build` | Build static site to `site/` |
| `./mkdocs-build.sh prepare` | Sync manuscript to docs/ without building |
| `./mkdocs-build.sh clean` | Remove docs/ and site/ |
| `./mkdocs-build.sh clean-all` | Remove docs/, site/, and .venv/ |
| `./mkdocs-build.sh shell` | Open shell with venv activated |

#### Manual Environment Activation

If you prefer to work directly with mkdocs commands:

```bash
# Activate the virtual environment
source .venv/bin/activate

# Now you can run mkdocs directly
mkdocs serve
mkdocs build

# When done
deactivate
```

#### Alternative: Using requirements.txt

```bash
# Create your own venv
python3 -m venv .venv
source .venv/bin/activate

# Install from requirements.txt
pip install -r requirements.txt

# Run mkdocs
mkdocs serve
```

#### Features

The MkDocs site includes:
- 🌙 **Dark/Light mode** toggle
- 🔍 **Full-text search** across all chapters
- 📱 **Responsive design** for mobile/tablet
- 📑 **Navigation tabs** for major sections
- 🧮 **MathJax support** for chemical equations
- 🎨 **Custom styling** matching the book's tone

#### Deployment

The `site/` folder contains static HTML and can be deployed to:
- GitHub Pages
- Netlify
- Vercel
- Any static hosting service

```bash
# Example: Deploy to GitHub Pages
./mkdocs-build.sh build
# Then push the site/ folder to your gh-pages branch
```

---

## Project Structure

```
tooth-fairy-manifesto/
├── manuscript/               # Source of truth (49 chapter files)
│   ├── 00-frontmatter/       # Title, preface, introduction
│   ├── 01-part-one/          # Chapters 1-4 (Foundations)
│   ├── ...                   # Parts 2-8
│   ├── 09-part-nine/         # Chapters 30-33 (Living It)
│   └── 10-appendices/        # Appendices A-D
├── combined/
│   └── complete-manuscript.md  # Single-file version for Pandoc
├── docs/                     # MkDocs source (generated from manuscript)
├── site/                     # MkDocs output (static website)
├── output/                   # Pandoc output (PDF, EPUB, etc.)
├── .venv/                    # Python virtual environment (auto-created)
├── metadata.yaml             # Pandoc configuration
├── mkdocs.yml                # MkDocs configuration
├── requirements.txt          # Python dependencies
├── build.sh                  # Pandoc build script
├── mkdocs-build.sh           # MkDocs build script (manages venv)
├── .gitignore                # Git ignore patterns
└── README.md                 # This file
```

---

## Editing

Each chapter is a separate Markdown file, making it easy to:
- Edit individual sections without navigating a massive file
- Reorganize chapters by moving files
- Track changes with version control (Git)
- Collaborate with others on specific sections

After editing chapter files, run `./build.sh combine` to regenerate the combined manuscript.

The `combined/complete-manuscript.md` file is the single-file version suitable for reading straight through or for conversion.

---

## Customization

### Changing Fonts

Edit `metadata.yaml` to specify different fonts:

```yaml
mainfont: "Your Preferred Serif Font"
sansfont: "Your Preferred Sans Font"
monofont: "Your Preferred Mono Font"
```

### Adjusting Layout

Page margins, font size, and line spacing can all be adjusted in `metadata.yaml`.

### Adding a Cover Image

For EPUB generation, add a `cover.png` file to the root directory and update the `epub-cover-image` path in `metadata.yaml`.

---

## License

Content © 2025. 

*The Tooth Fairy claims no copyright on wisdom that should have been obvious to your species from the beginning.*

---

## A Final Note from the Fairy

*"I didn't want to write this book. I wanted to retire. But here we are, and if putting these words on paper means even one fewer midnight visit to collect what could have been saved, then I suppose it will have been worth it.*

*Read carefully. Apply wisely. And for the love of everything—stop burning your mouth with products that destroy the very ecosystem trying to protect you.*

*Your teeth are listening. They've been listening all along. It's time you started listening back."*

---

*— The Tooth Fairy*

*Who has been doing this for far too long, and would like very much to stop*
