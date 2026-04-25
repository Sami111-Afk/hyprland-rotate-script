# 🔄 Hyprland Screen Rotation Script

![Bash](https://img.shields.io/badge/Shell_Script-Bash-green)
![WM](https://img.shields.io/badge/WM-Hyprland-blue)
![Arch](https://img.shields.io/badge/Distro-Arch_Linux-blue)

A robust shell script designed for 2-in-1 laptops (convertibles) running **Hyprland** on Arch Linux. It handles the simultaneous rotation of the display and the corresponding input transformations for touchscreens, styluses, and trackpads.

## ✨ Features

- **Toggle Rotation**: Easily switch between normal (0°) and flipped (180°) orientations.
- **Auto-Detection**: Automatically identifies Wacom and ELAN input devices (touchscreen, pen, and trackpad).
- **Input Sync**: Applies the correct transformation to all input devices, ensuring that "up" is always "up" on the screen, even for the mouse/trackpad.
- **Improved Stability**: Uses a temporary configuration source to apply settings reliably across all Hyprland versions.
- **Hyprland Native**: Uses `hyprctl` for real-time configuration without needing to restart the session.

## 🛠️ Requirements

- **Hyprland** (Wayland compositor)
- **jq** (for parsing JSON output from `hyprctl`)
- **grep** & **bash**

## ⚙️ Configuration

The script is now largely automated. You only need to verify your monitor name:

1.  **Monitor**: Find your monitor name using `hyprctl monitors`. (`eDP-1` is the default).
2.  If your monitor is not `eDP-1`, update the `MONITOR` variable at the beginning of `rotate.sh`.

## 🚀 Usage

Make the script executable:
```bash
chmod +x rotate.sh
```

Run it to toggle orientation:
```bash
./rotate.sh
```

### Keybinding Tip
Add a bind to your `hyprland.conf` to rotate with a key combo (e.g., Alt + R):
```hyprlang
bind = Alt, R, exec, ~/scripts/rotate.sh
```

## 📊 Technical Details
The script generates a temporary configuration in `/tmp/hypr_rotate.conf` which is then sourced by Hyprland. This ensures that even devices with special characters in their names (like `:` in ELAN devices) are correctly configured with the appropriate `transform` and `output` mapping.
