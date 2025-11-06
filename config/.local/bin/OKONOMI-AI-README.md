# Okonomi AI Commands

Convenience scripts for common AI tasks in Okonomi development.

## Available Commands

All commands are prefixed with `okonomi-ai-` and available in your PATH.

### Core Commands

### okonomi-ai-start
Start AI infrastructure services (Ollama + LiteLLM).

```bash
okonomi-ai-start
```

### okonomi-ai-stop
Stop AI infrastructure services.

```bash
okonomi-ai-stop
```

### okonomi-ai-status
Check status of AI services.

```bash
okonomi-ai-status
```

### Model Management

### okonomi-ai-get-model
Show the current default AI model.

```bash
okonomi-ai-get-model
```

### okonomi-ai-set-model
Set the default AI model.

```bash
okonomi-ai-set-model claude-sonnet-4-5
```

### okonomi-ai-list-models
List all available AI models (local + cloud) and show current default.

```bash
okonomi-ai-list-models
```

**Note:** The old `okonomi-ai-models` command still works and is an alias for `okonomi-ai-list-models`.

### Token Usage Tracking

### okonomi-ai-odo
Show AI token usage odometer with trip (resettable) and lifetime (all-time) counters.

```bash
okonomi-ai-odo              # Show current readings
okonomi-ai-odo reset        # Reset trip odometer
```

The odometer tracks:
- **Trip Odometer**: Resettable counter for tracking usage during specific sessions
- **Lifetime Odometer**: All-time counter that never resets
- **Per-Model Breakdown**: See token usage broken down by each AI model you use

### okonomi-ai-speed
Real-time speedometer showing actual tokens/sec per request with statistics.

```bash
okonomi-ai-speed
```

Displays:
- **🔴 Live Request** - Shows in-progress requests as they stream
  - Model being used
  - Estimated tokens so far
  - Elapsed time
  - Current throughput rate
- **Completed Requests** (last 30 seconds)
  - Average tokens/sec per model (real throughput)
  - Maximum speed observed
  - Minimum speed observed
  - Request count

**Pro tip:** Run `okonomi-ai-speed` in one terminal and `okonomi-ai-chat` in another to see live token flow!

### okonomi-ai-log
Real-time activity log showing individual token events as they happen.

```bash
okonomi-ai-log
```

Displays:
- Timestamp
- Model used
- Input tokens
- Output tokens
- Total tokens per request

Press Ctrl+C to exit either viewer.

### Utility Creation

### okonomi-ai-create-bin
**⭐ Automated workflow** - Create, register, and install utility bins using AI!

Just describe what you want - the AI does everything else, including choosing the name.

```bash
okonomi-ai-create-bin                    # Use default model (gpt-oss)
okonomi-ai-create-bin claude-sonnet-4-5  # Use a different model
```

See detailed example below.

### Bin Management

### okonomi-ai-list-bins
List all registered utility bins.

```bash
okonomi-ai-list-bins
```

### okonomi-ai-bin-info
Show detailed information about a specific bin.

```bash
okonomi-ai-bin-info <bin-name>
```

### okonomi-ai-install-bin
Install a registered bin to PATH.

```bash
okonomi-ai-install-bin <bin-name>
```

### okonomi-ai-uninstall-bin
Uninstall a bin from PATH (keeps registry entry).

```bash
okonomi-ai-uninstall-bin <bin-name>
```

### okonomi-ai-update-bin
Update bin metadata (version, description).

```bash
okonomi-ai-update-bin <bin-name>
```

### okonomi-ai-remove-bin
Remove a bin from the registry completely.

```bash
okonomi-ai-remove-bin <bin-name>
```

### Interactive Tools

### okonomi-ai-chat
Start an interactive chat session with an AI model.

```bash
okonomi-ai-chat                    # Use default model (gpt-oss)
okonomi-ai-chat claude-sonnet-4-5  # Use Claude Sonnet
```

### okonomi-ai-agent
Run a coding agent on the Okonomi project.

```bash
okonomi-ai-agent                                    # Default: gpt-oss, review task
okonomi-ai-agent claude-sonnet-4-5                  # Use Claude
okonomi-ai-agent gpt-oss "Fix authentication bug"  # Custom task
```

## Example: Creating a Bin with AI

Full workflow using `okonomi-ai-create-bin`:

