# playos-reference-devices

Operational hardware profiles and bring-up kits for PlayOS devices and SDK targets.

Device contracts are specified in [`playos-spec`](https://github.com/PlayOS-Foundation/playos-spec). This repository contains reproducible package sets, scripts, session launchers, profiles, and hardware validation checklists.

## Devices

| Device | Kind | Reference OS | Status | Kit |
|---|---|---|---|---|
| ASUS ROG Ally | Runtime Device | Alpine Linux-based PlayOS | Bring-up | [`rog-ally/`](rog-ally/README.md) |

## Policy

- Alpine is the host for the authoritative reference-OS bring-up path.
- Device profiles declare capabilities; scripts must not hard-code optional hardware.
- Retired distro-specific material belongs in Git history, not the active device kit.
- Bootable image construction belongs to `playos-refdistro`.
- Runtime and compositor behaviour belongs to `playos-runtime`.
- This repository owns device-specific integration and evidence.

## Layout

```text
rog-ally/
  packages.x86_64              Alpine package set
  setup.sh                     Alpine development-host preparation
  build.sh                     musl-native component build
  device-profile.toml          device profile
  session/
    playos-session.sh          direct TTY development launcher
  README.md                    bring-up and validation gates
```
