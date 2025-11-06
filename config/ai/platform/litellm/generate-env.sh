#!/bin/bash
# Generate .env file from central config
# Called automatically by make start-platform

set -e

CONFIG_FILE="${HOME}/.config/ai/config.json"
ENV_FILE="${HOME}/.config/ai/platform/litellm/.env"

# Get keys from central config using wrappers
ANTHROPIC_KEY=$(okonomi-ai-get-key anthropic 2>/dev/null || echo "")
GATEWAY_KEY=$(okonomi-ai-get-key gateway 2>/dev/null || echo "")

# Generate .env file
cat > "$ENV_FILE" <<EOF
# Auto-generated from ~/.config/ai/config.json
# DO NOT EDIT MANUALLY - changes will be overwritten
# Use: okonomi-ai-set-key <key_name> <value>

# Anthropic API Key (for Claude models)
ANTHROPIC_API_KEY=${ANTHROPIC_KEY}

# LiteLLM Master Key (gateway authentication)
LITELLM_MASTER_KEY=${GATEWAY_KEY}
EOF

chmod 600 "$ENV_FILE"
