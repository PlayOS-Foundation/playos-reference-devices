# PlayOS Reference Devices — Roadmap

Device bring-up tracking for `playos-reference-devices`, the repository
of per-device profiles, setup scripts, and porting kits.

Each device has its own subdirectory with:
- `device-profile.toml` — per RFC-0006
- `setup.sh` / `build.sh` — bring-up automation
- `session/` — compositor + shell launch scripts
- `README.md` — bring-up guide and Stage 1 checklist

---

## ✅ ROG Ally (primary reference)

**Status:** Stage 1 bring-up in progress
**Spec:** [`12-device-model-and-porting/12-rog-ally-reference.md`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/book/src/12-device-model-and-porting/12-rog-ally-reference.md)

| Item | Status |
|---|---|
| `setup.sh` — packages, seatd, groups | ✅ |
| `build.sh` — compositor + shell + samples | ✅ |
| Compositor takes display from TTY | ✅ |
| Raylib shell appears as Wayland client | ✅ |
| Gamepad navigates shell (D-Pad, A, B) | ✅ |
| Armoury button → Home | ⬜ blocked on evtest |
| Launch Hello PlayOS → return to shell | ⬜ |
| GPU: AMD Radeon 780M (not llvmpipe) | ⬜ verify |

### Device profile
- [ ] Finalize `device-profile.toml` with real evdev codes from `evtest`
- [ ] Profile deployed to ISO at `/etc/playos/device-profiles/rog-ally.toml`

### Hardware quirks
- [ ] Armoury button evdev code (may be on separate input device from gamepad)
- [ ] Command Center button mapping → QuickSettings
- [ ] Touchscreen calibration
- [ ] Built-in controller gyro (future)

---

## 📋 Planned — Steam Deck

- [ ] `device-profile.toml` (LCD + OLED variants)
- [ ] `setup.sh` / `build.sh` (Arch-based, similar to Ally)
- [ ] Steam Deck QAM (…) button → Home mapping
- [ ] Trackpad input support (future Platform API)

---

## 📋 Planned — Legion Go

- [ ] `device-profile.toml`
- [ ] Detachable controller / FPS mode quirks
- [ ] Legion Space button → Home mapping

---

## 📋 Planned — Generic / Desktop

- [ ] `device-profile.toml` for desktop PCs, laptops, VMs
- [ ] Keyboard-only mode (no controller required)
- [ ] Multiple monitor support (future)

---

## Architecture reference

Per-device profiles follow RFC-0006:
[`rfcs/0006-device-profile-format.md`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/rfcs/0006-device-profile-format.md)

Schema: [`schemas/device-profile.schema.json`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/schemas/device-profile.schema.json)
