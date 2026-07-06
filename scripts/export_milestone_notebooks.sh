
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MILESTONE="${1:-milestone1}"

NOTEBOOK_DIR="$ROOT_DIR/notebooks/$MILESTONE"
EXPORT_BASE="$ROOT_DIR/reports/$MILESTONE/notebook_exports"
HTML_DIR="$EXPORT_BASE/html"
PDF_DIR="$EXPORT_BASE/pdf"
BUILD_DIR="$EXPORT_BASE/build"
MERGED_PDF="$EXPORT_BASE/${MILESTONE}_notebooks_merged.pdf"
COMPRESSED_PDF="$EXPORT_BASE/${MILESTONE}_notebooks_merged_compressed.pdf"

mkdir -p "$HTML_DIR" "$PDF_DIR" "$BUILD_DIR"

if ! compgen -G "$NOTEBOOK_DIR/0[1-9]_*.ipynb" > /dev/null; then
  echo "No milestone notebooks found in $NOTEBOOK_DIR" >&2
  exit 1
fi

echo "Exporting HTML from $NOTEBOOK_DIR ..."
for nb in "$NOTEBOOK_DIR"/[0-9][0-9]_*.ipynb; do
  uv run python -m nbconvert --to html "$nb" --output-dir "$HTML_DIR"
done

echo "Exporting PDF from $NOTEBOOK_DIR ..."
pushd "$BUILD_DIR" > /dev/null
for nb in "$NOTEBOOK_DIR"/[0-9][1-9]_*.ipynb; do
  uv run python -m nbconvert --to pdf "$nb" --output-dir "$PDF_DIR"
done
popd > /dev/null

mapfile -t pdfs < <(find "$PDF_DIR" -maxdepth 1 -type f -name '*.pdf' | sort)

if [ "${#pdfs[@]}" -eq 0 ]; then
  echo "No PDFs were generated in $PDF_DIR" >&2
  exit 1
fi

echo "Merging PDFs into $MERGED_PDF ..."
pdfunite "${pdfs[@]}" "$MERGED_PDF"

if command -v gs > /dev/null 2>&1; then
  echo "Creating compressed PDF $COMPRESSED_PDF ..."
  gs -sDEVICE=pdfwrite \
     -dCompatibilityLevel=1.4 \
     -dPDFSETTINGS=/ebook \
     -dNOPAUSE -dQUIET -dBATCH \
     -sOutputFile="$COMPRESSED_PDF" \
     "$MERGED_PDF"
fi

echo "Done."
echo "HTML: $HTML_DIR"
echo "PDF:  $PDF_DIR"
echo "Merged: $MERGED_PDF"
