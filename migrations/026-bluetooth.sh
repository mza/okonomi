#!/usr/bin/env bash
# migrations/026-bluetooth.sh
# Installs and configures Bluetooth with blueberry

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Bluetooth support..."

# Install bluez (bluetooth stack) and blueberry (GUI manager)
sudo pacman -S --needed --noconfirm bluez bluez-utils blueberry

# Enable and start bluetooth service
log_info "Enabling Bluetooth service..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

log_success "Bluetooth installed and enabled"
log_info "Run 'blueberry' to manage Bluetooth devices"
