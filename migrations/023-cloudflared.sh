#!/usr/bin/env bash
# migrations/023-cloudflared.sh
# Installs cloudflared for Cloudflare Tunnel and DNS

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing cloudflared..."

# Install cloudflared from AUR
# Note: This requires an AUR helper (yay/paru) to be installed
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm cloudflared
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm cloudflared
else
    log_error "AUR helper (yay or paru) not found. Please install one first."
    exit 1
fi

log_success "cloudflared installed"
log_info "Use 'cloudflared tunnel' to create and manage Cloudflare Tunnels"
