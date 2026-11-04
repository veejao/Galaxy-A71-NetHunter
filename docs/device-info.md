# Device and firmware notes

## Target

- Device: Samsung Galaxy A71
- Model: `SM-A715F`
- Android: 11
- One UI: 3.1
- Firmware archive observed: `SAMFW.COM_SM-A715F_TPL_A715FXXU8BVA2_fac.zip`
- Firmware build: `A715FXXU8BVA2`
- Security patch level reported by the boot image: January 2022

## Download Mode observations

Recorded observations included:
- `OEM LOCK: OFF (U)`
- `KG STATUS: CHECKING`
- `SECURE BOOT: ENABLE`
- `WARRANTY VOID: 0x0`

These are observations from one device/session and may change. Re-check the actual device before any operation.

## PIT notes

The device PIT showed separate partitions named:
- `VBMETA`
- `VBMETA_SAMSUNG`

These are distinct partitions. Never assume they accept the same image or flash a guessed image to either partition.

## Extracted stock AP components

The following were extracted locally for analysis. They are not included in this repository:

- `boot.img`
- `recovery.img`
- `vbmeta.img`
- `vbmeta_samsung.img`
- `dtbo.img`

Keep stock firmware components private and use only matching firmware files for recovery.
