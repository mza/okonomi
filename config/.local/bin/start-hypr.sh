#!/usr/bin/env bash
# Start Hyprland with proper environment

# Source user environment
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

# Start Hyprland
exec Hyprland
