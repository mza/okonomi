#!/usr/bin/env bash
# migrations/007-display-monitors-config.sh
# Separates monitor configuration into display-monitors.conf

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Setting up display-monitors configuration..."

# Install the new display-monitors.conf
install_config "$OKONOMI_ROOT/config/hypr/display-monitors.conf" "$HOME/.config/hypr/display-monitors.conf"

# Update main hyprland.conf
install_config "$OKONOMI_ROOT/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"

log_success "Display monitor configuration separated"
