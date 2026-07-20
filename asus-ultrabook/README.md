# ASUS Ultrabook — PlayOS Reference Bring-Up Kit

Bring-up kit for the **ASUS Ultrabook with NVIDIA dGPU**, a keyboard+mouse
reference device for PlayOS on discrete/hybrid graphics laptops.

## Bring-up path

PXE netboot via Alpine Linux (same flow as ROG Ally). No OS install needed.

```sh
cd playos-refdistro
bash scripts/setup-ubuntu-build-host.sh
bash scripts/build-iso-ubuntu.sh
```

## GPU support

| Package | Purpose |
|---|---|
| `linux-firmware-nvidia` | NVIDIA GPU firmware (loaded by nouveau) |
| `mesa-dri-gallium` | Gallium3D DRI driver (nouveau) |
| `mesa-vulkan-nouveau` | Vulkan driver (NVK) for NVIDIA GPUs |
| `mesa-vulkan-intel` | Vulkan driver for Intel iGPUs (hybrid graphics) |

The kernel's `nouveau` driver handles KMS/DRM for the NVIDIA GPU. Mesa
provides OpenGL 3.3+ and Vulkan 1.3+ via the NVK driver. On Optimus/hybrid
systems, the Intel iGPU is also supported via `mesa-vulkan-intel`.

## initramfs

NVIDIA firmware and nouveau module are bundled in the initramfs via mkinitfs
features:

```text
initfs_features: nvidia nvidia-firmware
modules: kernel/drivers/gpu/drm/nouveau
firmware: lib/firmware/nvidia
```

## Input

Keyboard and touchpad are the primary input devices. The compositor launches
the Raylib shell which is navigable with keyboard (arrow keys + Enter).

## Known limitations

- No controller input by default — use keyboard or connect external gamepad
- Brightness/Fn keys not yet mapped
- Multi-monitor not yet supported
- NVIDIA prime/render offload not yet configured

## Stage 1 definition of done

```text
[x] PXE netboot succeeds
[x] nouveau KMS initializes display
[x] Compositor takes display via DRM
[x] Raylib shell appears as Wayland client
[x] GPU: NVIDIA (nouveau) — not llvmpipe
[ ] Keyboard navigates shell
[ ] Samples launch and return to shell
[ ] Touchpad works
[ ] WiFi / networking active
```
