# LiteLLM Platform Service

LiteLLM proxy for unified LLM access across local (Ollama) and cloud (Anthropic) providers.

## Services

- **litellm**: API proxy server (port 4000)

## Configuration

- `litellm_config.yaml`: Model definitions and routing
- `.env`: API keys and secrets (not committed to git)
- `.env.example`: Template for environment variables

## Model Configuration

### Local Models (via Ollama)
- `gpt-oss`: Local Ollama model with function calling support

### Cloud Models (Anthropic)
- `claude-sonnet-4-5`: Latest Claude Sonnet (best quality)
- `claude-haiku-4-5`: Claude Haiku (fast & cheap)
- `claude-opus-4-1`: Claude Opus (most capable)

## Usage

```bash
# Start LiteLLM (requires Ollama running)
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Stop service
docker-compose down

# Restart after config changes
docker-compose restart
```

## API Endpoints

- Base URL: `http://localhost:4000`
- OpenAI-compatible: `http://localhost:4000/v1/chat/completions`
- Health check: `http://localhost:4000/health`

## Dependencies

Requires Ollama infrastructure running at `http://localhost:11434`

## Switching Models

In your application code, simply change the model name:
```typescript
model: 'gpt-oss'              // Local Ollama
model: 'claude-sonnet-4-5'    // Cloud Claude
```
