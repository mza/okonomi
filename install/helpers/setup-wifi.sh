#!/usr/bin/env bash
# install/helpers/setup-wifi.sh
# Manages WiFi configuration persistence

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

WIFI_BACKUP_DIR="$OKONOMI_ROOT/.local/wifi-configs"
SYSTEM_CONNECTIONS="/etc/NetworkManager/system-connections"

# Create backup directory if it doesn't exist
mkdir -p "$WIFI_BACKUP_DIR"

# Check if we have backed up WiFi configs
if [ -n "$(ls -A "$WIFI_BACKUP_DIR" 2>/dev/null)" ]; then
    log_info "Found existing WiFi configurations, restoring..."

    # Copy backed up configs to system
    sudo cp "$WIFI_BACKUP_DIR"/* "$SYSTEM_CONNECTIONS/"
    sudo chmod 600 "$SYSTEM_CONNECTIONS"/*
    sudo chown root:root "$SYSTEM_CONNECTIONS"/*

    # Reload NetworkManager
    sudo systemctl reload NetworkManager

    log_success "WiFi configurations restored"
else
    log_info "No WiFi configurations found. Please configure WiFi..."
    echo ""
    echo "Press ENTER to launch NetworkManager TUI to configure WiFi"
    read -r

    # Launch nmtui for user to configure
    sudo nmtui

    # Ask if user wants to backup the configuration
    echo ""
    echo "Would you like to save this WiFi configuration for future installs? (y/n)"
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        # Backup all WiFi connections
        if [ -n "$(ls -A "$SYSTEM_CONNECTIONS" 2>/dev/null)" ]; then
            sudo cp "$SYSTEM_CONNECTIONS"/* "$WIFI_BACKUP_DIR/"
            sudo chown "$USER:$USER" "$WIFI_BACKUP_DIR"/*
            chmod 600 "$WIFI_BACKUP_DIR"/*

            log_success "WiFi configuration saved to $WIFI_BACKUP_DIR"
            log_info "Note: These configs contain passwords. Keep your okonomi repo private!"
        else
            log_warning "No WiFi connections found to backup"
        fi
    fi
fi
