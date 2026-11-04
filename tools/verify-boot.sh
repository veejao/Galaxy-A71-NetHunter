#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./tools/verify-boot.sh IMAGE.img MAGISKBOOT EXPECTED_KERNEL EXPECTED_RAMDISK EXPECTED_DTB
#
# Expected files are the payloads used to create the image. This checks that
# MagiskBoot can unpack the image and that extracted payloads match those files.
# It does NOT validate AVB, Samsung signatures, or device boot compatibility.

if [[ $# -ne 5 ]]; then
  echo "Usage: $0 IMAGE.img MAGISKBOOT EXPECTED_KERNEL EXPECTED_RAMDISK EXPECTED_DTB" >&2
  exit 2
fi

IMAGE="$(realpath "$1")"
MAGISKBOOT="$(realpath "$2")"
EXPECTED_KERNEL="$(realpath "$3")"
EXPECTED_RAMDISK="$(realpath "$4")"
EXPECTED_DTB="$(realpath "$5")"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
cp "$IMAGE" "$WORK/boot.img"
cd "$WORK"

"$MAGISKBOOT" unpack boot.img

for item in kernel ramdisk.cpio dtb; do
  [[ -s "$item" ]] || { echo "Missing extracted component: $item" >&2; exit 1; }
done

cmp kernel "$EXPECTED_KERNEL"
cmp ramdisk.cpio "$EXPECTED_RAMDISK"
cmp dtb "$EXPECTED_DTB"

echo "PASS: extracted kernel, ramdisk, and DTB match the expected input files."
echo "This is a packaging check only; it does not establish that the phone will boot."
sha256sum boot.img kernel ramdisk.cpio dtb
