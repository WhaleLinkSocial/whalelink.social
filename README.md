# WhaleLink Social Landing Page

Simple static landing page featuring an animated breaching cartoon humpback whale (outlined style with spout), playful bubbles, and contact links.

## Structure
- `index.html` – Single-page site with inline CSS and minimal JS.
- `assets/` – SVG whale (`whale.svg`), Open Graph image (`og-image.svg`), favicon (`favicon.svg`) plus committed PNG fallbacks (`og-image.png`, `favicon-192.png`, `apple-touch-icon.png`).
- `scripts/render-assets.sh` – Local helper to regenerate PNG fallbacks (auto-detects rsvg / Inkscape / ImageMagick).

## Local Preview
Just open `index.html` in a browser.

Or run a tiny local server (Python 3):

```bash
python3 -m http.server 8080
```
Then visit: http://localhost:8080

## Customization
- Tagline: Edit `<p class="tag">` in `index.html`.
- Animation timing: Adjust `@keyframes breach`, `spout`, `rise`, `splash` in the `<style>` block.
- Reduce motion: Already handled via `@media (prefers-reduced-motion: reduce)`.
- Social preview: Edit `assets/og-image.svg` then regenerate PNG (`./scripts/render-assets.sh`).
- Favicon: Edit `assets/favicon.svg` and regenerate PNGs.
- Whale art: `assets/whale.svg` / inline SVG share style (base `#4acfff`, highlight `#80ddff`, outline `#27303a`).

## Asset Rendering
Regenerate PNG fallbacks locally:

```bash
# Install one backend
brew install librsvg imagemagick   # fastest
# or
brew install --cask inkscape

# Generate PNGs
./scripts/render-assets.sh
```

Outputs:
- `assets/og-image.png`
- `assets/favicon-192.png`
- `assets/apple-touch-icon.png`

Commit the PNGs after updating the SVG sources.

## Contact
Email: hi@whalelink.social
Source: https://github.com/WhaleLinkSocial/whalelink.social

## License
Content & code © WhaleLink Social. Add an OSS license (MIT/Apache-2.0) if you want external contributions.
