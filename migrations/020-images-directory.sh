#!/usr/bin/env bash
# migrations/020-images-directory.sh
# Creates images and screenshots directories in user home

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Creating images directories..."

# Create images directory and screenshots subdirectory
mkdir -p "$HOME/images/screenshots"

log_success "Created ~/images and ~/images/screenshots directories"
