#!/usr/bin/env bash
# migrations/022-walker.sh
# Installs walker application launcher

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing walker..."

# Install walker from AUR
# Note: This requires an AUR helper (yay/paru) to be installed
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm walker
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm walker
else
    log_error "AUR helper (yay or paru) not found. Please install one first."
    exit 1
fi

log_success "walker installed"
log_info "walker - Application launcher for Wayland"
