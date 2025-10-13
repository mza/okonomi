#!/usr/bin/env bash
# install.sh - Okonomi installer entry point
# Turn a fresh Arch installation into a fully-configured Okonomi system

set -eEo pipefail

# Setup environment
export OKONOMI_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$OKONOMI_ROOT/bin:$PATH"

# Colors
BLUE='\e[34m'
GREEN='\e[32m'
RESET='\e[0m'

echo -e "${BLUE}╔═══════════════════════════════════╗${RESET}"
echo -e "${BLUE}║  ${GREEN}Okonomi Installer${BLUE}                ║${RESET}"
echo -e "${BLUE}╔═══════════════════════════════════╗${RESET}"
echo ""

# Source components in order
source "$OKONOMI_ROOT/install/preflight/all.sh"
echo ""

source "$OKONOMI_ROOT/install/packaging/all.sh"
echo ""

source "$OKONOMI_ROOT/install/config/all.sh"
echo ""

source "$OKONOMI_ROOT/install/post-install/all.sh"
