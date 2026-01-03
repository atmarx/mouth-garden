# Contributing to Mouth Garden

Thank you for your interest in contributing to this project! This document provides guidelines for contributions.

## License

By contributing, you agree that your contributions will be licensed under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Ways to Contribute

### 1. Report Issues

Found an error? Have a suggestion? Open an issue with:

- **Factual errors** — Incorrect scientific claims, outdated information
- **Typos/grammar** — Spelling mistakes, awkward phrasing
- **Broken links** — Dead URLs, incorrect internal references
- **Build problems** — Issues with the MkDocs or Pandoc build
- **Feature requests** — Ideas for new content or functionality

### 2. Suggest Content

We welcome suggestions for:

- New topics to cover
- Additional research citations
- Traditional remedies from other cultures
- Clarifications on complex topics
- Practical tips and protocols

### 3. Submit Changes

For direct contributions:

1. Fork the repository
2. Create a branch (`git checkout -b fix/typo-in-chapter-5`)
3. Make your changes in `manuscript/` (not `docs/`)
4. Test with `./mkdocs-build.sh serve`
5. Submit a pull request

## Content Guidelines

### Voice

The book is narrated by the Tooth Fairy. When writing new content:

- **Warm but exasperated** — genuinely caring, tired of human mistakes
- **Scientifically accurate** — cite sources, acknowledge uncertainty
- **Accessible** — explain jargon, use analogies
- **Dry humor** — occasional sarcasm, never mean-spirited

The **foreword** is the only section in human voice.

### Evidence Standards

We use a tiered evidence system:

| Tier | Meaning | Language |
|------|---------|----------|
| 1 | Strong evidence (systematic reviews, multiple RCTs) | "Research shows..." |
| 2 | Moderate evidence (RCTs, good cohort studies) | "Evidence suggests..." |
| 3 | Promising but limited (small studies, in vitro) | "Preliminary research indicates..." |
| 4 | Traditional use only | "Traditionally used for..." |
| 5 | Unlikely or disproven | "Despite claims, evidence does not support..." |

When adding claims, indicate the evidence tier.

### Formatting

- **Headers**: `#` chapter, `##` section, `###` subsection
- **Bold**: Key terms on first use
- **Italics**: Emphasis, species names (*Lactobacillus reuteri*)
- **Blockquotes**: Tooth Fairy asides
- **Tables**: Comparisons, formulations, protocols

## File Structure

```
manuscript/
├── 00-frontmatter/     # Foreword, preface, introduction
├── 01-part-one/        # Chapters start with 01-, 02-, etc.
│   ├── 00-part-intro.md
│   ├── 01-chapter-name.md
│   └── 02-chapter-name.md
...
└── 10-appendices/
```

If adding a new chapter:

1. Create the file in the appropriate part folder
2. Update `mkdocs.yml` navigation
3. Update `FILE_MAP` in `mkdocs-build.sh`

## Testing Changes

```bash
# Preview your changes
./mkdocs-build.sh serve

# Check for broken links
./mkdocs-build.sh build  # Will fail on broken internal links

# Generate PDF to check formatting
./build.sh pdf
```

## Code of Conduct

- Be respectful and constructive
- Focus on the content, not the contributor
- Assume good faith
- No medical advice to individuals (this is educational content)

## Questions?

Open an issue or reach out to the maintainers. We appreciate your help making oral health information more accessible!
