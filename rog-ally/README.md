# ROG Ally — Alpine PlayOS Bring-Up Kit

The ASUS ROG Ally is the primary PlayOS Runtime Device and the first hardware target for the Alpine reference OS.

The authoritative path is to boot an image from [`playos-refdistro`](https://github.com/PlayOS-Foundation/playos-refdistro). This kit also supports a faster development loop on Alpine installed directly on the device.

## Two bring-up paths

- Alpine Linux 3.24 x86_64 on the Ally for development-host bring-up, or a PlayOS Alpine image.
- Community repository enabled.
- The PlayOS repositories checked out as siblings.
- A TTY outside another graphical session for direct DRM/KMS testing.

## Files

| File | Purpose |
|---|---|
| `packages.x86_64` | Alpine runtime and build dependencies |
| `setup.sh` | Install APKs, enable seatd, and configure groups |
| `build.sh` | Build compositor, shell, and samples against musl |
| `session/playos-session.sh` | Direct development launcher |
| `device-profile.toml` | ROG Ally device profile |
| `alpine/` | Alpine netboot build documentation and configs |

## Quick start (Alpine native)

```sh
cd playos-reference-devices/rog-ally
./setup.sh
# Log out/in after group changes.
./build.sh
# From a TTY:
./session/playos-session.sh
```

## USB Gadget Serial Console (REMOVED)

The `playos-usb-gadget` service and `g_serial` kernel module support has been
removed from the build. The ROG Ally's USB-C port is host-only — no
device-mode/UDC — so `g_serial` never produced `ttyGS0` and the host never
enumerated anything. It was dead code on this hardware.

For debugging, use SSH over WiFi (`root@<ip>`, key at `~/.ssh/id_ed25519`)
or attach a USB keyboard + external display via dock.

## Verify the graphics path

```sh
readlink -f /sys/class/drm/card0/device/driver
cat /sys/kernel/debug/dri/0/name 2>/dev/null || true
```
