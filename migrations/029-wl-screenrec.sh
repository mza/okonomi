#!/usr/bin/env bash
# migrations/029-wl-screenrec.sh
# Installs wl-screenrec

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing wl-screenrec..."

# Install wl-screenrec package
sudo pacman -S --needed --noconfirm wl-screenrec

log_success "wl-screenrec installed"
log_info "wl-screenrec - High performance screen recorder for Wayland"
