# Okonomi

Turn a fresh Arch Linux installation into a fully-configured, beautiful, and modern desktop system based on Hyprland by running a single command.

## Installation

On a fresh Arch Linux system, run:

```bash
curl -sSL https://raw.githubusercontent.com/youruser/okonomi/master/install.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/youruser/okonomi.git
cd okonomi
./install.sh
```

## What's Included

- **Hyprland** - Modern Wayland compositor
- **Waybar** - Customizable status bar
- **greetd** - Minimal display manager
- **Kitty** - Modern terminal emulator
- **Rofi** - Application launcher
- And more!

## Requirements

- Fresh Arch Linux installation
- Internet connection
- Sudo access (or run as root)

## Project Structure

```
okonomi/
├── install.sh          # Main installer entry point
├── install/            # Modular installation components
│   ├── preflight/      # Pre-install checks
│   ├── packaging/      # Package installation
│   ├── config/         # Configuration application
│   └── post-install/   # Final setup
├── migrations/         # Configuration scripts
├── config/             # Dotfiles and configs
└── default/            # System defaults
```

## Development

Migrations are idempotent and tracked in `~/.local/state/okonomi/migrations/`.

To add new configurations:
1. Create a new migration in `migrations/`
2. Run `./migrations/apply` to test
3. Migrations run automatically during install

## Related Projects

- **okonomi-installer-iso** - Bootable ISO that installs Arch + Okonomi
- **okonomi-live-iso** - Live demo environment

## License

MIT
