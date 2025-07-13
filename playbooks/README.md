# Personal Dotfiles Playbooks

This directory contains modular installation scripts (playbooks) for different components of the Personal Dotfiles setup. Each playbook is completely self-contained and installs its own dependencies.

## Overview

The playbook system allows you to install components individually or in combination, making the setup process more flexible and maintainable. Each playbook handles its own dependencies, making them truly modular and independent.

## Available Playbooks

### Individual Playbooks

- **`install-ohmyzsh.sh`** - Installs and configures Oh My Zsh (includes zsh, oh-my-zsh-git, curl)
- **`install-doom-emacs.sh`** - Installs and configures Doom Emacs (includes emacs, git, ripgrep)
- **`install-i3.sh`** - Installs and configures i3 Window Manager (includes i3-wm, i3status, feh, picom, rofi)
- **`install-polybar.sh`** - Installs and configures Polybar (includes polybar, fonts)
- **`install-dunst.sh`** - Installs and configures Dunst notification daemon (includes dunst, libnotify)
- **`install-scripts.sh`** - Installs custom scripts (includes bash, coreutils, util-linux)
- **`install-x11-wsl2.sh`** - Installs X11 WSL2 configuration (includes xorg-xauth, coreutils, gawk, xorg-apps)

### Master Playbook

- **`install-all.sh`** - Master script that can run any combination of playbooks

## Usage

### Using the Master Playbook

```bash
# Install everything
./playbooks/install-all.sh --all

# Install specific components
./playbooks/install-all.sh --i3 --polybar

# Install with short options
./playbooks/install-all.sh -z -e

# Install X11 WSL2 configuration only
./playbooks/install-all.sh -x

# Show help
./playbooks/install-all.sh --help
```

### Using Individual Playbooks

```bash
# Install Oh My Zsh (includes dependencies)
./playbooks/install-ohmyzsh.sh

# Install Doom Emacs (includes dependencies)
./playbooks/install-doom-emacs.sh

# Install i3 Window Manager (includes dependencies)
./playbooks/install-i3.sh

# Install Polybar (includes dependencies)
./playbooks/install-polybar.sh

# Install Dunst (includes dependencies)
./playbooks/install-dunst.sh

# Install custom scripts (includes dependencies)
./playbooks/install-scripts.sh

# Install X11 WSL2 configuration (includes dependencies)
./playbooks/install-x11-wsl2.sh
```

## Features

- **True Modularity**: Each playbook installs its own dependencies
- **Independent Operation**: Can run any playbook without depending on others
- **Safe Installation**: Backs up existing configurations before overwriting
- **Flexible Configuration**: Choose between Desktop/Laptop configurations for i3 and Polybar
- **Robust Path Handling**: Works with symlinks and different directory structures
- **Color-coded Output**: Easy to follow installation progress
- **Error Handling**: Stops on errors and provides clear feedback

## Installation Order

Since each playbook is independent, you can install them in any order:

1. **Oh My Zsh** (`install-ohmyzsh.sh`)
2. **Doom Emacs** (`install-doom-emacs.sh`)
3. **i3 Window Manager** (`install-i3.sh`)
4. **Polybar** (`install-polybar.sh`)
5. **Dunst** (`install-dunst.sh`)
6. **Custom Scripts** (`install-scripts.sh`)
7. **X11 WSL2 Configuration** (`install-x11-wsl2.sh`)

Or simply use:
```bash
./playbooks/install-all.sh --all
```

## Dependencies Installed by Each Playbook

### Oh My Zsh
- `zsh`
- `oh-my-zsh-git`
- `curl`

### Doom Emacs
- `emacs`
- `git`
- `ripgrep`

### i3 Window Manager
- `i3-wm`
- `i3status`
- `feh`
- `picom`
- `rofi`
- adi1090x's rofi themes

### Polybar
- `polybar`
- `ttf-font-awesome`
- `ttf-nerd-fonts-symbols`

### Dunst
- `dunst`
- `libnotify`

### Custom Scripts
- `bash`
- `coreutils`
- `util-linux`

### X11 WSL2 Configuration
- `xorg-xauth`
- `coreutils`
- `gawk`
- `xorg-apps`

## Special Features

### X11 WSL2 Configuration

The X11 WSL2 playbook provides a complete setup for running X11 applications in WSL2:

- **Automatic Xauthority Setup**: Creates secure authentication between WSL2 and VcXSrv
- **Windows Integration**: Creates VcXSrv shortcuts on Windows Desktop
- **Environment Configuration**: Sets up DISPLAY variable in shell configs

**Prerequisites for X11 WSL2:**
- VcXSrv installed on Windows
- WSL2 environment

**After running the X11 playbook:**
1. Start VcXSrv using the created shortcut on Windows Desktop

## Notes

- All playbooks create backups of existing configurations (`.bak` files)
- Each playbook checks if dependencies are already installed before installing
- Some components require restarting applications to take effect
- The scripts handle symlinks properly using real paths
- Each playbook is self-contained and can be run independently

## Troubleshooting

If you encounter issues:

1. Each playbook handles its own dependencies, so no need to install dependencies separately
2. Ensure you have proper permissions (some operations require sudo)
3. Restart applications after installation
4. Check backup files (`.bak`) if configurations are missing
5. Run individual playbooks to isolate issues

### X11 WSL2 Specific Troubleshooting

1. **Connection refused:**
   - Ensure VcXSrv is running on Windows
   - Check that .Xauthority file exists in Windows user directory

2. **Authentication failed:**
   - Re-run the X11 playbook to regenerate Xauthority
   - Restart VcXSrv

3. **DISPLAY not set:**
   - Restart your terminal or run: `source ~/.bashrc` or `source ~/.zshrc` 