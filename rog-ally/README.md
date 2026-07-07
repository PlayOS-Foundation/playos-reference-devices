# ROG Ally — PlayOS Reference Bring-Up Kit

Turnkey setup for bringing up the PlayOS compositor + shell on the **ASUS ROG
Ally** (AMD Radeon 780M), the primary reference runtime device.

This kit implements the spec chapter
[`12-device-model-and-porting/12-rog-ally-reference.md`](https://github.com/PlayOS-Foundation/playos-spec/blob/main/book/src/12-device-model-and-porting/12-rog-ally-reference.md)
and the compositor bring-up guide in `playos-runtime/compositor/BRINGUP.md`.

## Prerequisites

- Arch Linux or CachyOS installed on the ROG Ally.
- The PlayOS repos checked out as siblings, e.g.:

  ```text
  ~/source/repos/playos/
    ├── playos-platform-api/
    ├── playos-runtime/
    ├── playos-shell/
    ├── playos-samples/
    └── playos-reference-devices/   (this repo)
  ```

## Files

| File | Purpose |
|---|---|
| `packages.x86_64` | Reference `pacman` package set |
| `setup.sh` | Install packages, enable seatd, add user to seat/video/input groups |
| `build.sh` | Build runtime (+compositor), shell, and sample in Release |
| `session/playos-session.sh` | Launch the compositor with the shell as its client |
| `session/playos-session.service` | Optional systemd **user** unit to autostart the session |
| `device-profile.toml` | Draft PlayOS device profile for the Ally |

## Quick start

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
[ ] setup.sh completes; seatd active; user in seat/video/input groups
[ ] build.sh builds compositor + shell + sample
[ ] compositor takes the display from a TTY
[ ] Raylib shell appears (as a Wayland client)
[ ] gamepad navigates the shell (evdev backend)
[ ] Armoury button -> Home (return-to-shell)
[ ] selecting "Hello PlayOS" launches it and returns to the shell
[ ] glxinfo shows AMD Radeon 780M (not llvmpipe)
```

## Notes / current limitations

- The compositor is a **Stage 1 skeleton** targeting wlroots 0.19. If your
  installed wlroots differs, adapt the `VERSION-SENSITIVE` calls (see the
  compositor `BRINGUP.md`).
- Controller input reaches the shell via the Platform API's **evdev** backend,
  so full Wayland input routing is not required for Stage 1.
- Touch, brightness/TDP/fan, suspend/resume, and audio are later stages.
