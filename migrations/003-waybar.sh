#!/usr/bin/env bash
# migrations/003-waybar.sh
# Installs Waybar configuration

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Waybar configuration..."

# Create waybar config directory
mkdir -p "$HOME/.config/waybar"

# Install waybar configs
install_config_dir "$OKONOMI_ROOT/config/waybar" "$HOME/.config/waybar"

log_success "Waybar configured"
