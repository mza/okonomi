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
            mkdir -p "$(dirname "$repo_file")"
            cp "$system_file" "$repo_file"
        fi
    fi
}

# Helper function to recursively sync a directory
sync_directory_recursive() {
    local repo_dir="$1"
    local system_dir="$2"

    [ -d "$repo_dir" ] || return

    # Find all files recursively in the repo directory
    while IFS= read -r -d '' repo_file; do
        # Get relative path from repo_dir
        local rel_path="${repo_file#$repo_dir/}"
        local system_file="$system_dir/$rel_path"
        sync_if_newer "$system_file" "$repo_file"
    done < <(find "$repo_dir" -type f -print0)

    # Also check for new files in the system that aren't in the repo yet
    if [ -d "$system_dir" ]; then
        while IFS= read -r -d '' system_file; do
            local rel_path="${system_file#$system_dir/}"
            local repo_file="$repo_dir/$rel_path"

            if [ ! -f "$repo_file" ]; then
                if ! is_ignored "$repo_file"; then
                    echo "  Syncing (new): $system_file -> $repo_file"
                    mkdir -p "$(dirname "$repo_file")"
                    cp "$system_file" "$repo_file"
                fi
            fi
        done < <(find "$system_dir" -type f -print0)
    fi
}

# Find all config files in the repo
cd "$OKONOMI_ROOT"

# Sync files from ~/.config/ (recursively including subdirectories)
sync_directory_recursive "config/hypr" "$HOME/.config/hypr"
sync_directory_recursive "config/waybar" "$HOME/.config/waybar"
sync_directory_recursive "config/alacritty" "$HOME/.config/alacritty"
sync_directory_recursive "config/environment.d" "$HOME/.config/environment.d"
sync_directory_recursive "config/display-tui" "$HOME/.config/display-tui"

# Sync files from ~/.local/bin/ (recursively including subdirectories like okonomi)
mkdir -p "config/.local/bin/okonomi"
sync_directory_recursive "config/.local/bin" "$HOME/.local/bin"

# Sync profile.d scripts
sync_directory_recursive "config/.profile.d" "$HOME/.profile.d"

# Sync bashrc.d scripts
sync_directory_recursive "config/.bashrc.d" "$HOME/.bashrc.d"

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
