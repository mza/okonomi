#!/usr/bin/env bash
# install/packaging/all.sh - Install all required packages

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing okonomi packages..."

# Parse package list (remove comments and empty lines)
PACKAGES=$(grep -v '^#' "$OKONOMI_ROOT/install/packages.txt" | grep -v '^$' | tr '\n' ' ')

log_info "Installing $(echo $PACKAGES | wc -w) packages..."

# Update package database
run_logged "Updating package database" sudo pacman -Sy

# Install packages
if sudo pacman -S --noconfirm --needed $PACKAGES; then
  log_success "All packages installed"
else
  log_error "Package installation failed"
  exit 1
fi

# Verify critical packages
for pkg in hyprland waybar greetd; do
  if ! pacman -Q "$pkg" &>/dev/null; then
    log_error "Critical package '$pkg' was not installed"
    exit 1
  fi
done
log_success "Critical packages verified"
