# Kernel source and configuration

The kernel source is maintained upstream:

- Repository: https://github.com/ianmacd/a71
- Revision used: `270b258aba77c21eafeba837f266339482976f7e`
- Kernel version: `4.14.190`
- Defconfig: `sm7150_sec_a71_eur_open_caliban_defconfig`

The source tree is not copied into this repository. Clone the upstream project at the pinned revision and apply only reviewed patches from `kernel/patches/`.

Before publishing a patch:
- include its purpose and source;
- state which firmware/model it targets;
- include build results;
- avoid claiming runtime support without an on-device test.

The complete local `.config` has not yet been added. Review it for local paths, secrets, and reproducibility before committing it to `kernel/defconfig/`.
