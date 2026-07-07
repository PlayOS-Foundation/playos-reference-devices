#!/usr/bin/env bash
# playos-session.sh — launch the PlayOS compositor with the shell as its client.
#
# Run this from a TTY (Ctrl+Alt+F3), not from inside an existing graphical
# session, so the compositor can take DRM/KMS.
#
# Environment overrides:
#   PLAYOS_ROOT           Path to the parent folder holding the playos-* repos
#                         (default: two levels up from this script's repo).
#   PLAYOS_COMPOSITOR     Path to the playos-compositor binary.
#   PLAYOS_SHELL          Path to the playos-shell binary.
set -euo pipefail

# Resolve the workspace root (folder that contains playos-runtime, playos-shell, ...).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PLAYOS_ROOT="${PLAYOS_ROOT:-$DEFAULT_ROOT}"

PLAYOS_COMPOSITOR="${PLAYOS_COMPOSITOR:-$PLAYOS_ROOT/playos-runtime/build/compositor/playos-compositor}"
PLAYOS_SHELL="${PLAYOS_SHELL:-$PLAYOS_ROOT/playos-shell/build/playos-shell}"

if [[ ! -x "$PLAYOS_COMPOSITOR" ]]; then
    echo "error: compositor not found or not executable: $PLAYOS_COMPOSITOR" >&2
    echo "       build it: cmake -B build -G Ninja -DPLAYOS_BUILD_COMPOSITOR=ON && cmake --build build" >&2
    exit 1
fi
if [[ ! -x "$PLAYOS_SHELL" ]]; then
    echo "error: shell not found or not executable: $PLAYOS_SHELL" >&2
    echo "       build it in playos-shell: cmake -B build -G Ninja && cmake --build build" >&2
    exit 1
fi

# Ensure a runtime dir exists for the Wayland socket.
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
mkdir -p "$XDG_RUNTIME_DIR"

echo "PlayOS: launching compositor ($PLAYOS_COMPOSITOR)"
echo "PlayOS: shell command       ($PLAYOS_SHELL)"

# The compositor takes the shell command as its first argument and spawns it
# once the Wayland socket is up.
exec "$PLAYOS_COMPOSITOR" "$PLAYOS_SHELL"
