# AVB / vbmeta investigation notes

**No vbmeta image in the local experiments is approved for flashing.**

The device PIT showed two distinct partitions: `VBMETA` and `VBMETA_SAMSUNG`. Their roles and expected contents must be established from authoritative device/firmware evidence before any write operation.

Two experimental files were inspected and rejected:
- `patched_vbmeta.img`: header inspection showed AVB flags were `0`, not the intended disable-verification state.
- `vbmeta_disabled.tar`: its contained 256-byte `vbmeta.img` also showed AVB flags `0`.

Do not flash either file. Do not infer a correct vbmeta image from the filename, size, or a generic AVB recipe.

Before proceeding, determine:
- the exact AVB version/metadata expected by this firmware;
- whether Samsung-specific signing or chained vbmeta metadata is involved;
- which partition(s) are read by this bootloader;
- whether the bootloader accepts modified boot/recovery images;
- the verified restore path.

Keep original `vbmeta.img` and `vbmeta_samsung.img` from the matching stock AP package backed up locally. Do not commit them.
