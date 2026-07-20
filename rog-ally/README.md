# ROG Ally — PlayOS Reference Bring-Up Kit

Turnkey setup for bringing up the PlayOS compositor + shell on the **ASUS ROG
Ally** (AMD Radeon 780M), the primary reference runtime device.

This kit implements the spec chapter
[`12-device-model-and-porting/12-rog-ally-reference.md`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/book/src/12-device-model-and-porting/12-rog-ally-reference.md)
and the compositor bring-up guide in `playos-runtime/compositor/BRINGUP.md`.

## Two bring-up paths

| Path | OS | Use case |
|---|---|---|
| **Alpine netboot** (recommended) | Alpine Linux, PXE boot | Turnkey ISO build → PXE boot. No OS install needed. |
| **Arch native** | Arch Linux / CachyOS | Dev iteration on an installed OS. |

## Alpine netboot (recommended)

Builds a minimal Alpine ISO with the compositor, shell, samples, and GPU
drivers baked in. Boots directly into the PlayOS shell via PXE.

```sh
cd playos-refdistro

# One-time host setup (Ubuntu 24.04+)
bash scripts/setup-ubuntu-build-host.sh

# Build the ISO (~15 min first run, ~2 min subsequent with ccache)
bash scripts/build-iso-ubuntu.sh
```

The ISO is written to `out/alpine-playos-v3.24-x86_64.iso`. Deploy to a PXE
server or write to USB. Booting loads the apkovl overlay which auto-starts
the compositor + shell at the `playos-visual` runlevel.

See [`alpine/README.md`](alpine/README.md) for details on the netboot
configuration and SSH debug access.

## Files

| File | Purpose |
|---|---|
| `packages.x86_64` | Reference `pacman` package set (Arch native path) |
| `setup.sh` | Install packages, enable seatd, add user to seat/video/input groups (Arch native) |
| `build.sh` | Build runtime (+compositor), shell, and sample in Release (Arch native) |
| `session/playos-session.sh` | Launch the compositor with the shell as its client |
| `session/playos-session.service` | Optional systemd **user** unit to autostart the session |
| `device-profile.toml` | Draft PlayOS device profile for the Ally |
| `alpine/` | Alpine netboot build documentation and configs |

## Quick start (Arch native)

```sh
cd playos-reference-devices/rog-ally

# 1) One-time host setup (installs packages, seatd, groups). Re-login after.
./setup.sh

# 2) Build the components.
./build.sh

# 3) From a TTY (Ctrl+Alt+F3), launch the session.
./session/playos-session.sh
```

## Optional: autostart as a user service

```sh
mkdir -p ~/.config/systemd/user
cp session/playos-session.service ~/.config/systemd/user/
# Edit ExecStart in the copy if your workspace path differs.
systemctl --user daemon-reload
systemctl --user enable --now playos-session.service
```

## Verify GPU acceleration

```sh
glxinfo | grep renderer     # expect: AMD Radeon 780M  (NOT llvmpipe)
```

If it shows `llvmpipe`, the GPU driver stack is misconfigured (software
rendering) — check `mesa` / `vulkan-radeon` and that you are on a TTY the
compositor can take.

## Stage 1 definition of done

```text
[x] setup.sh completes; seatd active; user in seat/video/input groups
[x] build.sh builds compositor + shell + sample
[x] compositor takes the display from a TTY
[x] Raylib shell appears (as a Wayland client)
[x] gamepad navigates the shell (evdev + raylib backend)
[x] D-Pad and analog stick work (15% deadzone)
[ ] Armoury button -> Home (return-to-shell)
[x] selecting "Hello PlayOS" launches it and returns to the shell
[x] GPU: AMD Radeon 780M (not llvmpipe)
[x] Samples pre-loaded on boot (hello-playos, space-invaders)
```

## Known input mappings (Xbox 360 pad, xpad driver)

| Control | evdev code | Notes |
|---|---|---|
| A button | `BTN_SOUTH` (304) | Select/confirm |
| B button | `BTN_EAST` (305) | Back |
| D-Pad | `BTN_DPAD_UP/DOWN/LEFT/RIGHT` | Navigation |
| Left stick | `ABS_X`, `ABS_Y` | Movement |
| Right trigger | `ABS_Z` | Shoot (Space Invaders) |
| Xbox button | `/dev/input/event*` (separate device) | Mapped to Home |

## Notes / current limitations

- The compositor is a **Stage 1 skeleton** targeting wlroots 0.19. If your
  installed wlroots differs, adapt the `VERSION-SENSITIVE` calls (see the
  compositor `BRINGUP.md`).
- Controller input reaches the shell via the Platform API's **evdev** backend,
  so full Wayland input routing is not required for Stage 1.
- Touch, brightness/TDP/fan, suspend/resume, and audio are later stages.