```bash
$ okonomi-ai-create-bin
═══════════════════════════════════════════════════════════════
           Okonomi AI - Create Bin Wizard
═══════════════════════════════════════════════════════════════

Using model: gpt-oss

What should this bin do?
Description: Format and pretty-print JSON files

Step 1: Running AI agent to create the bin...
Task: Format and pretty-print JSON files

[AI agent creates the script, choosing an appropriate name]

✓ Agent completed

Step 2: Registering bin...

AI chose the name: json-fmt

Generated script preview:
────────────────────────────────────────────────────────────────
#!/bin/bash
# json-fmt - Format and pretty-print JSON files
# Usage: json-fmt [file]

set -e
...
────────────────────────────────────────────────────────────────

Looks good? [Y/n]: y
✓ Registered json-fmt

Step 3: Installing bin to PATH...
✓ Installed json-fmt to ~/.local/bin

═══════════════════════════════════════════════════════════════
                    Success!
═══════════════════════════════════════════════════════════════

Try it now:
  json-fmt --help
  json-fmt myfile.json
```

**Using a different model:**
```bash
$ okonomi-ai-create-bin claude-sonnet-4-5

Using model: claude-sonnet-4-5

What should this bin do?
Description: Create database backups with timestamp
...
```

## Token Usage Example

Track your AI token consumption:

```bash
$ okonomi-ai-odo
═══════════════════════════════════════════════════════════════
                    AI Token Odometer
═══════════════════════════════════════════════════════════════

Trip Odometer (resettable)
  Total: 37,920 tokens (in: 25,340, out: 12,580)

  By model:
    gpt-oss                  18,500 (in:   12,000, out:    6,500)
    claude-sonnet-4-5        15,200 (in:   10,340, out:    4,860)
    claude-haiku-4-5          4,220 (in:    3,000, out:    1,220)

  Reset at: 2025-11-05T10:00:00Z

Lifetime Odometer (all-time)
  Total: 1,835,110 tokens (in: 1,245,678, out: 589,432)

  By model:
    gpt-oss                 920,500 (in:  645,000, out:  275,500)
    claude-sonnet-4-5       758,340 (in:  495,678, out:  262,662)
    claude-haiku-4-5        156,270 (in:  105,000, out:   51,270)

  Started at: 2025-11-01T08:00:00Z

# Reset trip for a new session
$ okonomi-ai-odo reset
✓ Trip odometer reset

# Watch real-time token speed (actual throughput per request)
$ okonomi-ai-speed
═══════════════════════════════════════════════════════════════
        AI Token Speedometer (tokens/sec per request)
            Last 30s - 10:15:45
═══════════════════════════════════════════════════════════════

🔴 LIVE REQUEST
Model: claude-sonnet-4-5
Tokens: ~287 (estimated output)
Elapsed: 1.2s
Rate: 239 tok/s

Recent completed requests:

Model                        Avg/sec    Max/sec    Min/sec Requests
───────────────────────────────────────────────────────────────
gpt-oss                          312        312        312        1
claude-sonnet-4-5                534        657        412        2
───────────────────────────────────────────────────────────────
Overall                          460        657        312        3

# Or view the activity log (individual events)
$ okonomi-ai-log
═══════════════════════════════════════════════════════════════
                   AI Token Activity Log
                   (Real-time Stream)
═══════════════════════════════════════════════════════════════

10:15:23 | Model: gpt-oss              | In:    256 | Out:    512 | Total:    768
10:15:45 | Model: claude-sonnet-4-5    | In:  1,024 | Out:  2,048 | Total:  3,072
```

## Quick Start

```bash
# 1. Start AI services
okonomi-ai-start

# 2. Check what's available and set your preferred model
okonomi-ai-list-models
okonomi-ai-set-model claude-sonnet-4-5

# 3. Chat with AI about your project (uses default model)
okonomi-ai-chat

# 4. Run an agent to help with code
okonomi-ai-agent "Review the login flow"

# 5. Create a new utility bin with AI!
okonomi-ai-create-bin

# 6. Check your token usage
okonomi-ai-odo
```

## Tab Completion

Type `okonomi-ai-` and press TAB to see all available commands.

## Architecture

These scripts are thin wrappers around the core `ai` command located at:
- `~/.local/bin/ai`
- `~/.config/ai/` (config directory)

They provide Okonomi-specific convenience commands that:
- Ensure services are running when needed
- Use sensible defaults for Okonomi development
- Are easy to type with the `okonomi-ai-` prefix

## Adding Custom Commands

Create a new script in `~/.local/bin/`:

```bash
#!/bin/bash
# ~/.local/bin/okonomi-ai-deploy

echo "Deploying Okonomi with AI assistance..."
# Your deployment logic here
```

Make it executable:
```bash
chmod +x ~/.local/bin/okonomi-ai-deploy
```

Now you can use: `okonomi-ai-deploy`

## See Also

- Core AI system: `ai help`
- Config: `~/.config/ai/`
- Data: `~/.local/share/ai/`
