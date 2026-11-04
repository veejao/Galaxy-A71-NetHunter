# Build and image packaging log

## Kernel build

- Source: `ianmacd/a71`
- Commit: `270b258aba77c21eafeba837f266339482976f7e`
- Kernel version: `4.14.190`
- Defconfig: `sm7150_sec_a71_eur_open_caliban_defconfig`
- Compiler: Clang 6.0.1
- Cross compiler: Android NDK r17c GCC 4.9
- GNU Make: 4.3
- Result: build completed successfully.

Observed outputs:
- `arch/arm64/boot/Image` — 48,984,080 bytes
- `arch/arm64/boot/Image.gz-dtb` — 16,816,413 bytes
- `vmlinux` — approximately 433 MB

## Boot image repack

Original boot image was unpacked with MagiskBoot. The newly built raw `Image` was used as the kernel payload; original ramdisk and DTB were retained.

The repacked image was unpacked again. The extracted components matched:
- kernel: `9e16c2717013b60cf94b4cfedb281c8cf020d95534a79730af2c4094913e8a46`
- ramdisk: `cc0528b05a62b829d6a599efc8f70ecb80370db7a230ce09812a5387c6ced622`
- DTB: `5cd52c1b4258d0a550a05f0b72b35f4a10c53b4be59feb13e4072a2323582101`

Test image SHA-256:
`73814cddf97db30757aa4f5488440b17da7fdf970c8ad7a3b9b81d9bd788627e`

These hashes describe one local experimental build. They do not certify that the image is safe to flash or compatible with the phone's boot chain.

## Outstanding questions

1. Does the source DTB match the exact SM-A715F board revision and firmware?
2. What exact AVB and Samsung boot-chain handling is required?
3. Can a compatible recovery be installed and restored safely?
4. Does the custom kernel boot on the phone?
5. Which NetHunter kernel features work in actual tests?
