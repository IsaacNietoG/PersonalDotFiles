#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Installing Doom Emacs ===${NC}"

# Function to check if a package is installed
check_package() {
    if pacman -Qi "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install package if not already installed
install_package() {
    if ! check_package "$1"; then
        echo -e "${GREEN}Installing $1...${NC}"
        sudo pacman -S --noconfirm "$1"
    else
        echo -e "${YELLOW}$1 is already installed${NC}"
    fi
}

# Install Doom Emacs dependencies
echo -e "${GREEN}Installing Doom Emacs dependencies...${NC}"
install_package "emacs"
install_package "git"
install_package "ripgrep"

# Function to create backup of existing file
backup_file() {
    if [ -e "$1" ]; then
        echo -e "${YELLOW}Backing up $1 to $1.bak${NC}"
        mv "$1" "$1.bak"
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        echo -e "${YELLOW}Creating directory: $target_dir${NC}"
        mkdir -p "$target_dir"
    fi
    
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    backup_file "$target"
    ln -sf "$source" "$target"
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Install Doom Emacs
echo -e "\n${GREEN}Installing Doom Emacs...${NC}"
if [ ! -f "$HOME/.config/emacs/bin/doom" ]; then
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
    "$HOME/.config/emacs/bin/doom" install
else
    echo -e "${YELLOW}Doom Emacs is already installed${NC}"
fi

# Install Doom Emacs config
echo -e "\n${GREEN}Installing Doom Emacs config...${NC}"
create_symlink "$REPO_ROOT/doomEmacs/config.el" ~/.config/doom/config.el
create_symlink "$REPO_ROOT/doomEmacs/init.el" ~/.config/doom/init.el
create_symlink "$REPO_ROOT/doomEmacs/packages.el" ~/.config/doom/packages.el

# Sync Doom Emacs
echo -e "\n${GREEN}Syncing Doom Emacs...${NC}"
"$HOME/.config/emacs/bin/doom" sync

echo -e "\n${GREEN}=== Doom Emacs Installation Complete ===${NC}"
echo -e "${YELLOW}Note: You may need to restart Emacs for all changes to take effect.${NC}" 