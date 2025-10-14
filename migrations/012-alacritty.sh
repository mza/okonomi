#!/usr/bin/env bash
# migrations/012-alacritty.sh
# Switches from kitty to alacritty as default terminal

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing alacritty terminal..."

# Install alacritty
sudo pacman -S --needed --noconfirm alacritty

# Create config directory
mkdir -p "$HOME/.config/alacritty"

# Install alacritty config
install_config "$OKONOMI_ROOT/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# Update hyprland config to use alacritty
install_config "$OKONOMI_ROOT/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"

log_success "Alacritty installed and configured as default terminal"
