#!/usr/bin/env python3
"""
Monitor Manager - Save and switch between monitor configurations
"""

import os
import sys
import json
import subprocess
from pathlib import Path

PROFILES_DIR = Path.home() / ".config" / "okonomi" / "monitor-profiles"
HYPR_MONITORS_CONF = Path.home() / ".config" / "hypr" / "display-monitors.conf"


def get_current_config():
    """Get current monitor configuration from hyprctl"""
    result = subprocess.run(
        ["hyprctl", "monitors", "-j"],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        print("Error: Could not get monitor configuration", file=sys.stderr)
        sys.exit(1)

    monitors = json.loads(result.stdout)

    # Convert to hyprland monitor config lines
    config_lines = []
    for monitor in monitors:
        name = monitor['name']
        width = monitor['width']
        height = monitor['height']
        refresh = monitor['refreshRate']
        x = monitor['x']
        y = monitor['y']
        scale = monitor['scale']

        config_lines.append(
            f"monitor = {name}, {width}x{height}@{refresh}, {x}x{y}, {scale}"
        )

    return "\n".join(config_lines)


def save_profile(name):
    """Save current monitor configuration as a named profile"""
    PROFILES_DIR.mkdir(parents=True, exist_ok=True)

    config = get_current_config()
    profile_file = PROFILES_DIR / f"{name}.conf"

    profile_file.write_text(config)
    print(f"✓ Saved profile '{name}'")


def list_profiles():
    """List all saved profiles"""
    if not PROFILES_DIR.exists():
        print("No profiles saved yet")
        return

    profiles = list(PROFILES_DIR.glob("*.conf"))
    if not profiles:
        print("No profiles saved yet")
        return

    print("Saved monitor profiles:")
    for profile in profiles:
        name = profile.stem
        print(f"  - {name}")


def apply_profile(name):
    """Apply a saved profile"""
    profile_file = PROFILES_DIR / f"{name}.conf"

    if not profile_file.exists():
        print(f"Error: Profile '{name}' not found", file=sys.stderr)
        sys.exit(1)

    # Copy profile to hyprland config
    config = profile_file.read_text()
    HYPR_MONITORS_CONF.write_text(config)

    # Reload hyprland config
    subprocess.run(["hyprctl", "reload"])

    print(f"✓ Applied profile '{name}'")


def delete_profile(name):
    """Delete a saved profile"""
    profile_file = PROFILES_DIR / f"{name}.conf"

    if not profile_file.exists():
        print(f"Error: Profile '{name}' not found", file=sys.stderr)
        sys.exit(1)

    profile_file.unlink()
    print(f"✓ Deleted profile '{name}'")


def show_usage():
    """Show usage information"""
    print("""Monitor Manager - Manage monitor configurations

Usage:
  monitor-manager save <name>     Save current config as profile
  monitor-manager list             List all saved profiles
  monitor-manager apply <name>     Apply a saved profile
  monitor-manager delete <name>    Delete a saved profile
  monitor-manager help             Show this help
""")


def main():
    if len(sys.argv) < 2:
        show_usage()
        sys.exit(1)

    command = sys.argv[1]

    if command == "save":
        if len(sys.argv) < 3:
            print("Error: Please provide a profile name", file=sys.stderr)
            sys.exit(1)
        save_profile(sys.argv[2])

    elif command == "list":
        list_profiles()

    elif command == "apply":
        if len(sys.argv) < 3:
            print("Error: Please provide a profile name", file=sys.stderr)
            sys.exit(1)
        apply_profile(sys.argv[2])

    elif command == "delete":
        if len(sys.argv) < 3:
            print("Error: Please provide a profile name", file=sys.stderr)
            sys.exit(1)
        delete_profile(sys.argv[2])

    elif command in ["help", "-h", "--help"]:
        show_usage()

    else:
        print(f"Error: Unknown command '{command}'", file=sys.stderr)
        show_usage()
        sys.exit(1)


if __name__ == "__main__":
    main()
