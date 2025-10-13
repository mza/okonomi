#!/usr/bin/env bash
# migrations/005-autologin.sh
# Configures greetd for autologin to Hyprland

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Configuring autologin..."

# Get current user
CURRENT_USER="$USER"

# Create greetd config directory
sudo mkdir -p /etc/greetd

# Configure greetd for autologin
sudo tee /etc/greetd/config.toml > /dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "agreety --cmd $HOME/.local/bin/start-hypr.sh"
user = "$CURRENT_USER"

[initial_session]
command = "$HOME/.local/bin/start-hypr.sh"
user = "$CURRENT_USER"
EOF

log_success "Autologin configured for user: $CURRENT_USER"
