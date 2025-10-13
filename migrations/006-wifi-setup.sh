#!/usr/bin/env bash
# migrations/006-wifi-setup.sh
# Sets up WiFi configuration persistence

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Setting up WiFi configuration..."

# Run the WiFi setup helper
bash "$OKONOMI_ROOT/install/helpers/setup-wifi.sh"

log_success "WiFi setup complete"
