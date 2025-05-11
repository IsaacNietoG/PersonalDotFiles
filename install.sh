#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to create backup of existing file
# param: $1 - file to backup
backup_file() {
    if [ -e "$1" ]; then
        echo -e "${YELLOW}Backing up $1 to $1.bak${NC}"
        mv "$1" "$1.bak"
    fi
}

# Function to create symlink
# param: $1 - source file
# param: $2 - target file
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

# Create necessary directories
echo -e "${GREEN}Creating necessary directories...${NC}"
mkdir -p ~/.config
mkdir -p ~/.local/share/fonts

# Select i3 configuration
echo -e "\n${GREEN}Select i3 configuration type:${NC}"
i3_config=$(select_config)

# Set wallpaper based on configuration
echo -e "\n${GREEN}Setting wallpaper...${NC}"
if [ "$i3_config" = "desktop" ]; then
    feh --bg-fill "$(pwd)/wallpapers/wallpaperDesktop.jpg"
else
    feh --bg-fill "$(pwd)/wallpapers/wallpaperLaptop.jpg"
fi

# Install i3 config
echo -e "\n${GREEN}Installing i3 config...${NC}"
create_symlink "$(pwd)/i3/${i3_config^}/config" ~/.config/i3/config

# Select polybar configuration
echo -e "\n${GREEN}Select polybar configuration type:${NC}"
polybar_config=$(select_config)

# Install polybar config
echo -e "\n${GREEN}Installing polybar config...${NC}"
create_symlink "$(pwd)/polybar/${polybar_config}/config" ~/.config/polybar/config
create_symlink "$(pwd)/polybar/launch.sh" ~/.config/polybar/launch.sh

# Install dunst config
echo -e "\n${GREEN}Installing dunst config...${NC}"
create_symlink "$(pwd)/dunst/dunstrc" ~/.config/dunst/dunstrc

# Install Doom Emacs config
echo -e "\n${GREEN}Installing Doom Emacs config...${NC}"
create_symlink "$(pwd)/doomEmacs/config.el" ~/.doom.d/config.el
create_symlink "$(pwd)/doomEmacs/init.el" ~/.doom.d/init.el
create_symlink "$(pwd)/doomEmacs/packages.el" ~/.doom.d/packages.el

# Sync Doom Emacs
echo -e "\n${GREEN}Syncing Doom Emacs...${NC}"
~/.config/emacs/bin/doom sync

# Install Oh My Zsh config
echo -e "\n${GREEN}Installing Oh My Zsh config...${NC}"
create_symlink "$(pwd)/OhMyZsh/.zshrc" ~/.zshrc
create_symlink "$(pwd)/OhMyZsh/custom" ~/.oh-my-zsh/custom
source ~/.zshrc

# Install scripts
echo -e "\n${GREEN}Installing scripts...${NC}"
create_symlink "$(pwd)/Scripts" ~/.local/bin

echo -e "\n${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}Note: You may need to restart your applications for changes to take effect.${NC}" 
