# Recovery and unbrick planning

No recovery/restore procedure has yet been validated for this project.

Before any flash attempt, document and verify:
- exact model and firmware;
- exact PIT partition names and sizes;
- matching stock AP/BL/CP/CSC firmware package;
- a working download-mode connection from the host;
- the restore command and expected result for each modified partition;
- a data backup;
- a clear abort/reboot procedure.

A TWRP archive for A71 was obtained during development, but successful installation on this exact Android 11 firmware has not been confirmed. Do not describe it as installed or working.

Never substitute partition names or flash an image to `VBMETA` / `VBMETA_SAMSUNG` based only on a tutorial for another Samsung model.
