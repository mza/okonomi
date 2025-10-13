#!/usr/bin/env bash
# migrations/002-hyprland-desktop.sh
# Installs Hyprland configuration to user home

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Hyprland desktop configuration..."

# Create config directories
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/environment.d"
mkdir -p "$HOME/.local/bin"

# Install Hyprland configs
install_config "$OKONOMI_ROOT/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
install_config "$OKONOMI_ROOT/config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"

# Install environment variables
install_config "$OKONOMI_ROOT/config/environment.d/10-wayland.conf" "$HOME/.config/environment.d/10-wayland.conf"

# Install launcher script
install_config "$OKONOMI_ROOT/config/.local/bin/start-hypr.sh" "$HOME/.local/bin/start-hypr.sh" 755

log_success "Hyprland desktop configured"
