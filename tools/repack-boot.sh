#!/usr/bin/env bash
set -euo pipefail

# This script only repacks a local working copy. It does not flash anything.
# Usage:
#   ./tools/repack-boot.sh /path/to/stock-boot.img /path/to/new-kernel-Image /path/to/magiskboot /path/to/output.img

if [[ $# -ne 4 ]]; then
  echo "Usage: $0 STOCK_BOOT.img KERNEL_Image MAGISKBOOT OUTPUT.img" >&2
  exit 2
fi

STOCK_BOOT="$(realpath "$1")"
KERNEL_IMAGE="$(realpath "$2")"
MAGISKBOOT="$(realpath "$3")"
OUTPUT="$(realpath -m "$4")"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

for path in "$STOCK_BOOT" "$KERNEL_IMAGE" "$MAGISKBOOT"; do
  [[ -f "$path" ]] || { echo "File not found: $path" >&2; exit 1; }
done

mkdir -p "$(dirname "$OUTPUT")"
cp "$STOCK_BOOT" "$WORK/boot.img"
cd "$WORK"

"$MAGISKBOOT" unpack boot.img
cp "$KERNEL_IMAGE" kernel
"$MAGISKBOOT" repack boot.img "$OUTPUT"

echo "Created experimental image: $OUTPUT"
echo "SHA-256:"
sha256sum "$OUTPUT"
echo "WARNING: repack success does not prove bootability or AVB compatibility."
