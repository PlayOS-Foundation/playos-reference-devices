---
name: Device Bring-Up Task
about: A scoped device bring-up or porting task.
title: "Device: "
labels: [implementation, agent-ready]
assignees: []
---

## Goal

<!-- One sentence: what should exist after this task (e.g. a new device kit). -->

## Source of truth (read first)

- `AGENTS.md`
- `.github/copilot-instructions.md`
- `playos-spec` Part XII (Device Model and Porting) and the device-profile schema

## Required output

<!-- Device folder contents: README, packages, scripts, device-profile.toml. -->

## Acceptance criteria

- [ ] Reproducible: package list + scripts (not machine-specific)
- [ ] Device profile declares capabilities per the schema
- [ ] Shell scripts are LF + executable
- [ ] Includes a Stage 1 "definition of done" checklist

## Constraints

- Follow this repository's `AGENTS.md`.
- Keep the change scoped to this task.
