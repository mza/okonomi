#!/usr/bin/env bash
# migrations/025-sway-utils.sh
# Installs swaybg and swayosd utilities

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing sway utilities (swaybg and swayosd)..."

# Install swaybg and swayosd packages
sudo pacman -S --needed --noconfirm swaybg swayosd

log_success "Sway utilities installed"
log_info "swaybg - Wallpaper tool for Wayland"
log_info "swayosd - On-screen display for volume/brightness"
