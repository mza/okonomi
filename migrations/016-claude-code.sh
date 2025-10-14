#!/usr/bin/env bash
# migrations/016-claude-code.sh
# Installs Claude Code CLI

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Claude Code..."

# Install Node.js and npm if not already installed
sudo pacman -S --needed --noconfirm nodejs npm

# Install Claude Code globally
log_info "Installing Claude Code via npm..."
sudo npm install -g @anthropic-ai/claude-code

log_success "Claude Code installed"
log_info "Run 'claude' to start using Claude Code"
