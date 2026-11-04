# Compatibility status

**Overall status: experimental; device boot not verified.**

| Component / feature | Current evidence | Status |
|---|---|---|
| Kernel compilation | Build completed for ARM64, kernel version 4.14.190 | <span>Built</span> |
| Boot image packaging | New kernel inserted; original ramdisk and DTB preserved | Packaging verified only |
| Exact board/DTB match | Source DTB identifies Qualcomm SDMMAGPIE; exact SM-A715F board match not proven | Unknown |
| AVB / vbmeta | Experimental generated files inspected and found unsuitable | Not resolved |
| Samsung boot chain | No validated flashing/boot procedure | Not verified |
| TWRP | A71 recovery archive was obtained, but no successful installation confirmed | Not verified |
| Magisk | APK available locally; no successful root installation confirmed | Not verified |
| NetHunter userspace | Generic minimal package obtained; full installation not completed | Not installed |
| Qualcomm WLAN monitor mode | Driver profile contains monitor-mode build setting | Runtime unverified |
| Packet injection | No on-device test result | Unverified |
| USB HID | HID-related config options enabled | Runtime unverified |
| External USB Wi-Fi | Several USB networking drivers enabled | Adapter-specific/runtime unverified |

## Interpretation

A successful kernel compile means the source compiled with the selected configuration and toolchain. It does not establish that the kernel can boot on this exact phone.

A successful MagiskBoot repack/unpack round trip means the image container can be parsed and that the expected kernel, ramdisk, and DTB payloads were present after repacking. It does not validate Samsung signature requirements, AVB state, bootloader acceptance, or device compatibility.

Do not publish or distribute the current test image as a working NetHunter kernel.
