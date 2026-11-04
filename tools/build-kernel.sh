#!/usr/bin/env bash
set -euo pipefail

# Expected layout:
#   ~/a71-android11
#   ~/toolchains/make-4.3
#   ~/toolchains/android-ndk-r17c
#   ~/toolchains/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04

KERNEL_DIR="${KERNEL_DIR:-$HOME/a71-android11}"
TOOLCHAINS_DIR="${TOOLCHAINS_DIR:-$HOME/toolchains}"
MAKE="${MAKE:-$TOOLCHAINS_DIR/make-4.3/bin/make}"
CROSS_PREFIX="$TOOLCHAINS_DIR/android-ndk-r17c/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin/aarch64-linux-android-"
CLANG="$TOOLCHAINS_DIR/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang"

for path in "$KERNEL_DIR/Makefile" "$MAKE" "$CLANG" "${CROSS_PREFIX}gcc" "$KERNEL_DIR/tools/dtc"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing required path: $path" >&2
    exit 1
  fi
done

cd "$KERNEL_DIR"
echo "Source revision: $(git rev-parse HEAD 2>/dev/null || echo unknown)"
echo "Building in: $KERNEL_DIR"

"$MAKE" -j"${JOBS:-4}" \
  ARCH=arm64 \
  CROSS_COMPILE="$CROSS_PREFIX" \
  REAL_CC="$CLANG" \
  CLANG_TRIPLE=aarch64-linux-gnu- \
  CFP_CC="$CLANG" \
  DTC_EXT="$(pwd)/tools/dtc" \
  CONFIG_BUILD_ARM64_DT_OVERLAY=y

test -s arch/arm64/boot/Image
file arch/arm64/boot/Image
sha256sum arch/arm64/boot/Image
