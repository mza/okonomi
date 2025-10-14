#!/usr/bin/env bash
# migrations/011-bashrc-d.sh
# Sets up .bashrc.d directory for modular bash configuration

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Setting up .bashrc.d directory..."

# Create .bashrc.d directory
mkdir -p "$HOME/.bashrc.d"

# Install bashrc.d scripts
if [ -d "$OKONOMI_ROOT/config/.bashrc.d" ]; then
    for script in "$OKONOMI_ROOT/config/.bashrc.d"/*; do
        if [ -f "$script" ]; then
            install_config "$script" "$HOME/.bashrc.d/$(basename "$script")"
        fi
    done
fi

# Add sourcing logic to .bashrc if not already present
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "\.bashrc\.d" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# Source bashrc.d scripts" >> "$HOME/.bashrc"
        echo "for script in ~/.bashrc.d/*.sh; do" >> "$HOME/.bashrc"
        echo "    [ -r \"\$script\" ] && . \"\$script\"" >> "$HOME/.bashrc"
        echo "done" >> "$HOME/.bashrc"
    fi
else
    # Create .bashrc if it doesn't exist
    cat > "$HOME/.bashrc" <<'EOF'
# Source bashrc.d scripts
for script in ~/.bashrc.d/*.sh; do
    [ -r "$script" ] && . "$script"
done
EOF
fi

log_success ".bashrc.d configured"
log_info "Add custom bash configs to ~/.bashrc.d/"
log_info "Restart your shell or run: source ~/.bashrc"
