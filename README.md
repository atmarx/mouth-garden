# Keep Your Teeth

**What the Tooth Fairy Has Been Trying to Tell You**
*An Ecological Approach to Oral Health*

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

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
git clone https://github.com/atmarx/keep-your-teeth.git
cd keep-your-teeth

# Set up environment and serve
./mkdocs-build.sh setup    # First time only
./mkdocs-build.sh serve    # Start dev server

# Open http://127.0.0.1:8000
```

## Build Systems

### MkDocs (Documentation Website)

The `mkdocs-build.sh` script manages its own Python virtual environment:

| Command | Description |
|---------|-------------|
| `./mkdocs-build.sh setup` | Create `.venv/` and install dependencies (*mkdocs-material* and *mkdocs-minify-plugin*) |
| `./mkdocs-build.sh serve` | Start dev server at http://127.0.0.1:8000 using `--livereload` to monitor for changes |
| `./mkdocs-build.sh build` | Build static site to `site/` |
| `./mkdocs-build.sh clean` | Remove generated files |
| `./mkdocs-build.sh clean-all` | Also remove `.venv/` |

**System requirements:** Python 3.8+, venv, pip

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

This work is licensed under [Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/).

You are free to share and adapt this material for non-commercial purposes, as long as you provide appropriate attribution.

## Acknowledgments

This book was developed collaboratively with [Claude](https://www.anthropic.com/claude), an AI assistant by Anthropic, who contributed research synthesis across biochemistry, microbiology, botany, and cultural history.

---

*"Your teeth are one of the only problems in your life that will go away if you ignore them."*
