#!/usr/bin/env bash
set -euo pipefail

# --- colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info()  { echo -e "${CYAN}::${NC} $*"; }
ok()    { echo -e "${GREEN}::${NC} $*"; }
warn()  { echo -e "${YELLOW}::${NC} $*"; }
err()   { echo -e "${RED}::${NC} $*" >&2; }

# --- hosts (parallel arrays, bash 3 compat) ---
HOST_NAMES=(
  vm-nano
  vm-mini
  vm-full
  laptop
  server
  server-core
)
HOST_DESCS=(
  "minimal VM (base profile)"
  "medium VM (core profile)"
  "full VM (desktop profile)"
  "laptop (desktop profile)"
  "server (docker + caddy)"
  "server minimal (base profile)"
)

REPO="https://github.com/Hxmbl/astra.git"
DEST="$HOME/astra"

# --- helpers ---
get_desc() {
  local name="$1"
  for i in "${!HOST_NAMES[@]}"; do
    if [ "${HOST_NAMES[$i]}" = "$name" ]; then
      echo "${HOST_DESCS[$i]}"
      return
    fi
  done
}

is_valid_host() {
  local name="$1"
  for h in "${HOST_NAMES[@]}"; do
    [ "$h" = "$name" ] && return 0
  done
  return 1
}

# --- menu ---
pick_host() {
  echo -e "\n${BOLD}astra${NC} — which host?\n"
  for i in "${!HOST_NAMES[@]}"; do
    local num=$((i + 1))
    echo -e "  ${CYAN}${num})${NC} ${BOLD}${HOST_NAMES[$i]}${NC} — ${HOST_DESCS[$i]}"
  done
  echo ""
  read -rp "pick [1-${#HOST_NAMES[@]}]: " choice
  if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#HOST_NAMES[@]}" ]; then
    HOST="${HOST_NAMES[$((choice-1))]}"
  else
    err "invalid choice"
    exit 1
  fi
}

show_hosts() {
  echo "available hosts:"
  for i in "${!HOST_NAMES[@]}"; do
    printf "  %-14s %s\n" "${HOST_NAMES[$i]}" "${HOST_DESCS[$i]}"
  done
}

# --- arg parsing ---
HOST="${1:-}"

if [ -z "$HOST" ]; then
  pick_host
elif [ "$HOST" = "--help" ] || [ "$HOST" = "-h" ]; then
  echo "usage: install.sh [hostname]"
  echo ""
  show_hosts
  exit 0
fi

if ! is_valid_host "$HOST"; then
  err "unknown host: $HOST"
  echo ""
  show_hosts
  exit 1
fi

# --- checks ---
if ! command -v nix &>/dev/null; then
  err "nix not found. install it first:"
  echo "  sh <(curl -L https://nixos.org/nix/install) --daemon"
  exit 1
fi

if ! command -v git &>/dev/null; then
  err "git not found. install it first:"
  echo "  nix-env -iA nixpkgs.git"
  exit 1
fi

# --- clone ---
if [ ! -d "$DEST" ]; then
  info "cloning astra..."
  git clone "$REPO" "$DEST"
else
  info "astra already cloned at $DEST"
  cd "$DEST"
  info "pulling latest..."
  git pull --ff-only || warn "pull failed — using existing version"
fi

cd "$DEST"

# --- confirm ---
DESC="$(get_desc "$HOST")"
echo ""
echo -e "  host:    ${BOLD}${HOST}${NC}"
echo -e "  profile: ${BOLD}${DESC}${NC}"
echo -e "  repo:    ${DEST}"
echo ""
read -rp "  proceed? [Y/n] " confirm
if [[ "${confirm,,}" == "n" ]] || [[ "${confirm,,}" == "no" ]]; then
  info "aborted."
  exit 0
fi

# --- hardware config (laptop) ---
if [ "$HOST" = "laptop" ]; then
  info "generating hardware config..."
  nixos-generate-config --show-hardware-config > hosts/laptop/hardware-configuration.nix
  # uncomment the import
  if [[ "$(uname)" == "Darwin" ]]; then
    sed -i '' 's|# ./hardware-configuration.nix|./hardware-configuration.nix|' hosts/laptop/configuration.nix
    # remove the placeholder fileSystems block
    sed -i '' '/# PLACEHOLDER/,/};/d' hosts/laptop/configuration.nix
  else
    sed -i 's|# ./hardware-configuration.nix|./hardware-configuration.nix|' hosts/laptop/configuration.nix
    sed -i '/# PLACEHOLDER/,/};/d' hosts/laptop/configuration.nix
  fi
  ok "hardware config generated"
fi

# --- rebuild ---
info "rebuilding ${HOST}..."
sudo nixos-rebuild switch --flake ".#$HOST"

echo ""
ok "astra is live. welcome home."
