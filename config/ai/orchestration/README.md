# System Orchestration

Central management layer for infrastructure and platform services.

## Quick Start

The easiest way to manage services is with the `sys` CLI:

```bash
# Add to your PATH (optional)
export PATH="$PATH:/home/mza/src/orchestration/scripts"

# Or use directly
./scripts/sys start
```

## Commands

### Using the sys CLI

```bash
sys start           # Start all services
sys stop            # Stop all services
sys restart         # Restart all services
sys status          # Show what's running
sys logs [service]  # View logs (ollama, litellm, or all)

sys start-infra     # Start just infrastructure
sys start-platform  # Start just platform

sys add-model       # Add a new model (interactive wizard)
```

### Adding Models

The easiest way to add new models:

```bash
sys add-model
```

This interactive wizard will:
- Guide you through choosing local (Ollama) or cloud models
- Pull Ollama models automatically
- Update LiteLLM configuration
- Handle API keys for cloud providers
- Restart services and verify the model works

**For local models:**
1. Shows popular options (llama3.2, mistral, etc.)
2. Pulls the model from Ollama
3. Adds to LiteLLM config with function calling support
4. Verifies it's available

**For cloud models:**
1. Supports OpenAI, Anthropic, Gemini, Cohere, and custom providers
2. Prompts for API keys (if needed)
3. Adds to LiteLLM config
4. Updates .env file
```

### Using Make Directly

```bash
cd /home/mza/src/orchestration

make start-all      # Start everything
make stop-all       # Stop everything
make status         # Show status
make help           # Show all commands
```

## Architecture

Services are organized in layers:

1. **Infrastructure Layer** (`infra/`)
   - Ollama - Local LLM serving

2. **Platform Layer** (`platform/`)
   - LiteLLM - Unified LLM proxy
   - (Future: databases, caches, etc.)

3. **Application Layer** (`apps/`)
   - Your agents and applications
   - (Managed separately, not by orchestration)

## Dependencies

Platform layer depends on infrastructure layer:
- LiteLLM requires Ollama to be running
- Starting platform automatically starts infrastructure

## Service Management

### Starting Services

```bash
# Start everything (recommended)
sys start

# Or start layers individually
sys start-infra      # Just Ollama
sys start-platform   # LiteLLM + Ollama
```

### Stopping Services

```bash
# Stop everything
sys stop

# Or stop layers individually
sys stop-platform    # Just LiteLLM
sys stop-infra       # Just Ollama
```

### Checking Status

```bash
sys status
```

Shows:
- Which containers are running
- Their status and ports
- Organized by layer

### Viewing Logs

```bash
sys logs              # All logs (combined)
sys logs ollama       # Just Ollama
sys logs litellm      # Just LiteLLM
```

## Configuration

Service configurations are in their respective directories:
- `infra/ollama/docker-compose.yml`
- `platform/litellm/docker-compose.yml`
- `platform/litellm/litellm_config.yaml`

After changing configs:
```bash
sys restart
```

## Maintenance

### Clean Everything

Remove all containers and volumes:
```bash
make clean   # Will prompt for confirmation
```

### Rebuild After Updates

```bash
sys stop
docker-compose pull  # Update images
sys start
```
