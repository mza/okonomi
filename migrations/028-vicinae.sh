#!/usr/bin/env bash
# migrations/028-vicinae.sh
# Installs vicinae

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing vicinae..."

# Install vicinae-bin from AUR
# Note: This requires an AUR helper (yay/paru) to be installed
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm vicinae-bin
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm vicinae-bin
else
    log_error "AUR helper (yay or paru) not found. Please install one first."
    exit 1
fi

log_success "vicinae installed"
