#!/usr/bin/env bash
# setup.sh — one-time host preparation for the PlayOS ROG Ally reference.
# Installs packages, enables seatd, and adds the current user to the required
# groups. Re-login (or reboot) afterwards for group changes to take effect.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages"
sudo pacman -S --needed - < "$SCRIPT_DIR/packages.x86_64"

echo "==> Enabling seatd"
sudo systemctl enable --now seatd

echo "==> Adding $USER to seat, video, input groups"
sudo usermod -aG seat,video,input "$USER"

echo "==> Enabling NetworkManager"
sudo systemctl enable --now NetworkManager || true

cat <<'EOF'

Done. Log out and back in (or reboot) so group membership applies.

Next:
  1. Build the components:   ./build.sh
  2. From a TTY (Ctrl+Alt+F3), run:  ./session/playos-session.sh
  3. Verify GPU:             glxinfo | grep renderer   # expect AMD Radeon 780M
EOF
