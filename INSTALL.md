# Installation status and safety checklist

There is currently **no validated installation procedure** for this device/build. This document is a checklist, not a flashing guide.

## Before any future installation attempt

- [ ] Confirm exact model is `SM-A715F` (not a different A71 variant).
- [ ] Confirm exact firmware build and bootloader revision.
- [ ] Back up all user data.
- [ ] Keep a verified, matching stock firmware package and recovery path available locally.
- [ ] Confirm the correct partition map from the device's own PIT.
- [ ] Establish the exact AVB/vbmeta requirements for this firmware.
- [ ] Verify recovery compatibility with Android 11 and this bootloader revision.
- [ ] Review every image and target partition before flashing.
- [ ] Have a tested restore method before modifying boot/recovery partitions.

## Current state

No custom boot image, recovery image, or vbmeta image from this project is approved for flashing.

The experimental `boot-nethunter-test.img` was only checked for correct repackaging. The generated vbmeta experiments were not valid disable-verification images and must not be used.

## Recovery planning

A future installation guide must include:
1. Exact image provenance and SHA-256.
2. Exact partition names and flashing commands for the selected, verified tool.
3. Expected device screen/mode at each stage.
4. A safe abort procedure.
5. A stock restore procedure tested on the same model and firmware.

Do not improvise partition names or substitute `VBMETA` and `VBMETA_SAMSUNG`.
