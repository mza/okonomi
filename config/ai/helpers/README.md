# AI Task Helpers

Thin wrapper scripts for common tasks. These are automatically discovered and run via the `ai` command.

## Usage

```bash
ai <helper-name> [arguments]
```

The `ai` command will automatically find and execute helpers from this directory.

## Available Helpers

### agent
Run a coding agent with LiteLLM.
```bash
ai agent                           # Use default model (gpt-oss)
ai agent claude-sonnet-4-5         # Use Claude
ai agent gpt-oss "Fix bug in X"    # Custom prompt
```

### chat
Quick interactive chat with a model.
```bash
ai chat                  # Chat with gpt-oss
ai chat claude-sonnet-4-5    # Chat with Claude
```

### models
List all available models (local + cloud).
```bash
ai models
```

### okonomi-dev
Start the Okonomi development environment.
```bash
ai okonomi-dev
```

## Creating New Helpers

1. Create an executable script in this directory
2. Add a description comment on line 2: `# Helper: Description here`
3. Make it executable: `chmod +x helper-name`
4. It will automatically appear in `ai help`

### Template

```bash
#!/bin/bash
# Helper: Short description of what this does
# Usage: ai helper-name [args]

set -e

# Your code here
echo "Hello from helper!"
```

### Best Practices

- **Keep them thin**: Helpers should be simple wrappers
- **Use absolute paths**: Reference files with full paths when needed
- **Check dependencies**: Verify required files/services exist
- **Show helpful errors**: Guide users if something is wrong
- **Document usage**: Add usage info in the second comment line

### Example: Project-specific Helper

```bash
#!/bin/bash
# Helper: Deploy myproject to production
# Usage: ai myproject-deploy [env]

set -e

ENV="${1:-staging}"
PROJECT_DIR="/home/mza/src/myproject"

echo "Deploying myproject to $ENV..."

cd "$PROJECT_DIR"

# Ensure AI services are running (if needed)
ai status > /dev/null 2>&1 || ai start

# Run deployment
npm run deploy:$ENV
```

## Tips

- Helpers can call other `ai` commands
- Use `~/.config/ai/orchestration/scripts/sys` for direct access
- Environment variables are available
- Arguments are passed through via `$@`

## Path References

- Config: `~/.config/ai/`
- Data: `~/.local/share/ai/`
- This directory: `~/.config/ai/helpers/`
- Main CLI: `~/.config/ai/orchestration/scripts/sys`
