# Beyond the Burn

**An Ecological Approach to Oral Health**  
*As narrated by the Tooth Fairy*

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

---

## About

This is a ~70,000-word book exploring oral health from an ecological perspective—treating the mouth as an ecosystem to nurture rather than a battlefield to sterilize. Written in the voice of a weary, ancient Tooth Fairy who has collected far too many teeth and would very much like humans to keep theirs.

The book synthesizes research across:
- **Biochemistry** — Enamel structure, remineralization, pH dynamics
- **Microbiology** — The oral microbiome, biofilm ecology, beneficial bacteria
- **Botany** — Traditional plant remedies with modern evidence (miswak, propolis, sage, etc.)
- **History** — How we went from chew sticks to chlorhexidine
- **Practical application** — DIY formulations, daily protocols, evidence evaluation

## Quick Start

### View as Website (MkDocs)

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/tooth-fairy-manifesto.git
cd tooth-fairy-manifesto

# Set up environment and serve
./mkdocs-build.sh setup    # First time only
./mkdocs-build.sh serve    # Start dev server

# Open http://127.0.0.1:8000
```

### Generate Book Formats (Pandoc)

```bash
# Requires: pandoc, texlive-xetex
./build.sh pdf     # PDF via XeLaTeX
./build.sh epub    # E-reader format
./build.sh docx    # Microsoft Word
./build.sh html    # Standalone HTML
./build.sh all     # All formats
```

## Project Structure

```
tooth-fairy-manifesto/
├── manuscript/                 # Source of truth (50 Markdown files)
│   ├── 00-frontmatter/         # Foreword, preface, introduction
│   ├── 01-part-one/            # Part I: Foundations (Ch. 1-4)
│   ├── 02-part-two/            # Part II: How We Got Here (Ch. 5-7)
│   ├── 03-part-three/          # Part III: The Enemies (Ch. 8-10)
│   ├── 04-part-four/           # Part IV: Chemistry of Care (Ch. 11-13)
│   ├── 05-part-five/           # Part V: Delivery (Ch. 14-16)
│   ├── 06-part-six/            # Part VI: Botanicals (Ch. 17-24)
│   ├── 07-part-seven/          # Part VII: Modern Innovations (Ch. 25-27)
│   ├── 08-part-eight/          # Part VIII: The Bigger Picture (Ch. 28-29)
│   ├── 09-part-nine/           # Part IX: Living It (Ch. 30-33)
│   └── 10-appendices/          # Appendices A-D
│
├── docs/                       # MkDocs source (generated from manuscript)
├── site/                       # MkDocs output (static website)
├── combined/                   # Single-file manuscript for Pandoc
├── output/                     # Pandoc output (PDF, EPUB, etc.)
│
├── mkdocs.yml                  # MkDocs configuration
├── mkdocs-build.sh             # MkDocs build script (manages venv)
├── metadata.yaml               # Pandoc metadata/configuration
├── build.sh                    # Pandoc build script
├── requirements.txt            # Python dependencies
│
├── .claude/                    # Claude Code project context
│   └── CLAUDE.md               # Instructions for AI assistants
├── TODO.md                     # Future improvements
└── README.md                   # This file
```

## Table of Contents

### Frontmatter
- Foreword
- Preface: *The Tooth Fairy's Confession*
- Introduction: *Why Your Teeth Keep Losing*

### Part I: Foundations
1. The Crystal Under Siege — Enamel chemistry and structure
2. Saliva: The Unsung Hero — Your mouth's defense system
3. The Ecosystem in Your Mouth — 700+ species working together
4. The Tongue — The forgotten reservoir

### Part II: How We Got Here
5. From Chew Sticks to Chlorhexidine — A history of oral care
6. The Problem with Scorched Earth — When antiseptics backfire
7. The Paradigm Shift — Ecological vs. antimicrobial thinking

### Part III: The Enemies
8. The Acid Equation — Demineralization dynamics
9. Sugar: Frequency Over Quantity — Why timing matters more than amount
10. The Biofilm Fortress — Understanding plaque ecology

### Part IV: Chemistry of Care
11. A Simple Rinse, Deeply Understood — Salt, baking soda, and why they work
12. Essential Oils: The Evidence — What research actually shows
13. Formulating Your Own — DIY rinse recipes

### Part V: Delivery
14. Mechanical Disruption — The physics of biofilm removal
15. Water Flossers — Subgingival delivery systems
16. The Combination Approach — Integrating methods

### Part VI: Botanicals
17. The Miswak Tradition — *Salvadora persica* and its chemistry
18. The Warming Roots — Ginger and inflammatory modulation
19. The Healing Herbs — Sage, thyme, chamomile
20. The Sweet Exceptions — Licorice root and manuka honey
21. Resins and Extracts — Propolis and myrrh
22. The Green Pharmacy — Green tea, cranberry, neem
23. Oil Pulling — Evidence and mechanisms
24. Modern Trends — Charcoal, probiotics, and what's next

### Part VII: Modern Innovations
25. The Fluoride Question — Benefits, risks, and alternatives
26. Nano-Hydroxyapatite — Biomimetic remineralization
27. Emerging Technologies — Probiotics, arginine, and beyond

### Part VIII: The Bigger Picture
28. The Oral-Systemic Connection — Heart disease, diabetes, and more
29. Breath and the Social Mouth — Halitosis science

### Part IX: Living It
30. A Day in the Optimized Mouth — Morning to night protocols
31. Building Your Personal Protocol — Customization framework
32. Raising Resilient Teeth — Children's oral health
33. When to See a Professional — Red flags and integration

### Appendices
- A. Quick Reference Formulations
- B. Ingredient Glossary
- C. The Evidence Hierarchy
- D. Resources and Further Reading

## Build Systems

### MkDocs (Documentation Website)

The `mkdocs-build.sh` script manages its own Python virtual environment:

| Command | Description |
|---------|-------------|
| `./mkdocs-build.sh setup` | Create `.venv/` and install dependencies |
| `./mkdocs-build.sh serve` | Start dev server at http://127.0.0.1:8000 |
| `./mkdocs-build.sh build` | Build static site to `site/` |
| `./mkdocs-build.sh prepare` | Sync manuscript → docs/ |
| `./mkdocs-build.sh clean` | Remove generated files |
| `./mkdocs-build.sh clean-all` | Also remove `.venv/` |

**System requirements:** Python 3.8+, venv, pip

### Pandoc (Traditional Formats)

The `build.sh` script generates print-ready documents:

| Command | Description |
|---------|-------------|
| `./build.sh pdf` | PDF via XeLaTeX |
| `./build.sh epub` | E-reader format |
| `./build.sh docx` | Microsoft Word |
| `./build.sh html` | Standalone HTML |
| `./build.sh all` | All formats |
| `./build.sh combine` | Just merge manuscript |

**System requirements:** Pandoc, TeX Live (for PDF)

## Editing Workflow

1. **Edit source files** in `manuscript/` (this is the source of truth)
2. **Preview changes** with `./mkdocs-build.sh serve`
3. **Generate outputs** with `./build.sh all` or `./mkdocs-build.sh build`

The `docs/` folder is generated from `manuscript/` by the build script—don't edit it directly.

## URL Structure

The MkDocs site uses semantic, SEO-friendly URLs:

| Section | URL Path |
|---------|----------|
| Foundations | `/foundations/` |
| History | `/history/` |
| Enemies | `/enemies/` |
| Chemistry | `/chemistry/` |
| Delivery | `/delivery/` |
| Botanicals | `/botanicals/` |
| Innovations | `/innovations/` |
| Bigger Picture | `/bigger-picture/` |
| Living It | `/living-it/` |
| Reference | `/reference/` |

Individual chapters have descriptive slugs like `/botanicals/miswak-salvadora-persica/`.

## License

This work is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

You are free to share and adapt this material for any purpose, including commercially, as long as you provide appropriate attribution.

## Acknowledgments

This book was developed collaboratively with [Claude](https://www.anthropic.com/claude), an AI assistant by Anthropic, who contributed research synthesis across biochemistry, microbiology, botany, and cultural history.

---

*"Your teeth are one of the only problems in your life that will go away if you ignore them."*
