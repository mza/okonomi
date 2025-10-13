#!/usr/bin/env bash
# install/config/all.sh - Apply okonomi configurations

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Applying okonomi configurations..."

# Run migrations to install configs
if bash "$OKONOMI_ROOT/migrations/apply"; then
  log_success "Configurations applied"
else
  log_error "Configuration failed"
  exit 1
fi
