# ROG Ally — Alpine Netboot Bring-Up

This directory documents the Alpine Linux netboot (PXE) path for the ROG Ally.
The build system lives in `playos-refdistro`; these files are reference
documentation and netboot configuration.

## Architecture

```text
Build host (Ubuntu 24.04)         PXE server (192.168.0.196)
┌──────────────────────┐          ┌──────────────────────────┐
│ playos-refdistro/    │  build   │ /var/www/html/playos/    │
│   build-iso-ubuntu.sh├─────────►│   alpine-playos-*.iso    │
│   genapkovl-playos.sh│          │   playos.apkovl.tar.gz   │
└──────────────────────┘          │   vmlinuz-lts            │
                                  │   initramfs-lts          │
                                  │   modloop-lts            │
                                  └──────┬───────────────────┘
                                         │ PXE / TFTP
                                  ┌──────▼───────────────────┐
                                  │      ROG Ally            │
                                  │  Boots → DHCP → PXE →    │
                                  │  Compositor + Shell      │
                                  └──────────────────────────┘
```

## Build flow

```sh
cd playos-refdistro

# One-time: create Alpine nspawn rootfs with build deps
bash scripts/setup-ubuntu-build-host.sh

# Build the ISO (first run ~15 min, cached ~2 min)
bash scripts/build-iso-ubuntu.sh
```

The build script:
1. Builds `playos-platform-api`, `playos-runtime`, `playos-shell`, `playos-samples` in an Alpine nspawn
2. Installs compositor + shell binaries and OpenRC init into an apkovl overlay
3. Bundles pre-built samples (hello-playos, space-invaders)
4. Runs Alpine `mkimage.sh` to produce the ISO + apkovl

## GPU drivers

| Package | Purpose |
|---|---|
| `linux-firmware-amdgpu` | AMD GPU firmware (initramfs) |
| `mesa-dri-gallium` | Gallium3D DRI driver (radeonsi) |
| `mesa-vulkan-ati` | Vulkan driver (RADV) |
| `mesa-egl`, `mesa-gbm`, `mesa-gles` | EGL/GBM/GLES for wlroots + raylib |

## Kernel command line

```text
console=tty0 amdgpu.sg_display=0 loglevel=7 ip=dhcp
alpine_repo=http://192.168.0.196/playos/apks
modloop=http://192.168.0.196/playos/modloop-lts
apkovl=http://192.168.0.196/playos/playos.apkovl.tar.gz
softlevel=playos-visual
```

`amdgpu.sg_display=0` works around Display Core hangs on ROG Ally (Phoenix
APU / RDNA 3).

## Runlevels

| Runlevel | Services |
|---|---|
| `sysinit` | devfs, dmesg, udev, hwdrivers, modloop |
| `boot` | hwclock, modules, sysctl, hostname, bootmisc, syslog |
| `playos-visual` | dbus, seatd, playos-compositor, sshd |
| `shutdown` | killprocs, mount-ro, savecache |

## SSH debug access

SSH is enabled at the `playos-visual` runlevel with a pre-configured key:

```sh
ssh -i ~/.ssh/playos_debug root@<rog-ip>
```

The device gets an IP via DHCP on boot. Scan the network to find it:

```sh
for ip in 192.168.0.{100..250}; do
  ping -c1 -W1 "$ip" &>/dev/null && echo "$ip alive"
done
```

## Adding samples post-boot

```sh
scp -i ~/.ssh/playos_debug build/samples-out/* root@<ip>:/playos-samples/build/
```

## Known input mappings

| Control | Input device | evdev code |
|---|---|---|
| D-Pad | `/dev/input/event10` (js0) | `BTN_DPAD_UP/DOWN/LEFT/RIGHT` |
| A button | `/dev/input/event10` | `BTN_SOUTH` (304) |
| B button | `/dev/input/event10` | `BTN_EAST` (305) |
| Left stick | `/dev/input/event10` | `ABS_X`, `ABS_Y` |
| Right trigger | `/dev/input/event10` | `ABS_Z` |
| Xbox button | Separate event device | TBD |

The built-in controller appears as "Microsoft X-Box 360 pad" (vendor 045e,
product 028e) via the `xpad` kernel driver.
