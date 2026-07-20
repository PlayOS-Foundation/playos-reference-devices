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

**Status:** Stage 1 core verified
**Spec:** [`12-device-model-and-porting/12-rog-ally-reference.md`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/book/src/12-device-model-and-porting/12-rog-ally-reference.md)

| Item | Status |
|---|---|
| `setup.sh` — packages, seatd, groups | ✅ |
| `build.sh` — compositor + shell + samples | ✅ |
| Alpine netboot ISO build (`playos-refdistro`) | ✅ |
| Compositor takes display from TTY | ✅ |
| Raylib shell appears as Wayland client | ✅ |
| Gamepad navigates shell (D-Pad, A, B) | ✅ |
| Analog stick movement (15% deadzone) | ✅ |
| Samples pre-loaded on boot | ✅ |
| GPU: AMD Radeon 780M (not llvmpipe) | ✅ |
| Armoury button → Home | ⬜ blocked on evtest |
| Launch Hello PlayOS → return to shell | ✅ |

### Device profile
- [x] `device-profile.toml` with real evdev codes from xpad driver
- [ ] Profile deployed to ISO at `/etc/playos/device-profiles/rog-ally.toml`

### Hardware quirks
- [ ] Armoury button evdev code (may be on separate input device from gamepad)
- [ ] Command Center button mapping → QuickSettings
- [ ] Touchscreen calibration
- [ ] Built-in controller gyro (future)

---

---

## ✅ ASUS Ultrabook (NVIDIA reference)

**Status:** Stage 1 bring-up in progress
**Spec:** `device-profile.toml` in `asus-ultrabook/`

| Item | Status |
|---|---|
| Alpine netboot ISO with NVIDIA firmware | ✅ |
| PXE boot succeeds | ✅ |
| nouveau KMS initializes display | ✅ |
| Compositor takes display via DRM | ✅ |
| Raylib shell appears | ✅ |
| Keyboard navigates shell | ⬜ |
| Samples launch and return | ⬜ |
| GPU: NVIDIA (nouveau) — not llvmpipe | ⬜ verify |

---

## 📋 Generic Desktop / VM

**Status:** Planned — profile created, untested

| Item | Status |
|---|---|
| `device-profile.toml` | ✅ |
| Keyboard-only mode (no controller) | ⬜ |
| Multi-GPU (AMD/NVIDIA/Intel/virtio) | ✅ build support |


---

## Architecture reference

Per-device profiles follow RFC-0006:
[`rfcs/0006-device-profile-format.md`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/rfcs/0006-device-profile-format.md)

Schema: [`schemas/device-profile.schema.json`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/schemas/device-profile.schema.json)
