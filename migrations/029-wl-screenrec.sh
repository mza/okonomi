#!/usr/bin/env bash
# migrations/029-wl-screenrec.sh
# Installs wl-screenrec

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing wl-screenrec..."

# Install wl-screenrec from AUR
# Note: This requires an AUR helper (yay/paru) to be installed
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm wl-screenrec
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm wl-screenrec
else
    log_error "AUR helper (yay or paru) not found. Please install one first."
    exit 1
fi

log_success "wl-screenrec installed"
log_info "wl-screenrec - High performance screen recorder for Wayland"
