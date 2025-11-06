# Bins Registry

A registry system for managing utility applications and scripts ("bins") in your AI OS.

## What are Bins?

Bins are utility applications/scripts that:
- Live in `~/.local/share/ai/bins/`
- Are tracked in a central registry (`registry.json`)
- Have metadata (version, description, author, timestamps)
- Can be installed to `~/.local/bin/` for easy access
- Can be plugged into other parts of your OS

Think of it as a lightweight package manager for your custom tools.

## Architecture

```
~/.config/ai/bins/
└── registry.json          # Central registry with metadata

~/.local/share/ai/bins/
├── my-tool                # Actual bin files
├── another-util
└── ...

~/.local/bin/
├── my-tool -> ~/.local/share/ai/bins/my-tool  # Symlinks when installed
└── ...
```

## Commands

### List Bins
```bash
ai bin list    # or: ai bin ls
```

Shows all registered bins with:
- Name
- Version
- Status (installed, available, missing)
- Description

### Add a Bin
```bash
ai bin add my-tool
```

Interactive wizard that prompts for:
- Version (default: 1.0.0)
- Description
- Author
- Source (create new template or import existing)

Creates the bin file and registers it.

### Remove a Bin
```bash
ai bin remove my-tool    # or: ai bin rm
```

Removes:
- Registry entry
- Bin file from `~/.local/share/ai/bins/`
- Symlink from `~/.local/bin/` (if installed)

### Show Bin Info
```bash
ai bin info my-tool
```

Shows detailed metadata:
- Version, description, author
- Created/updated timestamps
- File path and status
- Installation status

### Install a Bin
```bash
ai bin install my-tool
```

Creates a symlink in `~/.local/bin/` so you can run it from anywhere:
```bash
my-tool    # Now works from any directory!
```

### Uninstall a Bin
```bash
ai bin uninstall my-tool
```

Removes the symlink from `~/.local/bin/` but keeps the bin in the registry.

### Update Bin Metadata
```bash
ai bin update my-tool
```

Update version and description. Useful after modifying a bin.

## Example Workflow

### Creating a New Bin

```bash
# 1. Add a new bin
$ ai bin add hello-world

Version [1.0.0]:
Description: Says hello to the world
Author: mza
Source options:
  1) Create new script
  2) Import existing file
Choice [1]: 1

✓ Created template at ~/.local/share/ai/bins/hello-world
✓ Registered hello-world

Next steps:
  1. Edit: ~/.local/share/ai/bins/hello-world
  2. Install: ai bin install hello-world

# 2. Edit the bin
$ nano ~/.local/share/ai/bins/hello-world

# 3. Test it directly
$ ~/.local/share/ai/bins/hello-world

# 4. Install it
$ ai bin install hello-world
✓ Installed hello-world to ~/.local/bin

# 5. Use it from anywhere
$ hello-world
Hello from hello-world!
```

### Importing an Existing Script

```bash
# Add existing script
$ ai bin add my-existing-tool

Version [1.0.0]: 2.1.0
Description: Tool I already built
Author: mza
Source options:
  1) Create new script
  2) Import existing file
Choice [1]: 2
Path to existing script: /home/mza/scripts/my-tool.sh

✓ Copied to ~/.local/share/ai/bins/my-existing-tool
✓ Registered my-existing-tool

# Install and use
$ ai bin install my-existing-tool
$ my-existing-tool
```

## Registry Format

The `registry.json` file tracks all bins:

```json
{
  "version": "1.0",
  "bins": {
    "my-tool": {
      "version": "1.0.0",
      "description": "Does something useful",
      "author": "mza",
      "created": "2025-11-05T15:30:00Z",
      "updated": "2025-11-05T15:30:00Z",
      "path": "/home/mza/.local/share/ai/bins/my-tool"
    }
  }
}
```

## Use Cases

### AI-Generated Tools
When an AI agent creates a useful utility:
```bash
ai agent "Create a JSON formatter tool"
# Agent creates the tool
ai bin add json-fmt
# Choose option 2, import the AI-generated file
ai bin install json-fmt
```

### Project-Specific Utilities
```bash
ai bin add okonomi-deploy
# Edit to add deployment logic
ai bin install okonomi-deploy
# Now: okonomi-deploy production
```

### Integration with OS
Bins can be:
- Called by other scripts
- Used in cron jobs
- Integrated into other parts of your AI OS
- Shared via git (registry.json + bin files)

## Future Enhancements

- [ ] Versioning support (semantic versioning)
- [ ] Dependencies between bins
- [ ] Remote repositories (install from URLs)
- [ ] Update checking
- [ ] Bin categories/tags
- [ ] Search functionality
- [ ] Export/import bins
- [ ] Auto-documentation generation

## Tips

- Use clear, descriptive names
- Include version numbers in your bins
- Add helpful `--help` flags to your bins
- Document your bins inline with comments
- Keep bins focused (do one thing well)
- Use the registry to track what you've built

## Example Bin Template

```bash
#!/bin/bash
# Tool Name - Short description
# Usage: tool-name [options]

set -e

show_help() {
    echo "Usage: tool-name [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help"
    echo "  -v, --version  Show version"
}

case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    -v|--version)
        echo "tool-name v1.0.0"
        exit 0
        ;;
esac

# Your tool logic here
echo "Hello from tool-name!"
```
