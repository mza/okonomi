#!/usr/bin/env bash
# install/post-install/all.sh - Final setup steps

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Running post-installation tasks..."

# Enable NetworkManager
run_logged "Enabling NetworkManager" sudo systemctl enable NetworkManager

# Enable greetd (display manager)
run_logged "Enabling greetd" sudo systemctl enable greetd

# Enable time sync
run_logged "Enabling time sync" sudo systemctl enable systemd-timesyncd

log_success "Post-installation complete"

echo ""
log_success "🎉 Okonomi installation complete!"
echo ""
log_info "Next steps:"
echo "  1. Reboot your system"
echo "  2. Login and enjoy your Okonomi desktop!"
echo ""
