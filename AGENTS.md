# AGENTS.md — playos-reference-devices

## Purpose

This repository contains operational hardware bring-up material. The device model is specified in `playos-spec`.

## Rules

1. **Spec first.** Follow device schemas and ADR-0004.
2. **Alpine reference path.** New Runtime Device instructions use Alpine, apk, musl, and OpenRC.
3. **Keep the image elsewhere.** ISO, APK repository, initramfs, and boot policy belong in `playos-refdistro`.
4. **One device folder per device.**
5. **Capabilities, not assumptions.** Declare touch, battery, brightness, vendor buttons, refresh modes, and other features.
6. **Reproducible evidence.** Record kernel, Mesa, firmware, wlroots, image digest, and results.
7. **Keep the kit current.** Retired distro-specific files remain recoverable from Git history; the active tree contains only supported device integration.
8. **No secrets or personal paths.**

## Device checklist

Each Runtime Device should provide:

- `README.md`;
- Alpine package inventory;
- setup and build scripts;
- device profile;
- direct session launcher;
- vertical-slice and extended validation gates.
