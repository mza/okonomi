#!/usr/bin/env bash
# migrations/028-vicinae.sh
# Installs vicinae

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing vicinae..."

# Install vicinae package
sudo pacman -S --needed --noconfirm vicinae

log_success "vicinae installed"
