# WhaleLink Social Landing Page

Simple static landing page featuring an animated breaching cartoon humpback whale (outlined style with spout), playful bubbles, and contact links.

## Structure
- `index.html` – Single-page site with inline CSS and a tiny JS snippet.
- `assets/` – SVG whale art (`whale.svg` – outlined cartoon with spout), Open Graph image (`og-image.svg`), favicon (`favicon.svg`). PNG fallbacks are committed (render locally with script).
- `.github/workflows/generate-png.yml` – CI workflow to export PNG assets from SVG sources.

## Local Preview
Just open `index.html` in a browser.

Or run a tiny local server (Python 3):

```bash
python3 -m http.server 8080
```
Then visit: http://localhost:8080

## Customization
- Swap tagline: Edit the `<p class="tag">` line.
- Animation timing: Keyframes `breach`, `splash`, and `rise` inside the `<style>` tag.
- Reduce motion: Users with `prefers-reduced-motion` are respected (animations disabled).
- Social preview: Edit `assets/og-image.svg` (workflow regenerates `og-image.png`).
- Favicon: Update `assets/favicon.svg` (workflow regenerates PNG variants: `favicon-192.png`, `apple-touch-icon.png`).
- Whale art: `assets/whale.svg` uses the outlined cartoon style (colors: base `#4acfff`, highlight `#80ddff`, outline `#27303a`). Adjust paths or palette for brand tweaks.

## Asset Rendering
Render PNG fallbacks locally (macOS examples shown):

```bash
# Install one backend
brew install librsvg imagemagick   # fastest
# or
brew install --cask inkscape

# Generate PNGs
./scripts/render-assets.sh
```

Outputs written:
- `assets/og-image.png`
- `assets/favicon-192.png`
- `assets/apple-touch-icon.png`

Commit the PNGs after updating SVG sources.

## Contact
Email: hi@whalelink.social
Source: https://github.com/WhaleLinkSocial/whalelink.social

## License
Content & code © WhaleLink Social. Add an OSS license (MIT/Apache-2.0) if you want external contributions.
