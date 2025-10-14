#!/usr/bin/env bash
# migrations/008-display-tui.sh
# Installs and configures display-tui for monitor management

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing display-tui..."

# Clone and build display-tui
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

log_info "Cloning display-tui repository..."
git clone https://github.com/otto-bus-dev/display-tui.git

cd display-tui
log_info "Building display-tui (this may take a few minutes)..."
cargo build --release

# Install binary
log_info "Installing display-tui to /usr/local/bin..."
sudo cp target/release/display-tui /usr/local/bin/
sudo chmod 755 /usr/local/bin/display-tui

# Cleanup
cd /
rm -rf "$TEMP_DIR"

# Configure display-tui
log_info "Configuring display-tui..."
mkdir -p "$HOME/.config/display-tui"
echo '{"monitors_config_path": "~/.config/hypr/display-monitors.conf"}' > "$HOME/.config/display-tui/config.json"

log_success "display-tui installed and configured"
log_info "Run 'display-tui' to configure your monitors"
