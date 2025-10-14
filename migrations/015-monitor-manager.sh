#!/usr/bin/env bash
# migrations/015-monitor-manager.sh
# Installs monitor-manager app

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing monitor-manager..."

# Install the script to ~/.local/bin/okonomi
install_config "$OKONOMI_ROOT/apps/monitor-manager/monitor-manager.py" "$HOME/.local/bin/okonomi/monitor-manager" 755

log_success "monitor-manager installed"
log_info "Usage: monitor-manager save <name> | list | apply <name> | delete <name>"
