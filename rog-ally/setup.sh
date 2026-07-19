#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v apk >/dev/null 2>&1; then
    echo "error: this setup script targets Alpine Linux" >&2
    echo "The former Arch package list is packages.arch-legacy.x86_64." >&2
    exit 1
fi

mapfile -t packages < <(sed -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' "$SCRIPT_DIR/packages.x86_64")

echo "==> Installing Alpine packages"
sudo apk add "${packages[@]}"

echo "==> Enabling device and seat services"
sudo rc-update add udev sysinit
sudo rc-update add udev-trigger sysinit
sudo rc-update add dbus boot
sudo rc-update add seatd default
sudo rc-service dbus start || true
sudo rc-service seatd start

echo "==> Adding $USER to seat, video, input, and audio groups"
for group in seat video input audio; do
    if getent group "$group" >/dev/null 2>&1; then
        sudo addgroup "$USER" "$group" || true
    fi
done

echo "==> Enabling background connectivity for development-host bring-up"
sudo rc-update add networkmanager default || true
sudo rc-service networkmanager start || true

cat <<'EOF'

Alpine ROG Ally host preparation is complete.

Log out and back in so group membership applies. Then:
  ./build.sh
  ./session/playos-session.sh   # from a TTY

The bootable reference image must still be validated from playos-refdistro.
EOF
