#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-}"

if [ -z "$HOST" ]; then
  echo "usage: install.sh <hostname>"
  echo ""
  echo "hosts:"
  echo "  vm-nano    minimal VM (base profile)"
  echo "  vm-mini    medium VM (core profile)"
  echo "  vm-full    full VM (desktop profile)"
  echo "  laptop     laptop (desktop profile)"
  exit 1
fi

REPO="https://github.com/Hxmbl/astra.git"
DEST="$HOME/astra"

if [ ! -d "$DEST" ]; then
  echo "cloning astra..."
  git clone "$REPO" "$DEST"
fi

cd "$DEST"

if [ "$HOST" = "laptop" ]; then
  echo "generating hardware config..."
  nixos-generate-config --show-hardware-config > hosts/laptop/hardware-configuration.nix
  sed -i 's|# imports = \[ ./hardware-configuration.nix \];|imports = [ ./hardware-configuration.nix ];|' hosts/laptop/configuration.nix
fi

echo "rebuilding $HOST..."
sudo nixos-rebuild switch --flake ".#$HOST"

echo ""
echo "done. astra is live."
