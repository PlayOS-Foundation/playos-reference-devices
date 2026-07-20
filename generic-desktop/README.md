# Generic Desktop / VM — PlayOS Reference Bring-Up Kit

Baseline keyboard+mouse profile for desktop PCs, laptops, and VMs. No
controller, battery, or touch required.

## Bring-up path

PXE netboot via Alpine Linux (same flow as ROG Ally).

```sh
cd playos-refdistro
bash scripts/setup-ubuntu-build-host.sh
bash scripts/build-iso-ubuntu.sh
```

The multi-GPU ISO supports AMD (amdgpu), NVIDIA (nouveau), and Intel iGPUs
out of the box. No device-specific kernel parameters needed.

## GPU support

| GPU | Kernel driver | Mesa driver |
|---|---|---|
| AMD | amdgpu | radeonsi (GL), RADV (VK) |
| NVIDIA | nouveau | nouveau (GL), NVK (VK) |
| Intel | i915 | iris (GL), ANV (VK) |
| VM (virtio) | virtio-gpu | virgl (GL), venus (VK) |

## Input

Keyboard (arrow keys + Enter) navigates the shell. Mouse cursor is shown
if a mouse is connected. External gamepads are supported via evdev.

## Stage 1 definition of done

```text
[ ] PXE netboot succeeds on desktop/VM
[ ] GPU KMS initializes display
[ ] Compositor takes display via DRM
[ ] Raylib shell appears as Wayland client
[ ] Keyboard navigates shell
[ ] Samples launch and return to shell
[ ] No controller required
```
