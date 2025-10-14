#!/usr/bin/env bash
# migrations/014-aur-helper.sh
# Installs yay AUR helper

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing yay AUR helper..."

# Check if yay is already installed
if command -v yay &> /dev/null; then
    log_success "yay is already installed"
    exit 0
fi

# Install dependencies
sudo pacman -S --needed --noconfirm base-devel git

# Clone and build yay
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

log_info "Cloning yay repository..."
git clone https://aur.archlinux.org/yay.git

cd yay
log_info "Building yay..."
makepkg -si --noconfirm

# Cleanup
cd /
rm -rf "$TEMP_DIR"

log_success "yay AUR helper installed"
log_info "You can now install AUR packages with: yay -S package-name"
