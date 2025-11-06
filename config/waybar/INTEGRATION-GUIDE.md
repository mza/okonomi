# Waybar AI Widget Integration Guide

## What We Built

- **Script**: `~/.config/waybar/scripts/ai-status` - Reads metrics, outputs JSON
- **Config**: `config-snippets/ai-widget.json` - Waybar module definition
- **Style**: `style-snippets/ai-widget.css` - Visual styling

## How to Add to Your Waybar

### Step 1: Add to Config

Open your main Waybar config (usually `~/.config/waybar/config`):

```bash
nano ~/.config/waybar/config
```

Find the `"modules-right"` section and add `"custom/ai"`:

```json
{
  "modules-left": [...],
  "modules-center": [...],
  "modules-right": [
    "custom/ai",    // <-- Add this
    "pulseaudio",
    "clock",
    // ... your other modules
  ]
}
```

Then, in the same file, add the module definition. Find where other modules are defined and add:

```json
{
  // ... your existing modules ...

  "custom/ai": {
    "exec": "~/.config/waybar/scripts/ai-status",
    "return-type": "json",
    "interval": 2,
    "on-click": "ai-launch-odo",
    "on-click-right": "~/.local/bin/ai odo reset && notify-send 'AI Odometer' 'Trip reset'",
    "on-click-middle": "ai-launch-speed",
    "format": "{}"
  }
}
```

**Note**: Uses `ai-launch-odo` and `ai-launch-speed` launcher scripts that run commands in floating Alacritty windows with the `Imagine` window class. Integrates properly with Hyprland via uwsm-app following the same pattern as okonomi launchers.

### Step 2: Add Styling

Open your Waybar CSS (usually `~/.config/waybar/style.css`):

```bash
nano ~/.config/waybar/style.css
```

Add this at the end:

```css
/* AI Widget */
#custom-ai {
  padding: 0 10px;
  margin: 0 5px;
  border-radius: 5px;
  font-weight: bold;
}

#custom-ai.idle {
  color: #888888;
  background-color: rgba(136, 136, 136, 0.1);
}

#custom-ai.normal {
  color: #89b4fa;
  background-color: rgba(137, 180, 250, 0.1);
}

#custom-ai.live {
  color: #f38ba8;
  background-color: rgba(243, 139, 168, 0.15);
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

#custom-ai:hover {
  background-color: rgba(137, 180, 250, 0.2);
}
```

**Colors**: These use Catppuccin colors. Adjust to match your theme!

### Step 3: Reload Waybar

```bash
killall waybar && waybar &
```

Or press your Waybar reload keybind (often `Super+Shift+R` or similar)

## Features

### Display States

1. **Idle** (gray): ` idle` - No AI activity
2. **Normal** (blue): ` 6.5K` - Shows trip tokens
3. **Thinking** (red, pulsing): ` claude-sonnet-4-5 thinking...` - Request sent, waiting for first token
4. **Live** (red, pulsing): `⚡ gpt-oss 287 tok | 239 tok/s` - Active streaming

### Mouse Actions

- **Left Click**: Opens odometer in terminal
- **Right Click**: Resets trip odometer
- **Middle Click**: Opens speedometer
- **Hover**: Shows tooltip with breakdown

### Tooltip Info

Hover to see:
- Trip and lifetime totals
- Per-model breakdown
- Live request details (when active)

## Troubleshooting

**Widget not showing?**
- Check script is executable: `chmod +x ~/.config/waybar/scripts/ai-status`
- Test script manually: `~/.config/waybar/scripts/ai-status`
- Check Waybar logs: `journalctl -xeu waybar`

**Wrong terminal opens?**
- Edit the launcher script: `~/.local/bin/ai-launch-floating`
- Change `alacritty` to your preferred terminal

**Colors don't match theme?**
- Edit `style-snippets/ai-widget.css`
- Change the color values to match your theme

## How It Works

```
Every 2 seconds:
  Waybar → runs script → script reads metrics → outputs JSON
  Waybar → parses JSON → updates display → applies CSS class
```

**Live tracking**:
- Chat creates `/tmp/ai_live_request_*` when request starts
- Shows "thinking..." while waiting for first token (0 tokens, elapsed time > 0)
- Switches to live stats once tokens start streaming
- File removed when request completes
- Waybar returns to normal view

## Customization Ideas

**Shorter update interval** (more responsive):
```json
"interval": 1,  // Update every second
```

**Show lifetime instead of trip**:
Edit the script line 42 to use `.lifetime.total_tokens`

**Different format**:
Edit script line 61 to change the TEXT format

**Hide when idle**:
Add to CSS:
```css
#custom-ai.idle {
  display: none;
}
```
