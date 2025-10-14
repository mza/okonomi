#!/usr/bin/env bash
# migrations/019-xdg-user-dirs.sh
# Installs xdg-user-dirs for managing user directories

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing xdg-user-dirs..."

# Install xdg-user-dirs package
sudo pacman -S --needed --noconfirm xdg-user-dirs

log_success "xdg-user-dirs installed"
log_info "Run 'xdg-user-dirs-update' to create/update user directories"
