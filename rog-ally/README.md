# ROG Ally — Alpine PlayOS Bring-Up Kit

The ASUS ROG Ally is the primary PlayOS Runtime Device and the first hardware target for the Alpine reference OS.

The authoritative path is to boot an image from [`playos-refdistro`](https://github.com/PlayOS-Foundation/playos-refdistro). This kit also supports a faster development loop on Alpine installed directly on the device.

## Prerequisites

- Alpine Linux 3.24 x86_64 on the Ally for development-host bring-up, or a PlayOS Alpine image.
- Community repository enabled.
- The PlayOS repositories checked out as siblings.
- A TTY outside another graphical session for direct DRM/KMS testing.

## Files

| File | Purpose |
|---|---|
| `packages.x86_64` | Alpine runtime and build dependencies |
| `packages.arch-legacy.x86_64` | Historical Arch/CachyOS inventory |
| `setup.sh` | Install APKs, enable seatd, and configure groups |
| `build.sh` | Build compositor, shell, and samples against musl |
| `session/playos-session.sh` | Direct development launcher |
| `session/playos-session.service` | Legacy systemd example; not used by Alpine |
| `device-profile.toml` | ROG Ally device profile |

## Quick start

```sh
cd playos-reference-devices/rog-ally
./setup.sh
# Log out/in after group changes.
./build.sh
# From a TTY:
./session/playos-session.sh
```

## Verify the graphics path

```sh
readlink -f /sys/class/drm/card0/device/driver
cat /sys/kernel/debug/dri/0/name 2>/dev/null || true
```

Compositor logs must show the amdgpu DRM node and hardware EGL/GLES rendering. Pixman is acceptable only for virtual bring-up.

## Alpine vertical slice

```text
[ ] Alpine image boots through UEFI
[ ] amdgpu firmware loads
[ ] seatd is active and grants non-root access
[ ] runtime, compositor, shell, and samples build against musl
[ ] compositor owns DRM/KMS from a TTY
[ ] shell renders as a Wayland client
[ ] built-in controller navigates
[ ] Armoury/Home returns to the shell
[ ] touch maps to the internal panel
[ ] 60 Hz and 120 Hz modes are detected
[ ] a sample launches and returns
[ ] first-frame timing is recorded
```

## Extended gates

- controller and dock hotplug;
- audio;
- Wi-Fi and Bluetooth;
- brightness and battery;
- suspend/resume;
- external display;
- persistent data;
- recovery and image update.

The old Arch/CachyOS path is retained only for comparison during migration.
