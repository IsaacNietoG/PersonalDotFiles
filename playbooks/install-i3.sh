#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_package() {
    if pacman -Qi "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

install_package() {
    if ! check_package "$1"; then
        echo -e "${GREEN}Installing $1...${NC}"
        sudo pacman -S --noconfirm "$1"
    else
        echo -e "${YELLOW}$1 is already installed${NC}"
    fi
}

backup_file() {
    if [ -e "$1" ]; then
        echo -e "${YELLOW}Backing up $1 to $1.bak${NC}"
        mv "$1" "$1.bak"
    fi
}

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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${GREEN}=== Installing i3 Window Manager ===${NC}"

install_package "i3-wm"

install_package "plasma-meta"
install_package "plasma-x11-session"

install_package "picom"

install_package "feh"

install_package "rofi"

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

create_symlink "$REPO_ROOT/i3/config" ~/.config/i3/config

create_symlink "$REPO_ROOT/i3/plasma-i3.service" ~/.config/systemd/user/plasma-i3.service

systemctl mask plasma-kwin_x11.service --user

systemctl enable plasma-i3 --user
