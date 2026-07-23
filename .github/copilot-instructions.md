> **⚠️ FIRST:** Read [`gen-context.md`](../gen-context.md) before anything else to understand the full PlayOS platform context.
# Copilot instructions — playos-reference-devices

Operational bring-up material for PlayOS hardware and SDK targets (package
sets, setup/build scripts, session launchers, device profiles). Device model
contracts live in
[`playos-spec`](https://github.com/PlayOS-Foundation/playos-spec) (Part XII).
Also read `AGENTS.md`.

## Rules for changes here

1. **Spec first** — device-profile format follows `playos-spec` (RFC-0006).
2. **One folder per device** with README, packages, scripts, and a profile.
3. **Reproducible** — package lists + scripts, not machine-specific notes.
4. **Capabilities, not assumptions** — profiles declare what hardware provides.
5. **No secrets / no hard-coded personal paths** where a variable will do.
6. **Shell scripts use LF** and stay executable (see `.gitattributes`).
