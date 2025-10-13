#!/usr/bin/env bash
# install/preflight/all.sh - Pre-installation checks

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Running preflight checks..."

# Check we're on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
  log_error "This installer requires Arch Linux"
  exit 1
fi
log_success "Running on Arch Linux"

# Check for root/sudo
if [[ $EUID -eq 0 ]]; then
  log_warn "Running as root - will install to /root home"
  log_warn "Consider running as regular user with sudo for packages"
fi

# Check internet connectivity
if ! ping -c 1 -W 2 archlinux.org &>/dev/null; then
  log_error "No internet connection detected"
  log_info "Internet required for package installation"
  exit 1
fi
log_success "Internet connection verified"

# Check pacman is working
if ! pacman -Q &>/dev/null; then
  log_error "pacman is not working correctly"
  exit 1
fi
log_success "Package manager working"

log_success "All preflight checks passed"
