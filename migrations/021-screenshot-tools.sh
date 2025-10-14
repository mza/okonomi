#!/usr/bin/env bash
# migrations/021-screenshot-tools.sh
# Installs hyprshot and satty for screenshot capture and annotation

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing screenshot tools (hyprshot and satty)..."

# Install hyprshot and satty from AUR
# Note: This requires an AUR helper (yay/paru) to be installed
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm hyprshot satty
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm hyprshot satty
else
    log_error "AUR helper (yay or paru) not found. Please install one first."
    exit 1
fi

log_success "Screenshot tools installed"
log_info "hyprshot - Screenshot tool for Hyprland"
log_info "satty - Screenshot annotation tool"
