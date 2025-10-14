#!/usr/bin/env bash
# migrations/010-github-cli.sh
# Installs GitHub CLI (gh)

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing GitHub CLI (gh)..."

# Install github-cli package
sudo pacman -S --needed --noconfirm github-cli

log_success "GitHub CLI installed"
log_info "Run 'gh auth login' to authenticate with GitHub"
