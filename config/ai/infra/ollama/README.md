# Ollama Infrastructure

Local LLM serving infrastructure using Ollama.

## Services

- **ollama**: Ollama API server for running local models (port 11434)

## Storage

- `./data/`: Persistent storage for downloaded models and configuration

## Usage

```bash
# Start Ollama
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Pull a model
docker exec -it ollama ollama pull gpt-oss

# List models
docker exec -it ollama ollama list

# Stop service
docker-compose down
```

## API Endpoints

- Base URL: `http://localhost:11434`
- OpenAI-compatible: `http://localhost:11434/v1/chat/completions`
- Native API: `http://localhost:11434/api/generate`
- Tags list: `http://localhost:11434/api/tags`
