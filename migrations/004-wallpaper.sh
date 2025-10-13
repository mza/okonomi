#!/usr/bin/env bash
# migrations/004-wallpaper.sh
# Installs wallpaper assets

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing wallpaper..."

# Create system backgrounds directory (requires sudo)
sudo mkdir -p /usr/share/backgrounds/okonomi

# Install wallpaper
sudo cp "$OKONOMI_ROOT/assets/backgrounds/wallpaper.png" /usr/share/backgrounds/okonomi/wallpaper.png
sudo chmod 644 /usr/share/backgrounds/okonomi/wallpaper.png

log_success "Wallpaper installed"
