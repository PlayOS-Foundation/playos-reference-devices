#!/usr/bin/env bash
# build.sh — build the PlayOS components needed for the ROG Ally slice:
# the runtime (with the wlroots compositor) and the shell. Assumes the
# playos-* repos are checked out as siblings under PLAYOS_ROOT.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYOS_ROOT="${PLAYOS_ROOT:-$(cd "$SCRIPT_DIR/../.." && pwd)}"

echo "==> Building playos-runtime (with compositor)"
cmake -S "$PLAYOS_ROOT/playos-runtime" -B "$PLAYOS_ROOT/playos-runtime/build" \
      -G Ninja -DCMAKE_BUILD_TYPE=Release -DPLAYOS_BUILD_COMPOSITOR=ON
cmake --build "$PLAYOS_ROOT/playos-runtime/build"

echo "==> Building playos-shell"
cmake -S "$PLAYOS_ROOT/playos-shell" -B "$PLAYOS_ROOT/playos-shell/build" \
      -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build "$PLAYOS_ROOT/playos-shell/build"

echo "==> Building playos-samples (hello-playos)"
cmake -S "$PLAYOS_ROOT/playos-samples" -B "$PLAYOS_ROOT/playos-samples/build" \
      -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build "$PLAYOS_ROOT/playos-samples/build"

echo "==> Done. Launch with: ./session/playos-session.sh"
