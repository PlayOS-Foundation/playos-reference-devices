# AGENTS.md — playos-reference-devices

Guidance for AI agents and contributors working in this repository.

## What this repository is

Operational bring-up material (package sets, setup/build scripts, session
launchers, device profiles) for real PlayOS hardware and SDK targets. Device
model *contracts* live in `playos-spec` (Part XII); this repo implements the
practical steps to run PlayOS on specific devices.

## Golden rules

1. **Spec first.** The device-profile format and porting model are defined in
   `playos-spec`. Keep profiles here consistent with that schema (RFC-0006).
2. **One folder per device.** Each supported device gets its own directory with
   a README, package set, scripts, and a device profile.
3. **Reproducible, not machine-specific.** Prefer package lists + scripts over
   "it works on my Ally" notes. Capture exact package/config sets.
4. **Capabilities, not assumptions.** Device profiles declare capabilities; do
   not assume a device has battery, touch, brightness, etc.
5. **Keep secrets out.** No credentials, no personal paths hard-coded where a
   variable will do.

## Adding a device

1. Create `<device>/` with: `README.md`, `packages.*`, `setup.sh`,
   `build.sh`, `device-profile.toml`, and a `session/` launcher.
2. Add a row to the device table in the repo `README.md`.
3. Include a Stage 1 "definition of done" checklist.
