#!/usr/bin/env bash
# migrations/013-python.sh
# Installs Python and pip

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Python and pip..."

# Install python and pip
sudo pacman -S --needed --noconfirm python python-pip

log_success "Python and pip installed"
