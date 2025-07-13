#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Installing Oh My Zsh ===${NC}"

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

# Install Oh My Zsh dependencies
echo -e "${GREEN}Installing Oh My Zsh dependencies...${NC}"
install_package "zsh"
install_package "oh-my-zsh-git"
install_package "curl"

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

# Install Oh My Zsh if not already installed
echo -e "\n${GREEN}Installing Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${YELLOW}Oh My Zsh is already installed${NC}"
fi

# Install Oh My Zsh config
echo -e "\n${GREEN}Installing Oh My Zsh config...${NC}"
create_symlink "$REPO_ROOT/OhMyZsh/.zshrc" ~/.zshrc

# Create custom directory if it doesn't exist
if [ ! -d "$HOME/.oh-my-zsh/custom" ]; then
    mkdir -p ~/.oh-my-zsh/custom
fi

# Source the new .zshrc to load the configuration
echo -e "\n${GREEN}Loading new configuration...${NC}"
source ~/.zshrc

echo -e "\n${GREEN}=== Oh My Zsh Installation Complete ===${NC}"
echo -e "${YELLOW}Note: You may need to restart your terminal for all changes to take effect.${NC}" 