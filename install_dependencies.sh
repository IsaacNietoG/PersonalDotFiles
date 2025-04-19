#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Update system first
echo -e "${GREEN}Updating system...${NC}"
sudo pacman -Syu --noconfirm

# Core packages
echo -e "\n${GREEN}Installing core packages...${NC}"
install_package "i3-wm"
install_package "polybar"
install_package "dunst"
install_package "feh"
install_package "picom"
install_package "zsh"
install_package "oh-my-zsh-git"
install_package "emacs"
install_package "rofi"
install_package "rofi-themes-collection"

# Language support
echo -e "\n${GREEN}Installing language support...${NC}"
install_package "jdk-openjdk"
install_package "python"

# Optional packages
echo -e "\n${GREEN}Installing optional packages...${NC}"
install_package "i3status"
install_package "curl"
install_package "git"

# For KDE integration (optional)
echo -e "\n${GREEN}Installing KDE integration packages...${NC}"
install_package "plasma-desktop"

# Install Doom Emacs
echo -e "\n${GREEN}Installing Doom Emacs...${NC}"
if [ ! -d "$HOME/.emacs.d" ]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
else
    echo -e "${YELLOW}Doom Emacs is already installed${NC}"
fi

# Install Oh My Zsh if not already installed
echo -e "\n${GREEN}Installing Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${YELLOW}Oh My Zsh is already installed${NC}"
fi

echo -e "\n${GREEN}All dependencies have been installed!${NC}"
echo -e "${YELLOW}Note: You may need to log out and log back in for some changes to take effect.${NC}" 