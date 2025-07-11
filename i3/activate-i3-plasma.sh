#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Activating i3 + Plasma integration...${NC}"

# Check if the service file exists
if [ ! -f ~/.config/systemd/user/plasma-i3.service ]; then
    echo -e "${RED}Error: plasma-i3.service not found. Run install.sh first.${NC}"
    exit 1
fi

# Reload systemd user daemon
echo -e "${YELLOW}Reloading systemd user daemon...${NC}"
systemctl --user daemon-reload

# Enable the service
echo -e "${YELLOW}Enabling i3 Plasma service...${NC}"
systemctl --user enable plasma-i3.service

# Start the service
echo -e "${YELLOW}Starting i3 Plasma service...${NC}"
systemctl --user start plasma-i3.service

echo -e "${GREEN}i3 + Plasma integration activated!${NC}"
echo -e "${YELLOW}Note: You may need to restart your session for full integration.${NC}"
echo -e "${GREEN}To check status: systemctl --user status plasma-i3.service${NC}" 