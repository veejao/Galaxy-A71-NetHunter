# Galaxy-A71-NetHunter

**Maintainer:** `veejao`  
**Device:** Samsung Galaxy A71 (`SM-A715F`)  
**Target firmware:** Android 11 / One UI 3.1 — `A715FXXU8BVA2` (TPL, January 2022 patch)  
**Status:** Experimental research / bring-up

> [!WARNING]
> **NOT READY TO FLASH.** The custom kernel has compiled and has been packaged into a test boot image, but the image has not been demonstrated to boot on the target phone. AVB/vbmeta handling, Samsung boot-chain requirements, exact DTB/board matching, and on-device hardware functionality remain unresolved. Do not flash artifacts from this repository unless you understand the risks and have a tested recovery path.

This repository records the work toward running **Kali NetHunter Full** on the Samsung Galaxy A71 SM-A715F while retaining the Android 11 base. It is currently a reproducible build/research log, not a ready-made installer.

## Current progress

- [x] Identified target device and Android 11 firmware package.
- [x] Extracted stock AP components for local analysis.
- [x] Cloned the A71 kernel source and pinned the upstream revision.
- [x] Configured and built the 4.14.190 kernel with the documented external toolchain.
- [x] Confirmed the kernel build produced an ARM64 image.
- [x] Repacked a test boot image using the newly built kernel and original ramdisk/DTB.
- [x] Unpacked the test image again and verified that kernel, ramdisk, and DTB match the intended inputs.
- [ ] Prove that the source DTB and kernel are correct for this exact SM-A715F firmware/board.
- [ ] Resolve and validate AVB/vbmeta and Samsung boot-chain requirements.
- [ ] Validate recovery installation and a safe restore procedure.
- [ ] Boot the test image on-device.
- [ ] Verify NetHunter kernel features on-device (USB HID, external Wi-Fi adapters, monitor mode, packet injection, etc.).
- [ ] Install and validate the full NetHunter userspace.

## Hardware and software target

| Item | Value |
|---|---|
| Phone | Samsung Galaxy A71 |
| Model | SM-A715F |
| Android | 11 / One UI 3.1 |
| Firmware build | A715FXXU8BVA2 |
| Kernel source version | 4.14.190 |
| Source repository | [ianmacd/a71](https://github.com/ianmacd/a71) |
| Source revision | `270b258aba77c21eafeba837f266339482976f7e` |
| Build config | `sm7150_sec_a71_eur_open_caliban_defconfig` |
| Host OS | Kali Linux |
| Compiler used | Clang 6.0.1 + Android NDK r17c GCC toolchain |
| Local GNU Make | 4.3 |

## Important technical findings

- The kernel build completed and produced `arch/arm64/boot/Image`.
- The kernel config includes `CONFIG_QCA_CLD_WLAN=y`, `CONFIG_HID=y`, `CONFIG_HIDRAW=y`, and several USB networking drivers.
- The Qualcomm WLAN driver profile's `configs/default_defconfig` sets `CONFIG_FEATURE_MONITOR_MODE_SUPPORT := y`. This is a build-time setting only; it does **not** prove monitor mode or packet injection works on the phone.
- The repacked test image preserves the original ramdisk and DTB byte-for-byte, and contains the newly built kernel. This verifies packaging, **not bootability**.
- AVB test files created during experimentation were found to be unsuitable for disabling verification. They are intentionally not included.

See [COMPATIBILITY.md](COMPATIBILITY.md), [BUILD.md](BUILD.md), and [docs/build-log.md](docs/build-log.md).

## Repository contents

- `kernel/` — source revision, config notes, and a place for reviewed patches.
- `tools/` — local build, repack, and verification helpers.
- `docs/` — device details, build record, AVB notes, and recovery checklist.
- `checksums/` — checksums for locally generated artifacts (when added by the maintainer).

The full kernel source is not vendored here. Use the pinned upstream revision and comply with its license when building or redistributing modified binaries.

## Safety and distribution policy

Do not commit:
- Samsung stock firmware archives or extracted proprietary firmware images (`boot.img`, `recovery.img`, `vbmeta*.img`, `dtbo.img`, vendor firmware/blobs).
- Private keys, account data, device identifiers, or personal logs.
- Magisk APKs, TWRP binaries, or NetHunter ZIPs unless their redistribution terms explicitly permit it.
- A boot/recovery image labelled as ready-to-flash before it has been tested and the installation/restore procedure has been validated.

Prefer documenting exact versions and linking to official project pages.

## Disclaimer

This is an independent community research project. It is not affiliated with or endorsed by Samsung, Kali Linux, Offensive Security, Magisk, or the upstream kernel maintainer. Flashing experimental software can brick a device, erase data, or trip device security mechanisms. You are responsible for backups and for understanding every command before running it.
