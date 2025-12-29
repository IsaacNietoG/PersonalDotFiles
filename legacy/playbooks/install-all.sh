#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to show usage
show_usage() {
    echo -e "${BLUE}Usage: $0 [OPTIONS]${NC}"
    echo -e "${BLUE}Options:${NC}"
    echo -e "  -a, --all              Install all components"
    echo -e "  -z, --ohmyzsh          Install Oh My Zsh"
    echo -e "  -e, --doom-emacs       Install Doom Emacs"
    echo -e "  -i, --i3               Install i3 Window Manager"
    echo -e "  -p, --polybar          Install Polybar"
    echo -e "  -u, --dunst            Install Dunst"
    echo -e "  -s, --scripts          Install custom scripts"
    echo -e "  -x, --x11-wsl2         Install X11 WSL2 configuration"
    echo -e "  -h, --help             Show this help message"
    echo -e ""
    echo -e "${BLUE}Examples:${NC}"
    echo -e "  $0 --all                    # Install everything"
    echo -e "  $0 --i3 --polybar          # Install i3 and polybar only"
    echo -e "  $0 -z -e                    # Install Oh My Zsh and Doom Emacs"
    echo -e "  $0 -x                       # Install X11 WSL2 configuration only"
}

# Function to run a playbook
run_playbook() {
    local playbook="$1"
    local playbook_path="$SCRIPT_DIR/$playbook"
    
    if [ -f "$playbook_path" ]; then
        echo -e "\n${GREEN}Running $playbook...${NC}"
        bash "$playbook_path"
    else
        echo -e "${RED}Error: Playbook $playbook not found!${NC}"
        exit 1
    fi
}

# Parse command line arguments
if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

# Flags for each component
INSTALL_OHMYZSH=false
INSTALL_DOOM_EMACS=false
INSTALL_I3=false
INSTALL_POLYBAR=false
INSTALL_DUNST=false
INSTALL_SCRIPTS=false
INSTALL_X11_WSL2=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--all)
            INSTALL_OHMYZSH=true
            INSTALL_DOOM_EMACS=true
            INSTALL_I3=true
            INSTALL_POLYBAR=true
            INSTALL_DUNST=true
            INSTALL_SCRIPTS=true
            INSTALL_X11_WSL2=true
            shift
            ;;
        -z|--ohmyzsh)
            INSTALL_OHMYZSH=true
            shift
            ;;
        -e|--doom-emacs)
            INSTALL_DOOM_EMACS=true
            shift
            ;;
        -i|--i3)
            INSTALL_I3=true
            shift
            ;;
        -p|--polybar)
            INSTALL_POLYBAR=true
            shift
            ;;
        -u|--dunst)
            INSTALL_DUNST=true
            shift
            ;;
        -s|--scripts)
            INSTALL_SCRIPTS=true
            shift
            ;;
        -x|--x11-wsl2)
            INSTALL_X11_WSL2=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_usage
            exit 1
            ;;
    esac
done

# Check if at least one component is selected
if [ "$INSTALL_OHMYZSH" = false ] && [ "$INSTALL_DOOM_EMACS" = false ] && [ "$INSTALL_I3" = false ] && [ "$INSTALL_POLYBAR" = false ] && [ "$INSTALL_DUNST" = false ] && [ "$INSTALL_SCRIPTS" = false ] && [ "$INSTALL_X11_WSL2" = false ]; then
    echo -e "${RED}Error: No components selected for installation.${NC}"
    show_usage
    exit 1
fi

echo -e "${GREEN}=== Personal Dotfiles Installation ===${NC}"
echo -e "${BLUE}Selected components:${NC}"

if [ "$INSTALL_OHMYZSH" = true ]; then
    echo -e "  ✓ Oh My Zsh"
fi
if [ "$INSTALL_DOOM_EMACS" = true ]; then
    echo -e "  ✓ Doom Emacs"
fi
if [ "$INSTALL_I3" = true ]; then
    echo -e "  ✓ i3 Window Manager"
fi
if [ "$INSTALL_POLYBAR" = true ]; then
    echo -e "  ✓ Polybar"
fi
if [ "$INSTALL_DUNST" = true ]; then
    echo -e "  ✓ Dunst"
fi
if [ "$INSTALL_SCRIPTS" = true ]; then
    echo -e "  ✓ Custom Scripts"
fi
if [ "$INSTALL_X11_WSL2" = true ]; then
    echo -e "  ✓ X11 WSL2 Configuration"
fi

echo -e "\n${YELLOW}Starting installation...${NC}"

# Run selected playbooks
if [ "$INSTALL_OHMYZSH" = true ]; then
    run_playbook "install-ohmyzsh.sh"
fi

if [ "$INSTALL_DOOM_EMACS" = true ]; then
    run_playbook "install-doom-emacs.sh"
fi

if [ "$INSTALL_I3" = true ]; then
    run_playbook "install-i3.sh"
fi

if [ "$INSTALL_POLYBAR" = true ]; then
    run_playbook "install-polybar.sh"
fi

if [ "$INSTALL_DUNST" = true ]; then
    run_playbook "install-dunst.sh"
fi

if [ "$INSTALL_SCRIPTS" = true ]; then
    run_playbook "install-scripts.sh"
fi

if [ "$INSTALL_X11_WSL2" = true ]; then
    run_playbook "install-x11-wsl2.sh"
fi

echo -e "\n${GREEN}=== Installation Complete! ===${NC}"
echo -e "${YELLOW}Note: You may need to restart your applications for changes to take effect.${NC}" 