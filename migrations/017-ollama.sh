#!/usr/bin/env bash
# migrations/017-ollama.sh
# Installs Ollama for running local LLMs

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Ollama..."

# Install ollama package from AUR
# Note: This requires an AUR helper (yay/paru) to be installed
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm ollama
elif command -v paru &> /dev/null; then
    paru -S --needed --noconfirm ollama
else
    log_error "AUR helper (yay or paru) not found. Please install one first."
    exit 1
fi

# Enable and start the ollama service
log_info "Enabling Ollama service..."
sudo systemctl enable ollama.service
sudo systemctl start ollama.service

log_success "Ollama installed and service started"
log_info "Run 'ollama pull <model>' to download models (e.g., 'ollama pull llama2')"
log_info "Run 'ollama list' to see installed models"
