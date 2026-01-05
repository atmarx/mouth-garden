# Unsplash Image Integration Skill

A standardized workflow for downloading, processing, and integrating Unsplash images into documentation projects with proper attribution.

## When to Use

Use this skill when you need to:
- Add stock photos from Unsplash to a documentation site
- Ensure proper licensing attribution for Unsplash images
- Optimize images for web delivery (resize and convert to WebP)

## Required Inputs

1. **Unsplash photo URL(s)** - e.g., `https://unsplash.com/photos/[slug]-[photo_id]`
2. **Target location** - Where to place images (default: `docs/images/unsplash/`)
3. **Placement context** - Which documents/chapters to add images to

## Workflow Steps

### Step 1: Extract Photographer Credits

For each Unsplash URL, extract the photographer name and username:

```bash
curl -sL "https://unsplash.com/photos/[PHOTO_ID]" | grep -oP 'Photo by [^|]+' | head -1
curl -sL "https://unsplash.com/photos/[PHOTO_ID]" | grep -oP 'twitter:creator" content="@[^"]+' | head -1
```

### Step 2: Find CDN URLs and Download

**Important:** The photo ID in page URLs (e.g., `2FwxoOj1eO8`) differs from CDN URLs (e.g., `photo-1607278843240-419b8d83672d`). Extract the correct CDN URL from the page:

```bash
curl -sL "https://unsplash.com/photos/[PAGE_ID]" | grep -oP 'https://images\.unsplash\.com/photo-[a-zA-Z0-9-]+' | head -1
```

Then download with size parameter:

```bash
curl -L -o [name]-raw.jpg "[CDN_URL]?w=1200"
```

**Example:**
```bash
# Get CDN URL for photo 2FwxoOj1eO8
cdn_url=$(curl -sL "https://unsplash.com/photos/2FwxoOj1eO8" | grep -oP 'https://images\.unsplash\.com/photo-[a-zA-Z0-9-]+' | head -1)
# Returns: https://images.unsplash.com/photo-1607278843240-419b8d83672d

# Download
curl -L -o teeth-raw.jpg "${cdn_url}?w=1200"
```

### Step 3: Check Dimensions

```bash
for f in *-raw.jpg; do
  echo -n "$f: "
  ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$f"
done
```

### Step 4: Resize and Convert to WebP

Resize to max 1000px on longest dimension and convert to WebP:

```bash
for f in [names]; do
  ffmpeg -y -i "${f}-raw.jpg" \
    -vf "scale='if(gt(iw,ih),min(1000,iw),-2)':'if(gt(ih,iw),min(1000,ih),-2)'" \
    -quality 85 "${f}.webp"
done
```

**Alternative using cwebp (if ffmpeg unavailable):**
```bash
# First resize with ImageMagick, then convert
convert input.jpg -resize "1000x1000>" resized.jpg
cwebp -q 85 resized.jpg -o output.webp
```

### Step 5: Clean Up

```bash
rm -f *-raw.jpg
ls -la *.webp  # Verify results
```

### Step 6: Add to Documentation

Insert images with attribution embedded in the alt text (for GLightbox caption display):

```markdown
![Description. Photo by <a href='https://unsplash.com/@username'>Name</a> on <a href='https://unsplash.com/photos/photo_id'>Unsplash</a>](../images/unsplash/filename.webp){ align=right width=200 }
```

## Attribution Format

Embed attribution in the image description using HTML links with **single quotes**:

```markdown
![Alt text. Photo by <a href='https://unsplash.com/@username'>Name</a> on <a href='https://unsplash.com/photos/photo_id'>Unsplash</a>](path/to/image.webp)
```

**Why this format:**

- GLightbox displays alt text as the lightbox caption when image is clicked
- HTML links with single quotes work inside markdown image alt text
- Attribution is always visible when user enlarges the image
- No separate caption line needed in the document
- Cleaner document structure

## Image Placement Guidelines

- Use `{ align=right width=200 }` for inline images that text wraps around
- Place images near relevant content, not at section starts
- Consider mobile responsiveness (images should stack on narrow screens)
- For MkDocs Material, ensure CSS handles `align=right` on mobile:

```css
@media screen and (max-width: 768px) {
  .md-typeset img[align="right"] {
    float: none;
    display: block;
    margin: 1rem auto;
  }
}
```

## Example Session

```
User: Add this Unsplash image to the bruxism chapter:
https://unsplash.com/photos/person-wearing-silver-diamond-ring-fmB7IdFjhTM

Claude:
1. Fetches page, extracts: Diana Polekhina (@diana_pole)
2. Downloads: curl -L -o nightguard-raw.jpg "https://images.unsplash.com/photo-..."
3. Processes: ffmpeg -y -i nightguard-raw.jpg -vf "scale=..." -quality 85 nightguard.webp
4. Adds to chapter:
   ![Person inserting a dental night guard. Photo by <a href='https://unsplash.com/@diana_pole'>Diana Polekhina</a> on <a href='https://unsplash.com/photos/fmB7IdFjhTM'>Unsplash</a>](../images/nightguard.webp){ align=right width=200 }
```

## Troubleshooting

**Can't find photographer name:** Check the `og:title` or `twitter:creator` meta tags in page source.

**Image download fails:** Try the source.unsplash.com redirect: `https://source.unsplash.com/[PHOTO_ID]`

**WebP conversion fails:** Ensure ffmpeg or cwebp is installed. On Arch: `pacman -S ffmpeg libwebp`

## License Notes

Unsplash images are free to use under the [Unsplash License](https://unsplash.com/license):
- Free for commercial and non-commercial use
- No permission needed
- Attribution not legally required but appreciated and good practice
- Cannot sell unaltered copies or compile into competing service
