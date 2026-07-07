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
| ASUS ROG Ally | Runtime device (x86_64, AMD 780M) | Bring-up (Stage 1) | [`rog-ally/`](rog-ally/README.md) |

Each device folder provides the package set, setup/build scripts, a session
launcher, an optional systemd user unit, a draft device profile, and a
Stage 1 definition of done.

## Layout

```text
rog-ally/
  packages.x86_64            pacman package set
  setup.sh                   host setup (packages, seatd, groups)
  build.sh                   build runtime+compositor, shell, sample
  device-profile.toml        draft PlayOS device profile
  session/
    playos-session.sh        launch compositor + shell
    playos-session.service   optional systemd user unit
  README.md                  device bring-up guide + checklist
```

## License

Scripts/config will be released under an OSI-approved license (MIT/Apache-2.0).
