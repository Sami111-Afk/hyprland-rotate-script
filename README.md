# 🔄 Hyprland Screen Rotation Script

![Bash](https://img.shields.io/badge/Shell_Script-Bash-green)
![WM](https://img.shields.io/badge/WM-Hyprland-blue)
![Arch](https://img.shields.io/badge/Distro-Arch_Linux-blue)

A robust shell script designed for 2-in-1 laptops (convertibles) running **Hyprland** on Arch Linux. It handles the simultaneous rotation of the display and the corresponding input transformation matrices for touchscreens and styluses (Wacom/ELAN).

## ✨ Features

- **Toggle Rotation**: Easily switch between normal (0°) and flipped (180°) orientations.
- **Input Sync**: Automatically applies the correct `input_transform` matrix to touchscreen and pen devices, preventing inverted or "mirrored" input while the screen is rotated.
- **Hyprland Native**: Uses `hyprctl` for real-time configuration without needing to restart the session.
- **Hardware Support**: Tested with Wacom and ELAN digitizers.

## 🛠️ Requirements

- **Hyprland** (Wayland compositor)
- **jq** (for parsing JSON output from `hyprctl`)
- **grep** & **bash**

## ⚙️ Configuration

Before running, you must identify and set your hardware names in the script:

1.  **Monitor**: Find your monitor name using `hyprctl monitors`. (eDP-1 is the default).
2.  **Input Devices**: List your devices with `hyprctl devices`. Look for your touchscreen and pen names.

Update these variables in `rotate.sh`:
```bash
MONITOR="eDP-1"
TOUCH_FINGER="your-touchscreen-device-name"
TOUCH_PEN="your-pen-device-name"
```

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
Add a bind to your `hyprland.conf` to rotate with a key combo:
```hyprlang
bind = $mainMod, R, exec, ~/scripts/rotate.sh
```

## 📊 Technical Details
The script uses the following transformation matrix for 180° rotation to ensure input alignment:
`MATRIX_180_FLIP="-1 0 1 0 -1 1"`
This matrix handles both the inversion and the necessary coordinate offset.
```
