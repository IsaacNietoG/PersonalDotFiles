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

# Core i3 + Plasma packages
echo -e "\n${GREEN}Installing core i3 + Plasma packages...${NC}"
install_package "i3-wm"
install_package "feh"
install_package "picom"
install_package "rofi"
install_package "wmctrl"

# Shell and terminal
echo -e "\n${GREEN}Installing shell and terminal packages...${NC}"
install_package "zsh"
install_package "oh-my-zsh-git"

# Editor
echo -e "\n${GREEN}Installing editor...${NC}"
install_package "emacs"

# KDE/Plasma integration packages
echo -e "\n${GREEN}Installing KDE/Plasma integration packages...${NC}"
install_package "plasma-desktop"
install_package "kde-applications"

# Language support
echo -e "\n${GREEN}Installing language support...${NC}"
install_package "jdk-openjdk"
install_package "python"

# Optional utilities
echo -e "\n${GREEN}Installing utility packages...${NC}"
install_package "curl"
install_package "git"

# Install adi1090x's rofi themes
echo -e "\n${GREEN}Installing adi1090x's rofi themes...${NC}"
if [ ! -d "$HOME/.config/rofi" ]; then
    git clone --depth 1 https://github.com/adi1090x/rofi.git /tmp/rofi
    cd /tmp/rofi
    chmod +x setup.sh
    ./setup.sh
    cd - > /dev/null
    rm -rf /tmp/rofi
else
    echo -e "${YELLOW}Rofi themes are already installed${NC}"
fi

# Install Doom Emacs
echo -e "\n${GREEN}Installing Doom Emacs...${NC}"
if [ ! -d "$HOME/.emacs.d" ]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs
    ~/.config/emacs/bin/doom install
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
echo -e "${GREEN}Your system is now ready for i3 + Plasma setup!${NC}" 
