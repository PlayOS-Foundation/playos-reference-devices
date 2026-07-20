# playos-reference-devices

Reference implementations, hardware profiles, platform backends, and bring-up
guides for supported PlayOS devices and SDK targets.

Device profiles and porting contracts are specified in
[`playos-spec`](https://github.com/PlayOS-Foundation/playos-spec) (Part XII,
Device Model and Porting). This repository holds the **operational** bring-up
material for real hardware.

## Devices

| Device | Kind | Status | Kit |
|---|---|---|---|
| ASUS ROG Ally | Runtime device (x86_64, AMD 780M) | Stage 1 ✅ | [`rog-ally/`](rog-ally/README.md) |
| ASUS Ultrabook | Runtime device (x86_64, NVIDIA dGPU) | Stage 1 bring-up | [`asus-ultrabook/`](asus-ultrabook/README.md) |
| Generic Desktop | Desktop / VM (x86_64, any GPU) | Planned | [`generic-desktop/`](generic-desktop/README.md) |

Each device folder provides the package set, setup/build scripts, a session
launcher, an optional systemd user unit, a draft device profile, and a
Stage 1 definition of done.

## Layout

```text
rog-ally/
  alpine/                    Alpine netboot documentation
  packages.x86_64            pacman package set
  setup.sh                   host setup (packages, seatd, groups)
  build.sh                   build runtime+compositor, shell, sample
  device-profile.toml        PlayOS device profile (ROG Ally)
  session/
    playos-session.sh        launch compositor + shell
    playos-session.service   optional systemd user unit
  README.md                  device bring-up guide + checklist
asus-ultrabook/
  device-profile.toml        PlayOS device profile (NVIDIA laptop)
  README.md                  device bring-up guide + checklist
generic-desktop/
  device-profile.toml        PlayOS device profile (keyboard+mouse)
  README.md                  device bring-up guide + checklist
```

## License

Scripts/config will be released under an OSI-approved license (MIT/Apache-2.0).
