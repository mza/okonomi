#!/usr/bin/env bash
# dev/sync-configs-from-system.sh
# Syncs config files from the running system back to the repo

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

echo "Syncing configs from system to repo..."
echo ""

# Load sync ignore patterns
declare -a IGNORE_PATTERNS=()
if [ -f "$OKONOMI_ROOT/.syncignore" ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        IGNORE_PATTERNS+=("$line")
    done < "$OKONOMI_ROOT/.syncignore"
fi

# Helper function to check if file should be ignored
is_ignored() {
    local file="$1"
    for pattern in "${IGNORE_PATTERNS[@]}"; do
        if [[ "$file" == "$pattern" ]]; then
            return 0
        fi
    done
    return 1
}

# Helper function to sync a file if system version is newer
sync_if_newer() {
    local system_file="$1"
    local repo_file="$2"

    # Check if this file is in the ignore list
    if is_ignored "$repo_file"; then
        return
    fi

    if [ -f "$system_file" ]; then
        if [ "$system_file" -nt "$repo_file" ]; then
            echo "  Syncing (newer): $system_file -> $repo_file"
            cp "$system_file" "$repo_file"
        fi
    fi
}

# Find all config files in the repo
cd "$OKONOMI_ROOT"

# Sync files from ~/.config/
if [ -d "config/hypr" ]; then
    for repo_file in config/hypr/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.config/hypr/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

if [ -d "config/waybar" ]; then
    for repo_file in config/waybar/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.config/waybar/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

if [ -d "config/alacritty" ]; then
    for repo_file in config/alacritty/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.config/alacritty/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

if [ -d "config/environment.d" ]; then
    for repo_file in config/environment.d/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.config/environment.d/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

if [ -d "config/display-tui" ]; then
    for repo_file in config/display-tui/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.config/display-tui/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

# Sync files from ~/.local/bin/
if [ -d "config/.local/bin" ]; then
    for repo_file in config/.local/bin/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.local/bin/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

# Sync okonomi bin scripts
if [ -d "config/.local/bin/okonomi" ]; then
    for repo_file in config/.local/bin/okonomi/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.local/bin/okonomi/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

# Sync profile.d scripts
if [ -d "config/.profile.d" ]; then
    for repo_file in config/.profile.d/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.profile.d/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

# Sync bashrc.d scripts
if [ -d "config/.bashrc.d" ]; then
    for repo_file in config/.bashrc.d/*; do
        [ -f "$repo_file" ] || continue
        system_file="$HOME/.bashrc.d/$(basename "$repo_file")"
        sync_if_newer "$system_file" "$repo_file"
    done
fi

echo ""
echo "Sync complete!"
echo ""

# Stage changes and prepare commit
if git diff --quiet config/; then
    echo "No changes to commit."
else
    echo "Staging changes..."
    git add config/

    # Create commit with empty message (user will fill it in)
    echo ""
    echo "Ready to commit. Run: git commit"
    echo "Or run: git commit -m 'your message here'"
fi
