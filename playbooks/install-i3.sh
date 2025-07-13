#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Installing i3 Window Manager ===${NC}"

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

# Install i3 dependencies
echo -e "${GREEN}Installing i3 dependencies...${NC}"
install_package "i3-wm"
install_package "i3status"
install_package "feh"
install_package "picom"
install_package "rofi"

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

# Function to select configuration type
select_config() {
    local config_type
    PS3="Select configuration type (1-2): "
    select config_type in "Desktop" "Laptop"; do
        case $config_type in
            "Desktop")
                echo "desktop"
                break
                ;;
            "Laptop")
                echo "laptop"
                break
                ;;
            *)
                echo -e "${RED}Invalid selection${NC}"
                ;;
        esac
    done
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Create necessary directories
echo -e "\n${GREEN}Creating necessary directories...${NC}"
mkdir -p ~/.config

# Select i3 configuration
echo -e "\n${GREEN}Select i3 configuration type:${NC}"
i3_config=$(select_config)

# Install i3 config
echo -e "\n${GREEN}Installing i3 config...${NC}"
create_symlink "$REPO_ROOT/i3/${i3_config^}/config" ~/.config/i3/config

# Set wallpaper based on configuration
echo -e "\n${GREEN}Setting wallpaper...${NC}"
if [ "$i3_config" = "desktop" ]; then
    feh --bg-fill "$REPO_ROOT/wallpapers/wallpaperDesktop.jpg"
else
    feh --bg-fill "$REPO_ROOT/wallpapers/wallpaperLaptop.jpg"
fi

echo -e "\n${GREEN}=== i3 Window Manager Installation Complete ===${NC}"
echo -e "${YELLOW}Note: You may need to restart i3 for changes to take effect.${NC}" 