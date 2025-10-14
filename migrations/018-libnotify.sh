#!/usr/bin/env bash
# migrations/018-libnotify.sh
# Installs libnotify for desktop notifications (notify-send)

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing libnotify (notify-send)..."

# Install libnotify package
sudo pacman -S --needed --noconfirm libnotify

log_success "libnotify installed"
log_info "Use 'notify-send' to send desktop notifications"
