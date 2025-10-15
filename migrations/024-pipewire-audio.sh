#!/usr/bin/env bash
# migrations/024-pipewire-audio.sh
# Installs PipeWire audio system

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing PipeWire audio system..."

# Install PipeWire and related packages
sudo pacman -S --needed --noconfirm pipewire pipewire-pulse pipewire-alsa sof-firmware

log_success "PipeWire audio system installed"
log_info "PipeWire will start automatically on next login"
