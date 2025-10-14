#!/usr/bin/env bash
# migrations/009-okonomi-bin.sh
# Sets up okonomi bin directory for custom launcher scripts

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Setting up okonomi bin directory..."

# Create okonomi bin directory
mkdir -p "$HOME/.local/bin/okonomi"

# Install launcher scripts
if [ -d "$OKONOMI_ROOT/config/.local/bin/okonomi" ]; then
    for script in "$OKONOMI_ROOT/config/.local/bin/okonomi"/*; do
        if [ -f "$script" ]; then
            install_config "$script" "$HOME/.local/bin/okonomi/$(basename "$script")" 755
        fi
    done
fi

# Install PATH configuration
mkdir -p "$HOME/.profile.d"
install_config "$OKONOMI_ROOT/config/.profile.d/okonomi-path.sh" "$HOME/.profile.d/okonomi-path.sh"

# Source it in .profile if not already done
if [ -f "$HOME/.profile" ]; then
    if ! grep -q "\.profile\.d" "$HOME/.profile"; then
        echo "" >> "$HOME/.profile"
        echo "# Source profile.d scripts" >> "$HOME/.profile"
        echo "for script in ~/.profile.d/*.sh; do" >> "$HOME/.profile"
        echo "    [ -r \"\$script\" ] && . \"\$script\"" >> "$HOME/.profile"
        echo "done" >> "$HOME/.profile"
    fi
else
    # Create .profile if it doesn't exist
    cat > "$HOME/.profile" <<'EOF'
# Source profile.d scripts
for script in ~/.profile.d/*.sh; do
    [ -r "$script" ] && . "$script"
done
EOF
fi

log_success "okonomi bin directory configured"
log_info "Add launcher scripts to ~/.local/bin/okonomi/"

# Set default browser to chromium
log_info "Setting chromium as default browser..."
xdg-settings set default-web-browser chromium.desktop

log_info "Restart your session or run: source ~/.profile"
