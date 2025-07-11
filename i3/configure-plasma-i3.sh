#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Configuring Plasma to use i3 as window manager (X11)...${NC}"

# Create systemd user directory if it doesn't exist
mkdir -p ~/.config/systemd/user

# Copy the service file
echo -e "${YELLOW}Installing i3 Plasma service...${NC}"
cp "$(dirname "$0")/plasma-i3.service" ~/.config/systemd/user/

# Reload systemd user daemon
echo -e "${YELLOW}Reloading systemd user daemon...${NC}"
systemctl --user daemon-reload

# Enable the service
echo -e "${YELLOW}Enabling i3 Plasma service...${NC}"
systemctl --user enable plasma-i3.service

# Configure Plasma to use i3 (X11 specific)
echo -e "${YELLOW}Configuring Plasma settings for X11...${NC}"

# Configure Plasma for X11 with i3
kwriteconfig5 --file ~/.config/kwinrc --group Compositing --key UnredirectFullScreen false
kwriteconfig5 --file ~/.config/kwinrc --group General --key XwaylandCrashPolicy 1

# X11 specific configurations
kwriteconfig5 --file ~/.config/kwinrc --group General --key X11CrashPolicy 1
kwriteconfig5 --file ~/.config/kwinrc --group General --key X11WindowScale 1

# Disable KWin for X11
kwriteconfig5 --file ~/.config/kwinrc --group General --key X11CrashPolicy 1

echo -e "${GREEN}Plasma i3 configuration for X11 complete!${NC}"
echo -e "${YELLOW}Note: You may need to log out and log back in for changes to take effect.${NC}"
echo -e "${GREEN}To start using i3 with Plasma (X11), restart your session or run: systemctl --user start plasma-i3.service${NC}" 