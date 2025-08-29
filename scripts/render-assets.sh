#!/usr/bin/env bash
set -euo pipefail

# Local SVG -> PNG renderer supporting multiple backends (prefers rsvg-convert, then Inkscape, then ImageMagick).
# Usage: ./scripts/render-assets.sh [--force]
# Outputs: assets/og-image.png, assets/favicon-192.png, assets/apple-touch-icon.png
# Recommended installs (macOS):
#   brew install librsvg imagemagick   # (fast headless default)
#   brew install --cask inkscape       # (optional fallback)
# If only ImageMagick is present, quality should still be fine for these flat SVGs.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

FORCE=false
if [[ ${1:-} == "--force" ]]; then
  FORCE=true
fi

function need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing required tool '$1'" >&2; exit 1; }; }
BACKEND=""
if command -v rsvg-convert >/dev/null 2>&1; then
  BACKEND="rsvg"
elif command -v inkscape >/dev/null 2>&1; then
  BACKEND="inkscape"
elif command -v magick >/dev/null 2>&1; then
  BACKEND="magick"
elif command -v convert >/dev/null 2>&1; then
  BACKEND="convert"
else
  echo "No supported SVG renderer found. Install one of: librsvg (rsvg-convert), Inkscape, or ImageMagick." >&2
  echo "macOS (Homebrew) examples: brew install librsvg imagemagick   OR   brew install --cask inkscape" >&2
  exit 1
fi

echo "Using backend: $BACKEND" >&2

OG_SRC=assets/og-image.svg
FAV_SRC=assets/favicon.svg

OG_PNG=assets/og-image.png
FAV192=assets/favicon-192.png
APPLE=assets/apple-touch-icon.png

OG_HASH=$(sha256sum "$OG_SRC" | cut -d' ' -f1)
FAV_HASH=$(sha256sum "$FAV_SRC" | cut -d' ' -f1)

render () { # width height src dest
  local W=$1 H=$2 SRC=$3 DEST=$4
  case "$BACKEND" in
    rsvg)
      rsvg-convert -w "$W" -h "$H" "$SRC" -o "$DEST" ;;
    inkscape)
      # Inkscape ≥1.0 CLI
      inkscape "$SRC" --export-type=png --export-filename="$DEST" -w "$W" -h "$H" >/dev/null 2>&1 ;;
    magick)
      magick convert -background none -resize ${W}x${H} "$SRC" PNG32:"$DEST" ;;
    convert)
      convert -background none -resize ${W}x${H} "$SRC" PNG32:"$DEST" ;;
  esac
}

render 1200 630 "$OG_SRC" "$OG_PNG"
render 192 192  "$FAV_SRC" "$FAV192"
render 180 180  "$FAV_SRC" "$APPLE"

# Embed metadata comment if convert available
if command -v magick >/dev/null 2>&1; then
  META_CONVERT=magick
elif command -v convert >/dev/null 2>&1; then
  META_CONVERT=convert
fi

if [[ ${META_CONVERT:-} ]]; then
  META_TAG="local-render og=$OG_HASH fav=$FAV_HASH date=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  $META_CONVERT "$OG_PNG"   -set comment "$META_TAG" "$OG_PNG" || true
  $META_CONVERT "$FAV192"   -set comment "$META_TAG" "$FAV192" || true
  $META_CONVERT "$APPLE"    -set comment "$META_TAG" "$APPLE" || true
else
  echo "(Tip) Install ImageMagick (convert/magick) if you want metadata comments embedded." >&2
fi

# --force now only forces re-render; no meta file produced anymore.

echo "Rendered PNG assets:" >&2
ls -lh "$OG_PNG" "$FAV192" "$APPLE"

echo "Hashes:" >&2
echo "  og-image.svg $OG_HASH" >&2
echo "  favicon.svg  $FAV_HASH" >&2

echo "Done." >&2
