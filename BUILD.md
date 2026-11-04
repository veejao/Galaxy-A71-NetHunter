# Build instructions

These instructions reflect the original local Kali Linux build environment. Paths assume the kernel source is at `~/a71-android11` and toolchains are under `~/toolchains`.

## 1. Obtain the source

```bash
git clone https://github.com/ianmacd/a71.git ~/a71-android11
cd ~/a71-android11
git checkout 270b258aba77c21eafeba837f266339482976f7e
```

Do not silently update the source revision: record and review any change first.

## 2. Toolchain layout used

The successful build used:

```text
~/toolchains/
├── android-ndk-r17c/
│   └── toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin/
├── clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/
└── make-4.3/bin/make
```

Required tools/libraries included Python 2.7, `bc`, `libssl-dev`, and the repository's `tools/dtc`.

The local Make 4.3 binary was used because the system Make 4.4.1 caused issues in this legacy kernel tree.

## 3. Configure

The selected defconfig was:

```text
sm7150_sec_a71_eur_open_caliban_defconfig
```

If starting from a clean tree:

```bash
cd ~/a71-android11
make O=out ARCH=arm64 sm7150_sec_a71_eur_open_caliban_defconfig
```

The original successful build was performed in the source tree with an existing `.config`. Preserve that config if you need to reproduce the exact build. The full `.config` has not yet been committed because the exact local file should be reviewed and scrubbed before publication.

## 4. Build command used successfully

Run from the kernel source root:

```bash
cd ~/a71-android11

~/toolchains/make-4.3/bin/make -j4 \
  ARCH=arm64 \
  CROSS_COMPILE=../toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android- \
  REAL_CC=../toolchains/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang \
  CLANG_TRIPLE=aarch64-linux-gnu- \
  CFP_CC=../toolchains/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang \
  DTC_EXT="$(pwd)/tools/dtc" \
  CONFIG_BUILD_ARM64_DT_OVERLAY=y
```

The command above assumes `~/a71-android11` and `~/toolchains` are sibling directories under the home directory.

## 5. Expected output

The successful build produced:

```text
arch/arm64/boot/Image
arch/arm64/boot/Image.gz
arch/arm64/boot/Image.gz-dtb
vmlinux
```

Recorded output sizes from that build:

| Artifact | Size |
|---|---:|
| `Image` | 48,984,080 bytes |
| `Image.gz` | approximately 16 MB |
| `Image.gz-dtb` | 16,816,413 bytes |
| `vmlinux` | approximately 433 MB |

These sizes are historical observations, not guaranteed values for future builds.

## 6. Configuration notes

Observed settings in the local `.config` included:

```text
CONFIG_CFG80211=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_WLAN=y
CONFIG_QCA_CLD_WLAN=y
CONFIG_HID=y
CONFIG_HIDRAW=y
CONFIG_HID_GENERIC=y
CONFIG_CNSS_UTILS=y
CONFIG_CNSS_GENL=y
```

`CONFIG_MAC80211`, `CONFIG_CNSS`, and `CONFIG_CNSS2` were not enabled in the inspected config. The Qualcomm WLAN driver profile sets `CONFIG_FEATURE_MONITOR_MODE_SUPPORT := y`.

Do not interpret these settings as proof that every NetHunter feature works. Runtime validation is still required.

## Reproducibility checklist

- [ ] Record host distribution and package versions.
- [ ] Record SHA-256 of the exact `.config`.
- [ ] Save the complete build log.
- [ ] Record `git rev-parse HEAD` and `git status --short`.
- [ ] Record toolchain checksums/versions.
- [ ] Rebuild from a clean output directory and compare artifacts.
