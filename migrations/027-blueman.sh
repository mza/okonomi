#!/usr/bin/env bash
# migrations/027-blueman.sh
# Installs blueman for bluetooth management

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing blueman..."

# Install blueman bluetooth manager
sudo pacman -S --needed --noconfirm blueman

log_success "blueman installed"
log_info "Run 'blueman-manager' to manage Bluetooth devices"
log_info "Run 'blueman-applet' to start the system tray applet"
