#!/bin/bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Installing X11 WSL2 Configuration ===${NC}"

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

# Function to create backup of existing file
backup_file() {
    if [ -e "$1" ]; then
        echo -e "${YELLOW}Backing up $1 to $1.bak${NC}"
        mv "$1" "$1.bak"
    fi
}

# Function to append to file if not already present
append_if_not_present() {
    local file="$1"
    local line="$2"
    
    if ! grep -q "$line" "$file" 2>/dev/null; then
        echo -e "${GREEN}Adding X11 configuration to $file${NC}"
        echo "$line" >> "$file"
    else
        echo -e "${YELLOW}X11 configuration already present in $file${NC}"
    fi
}

# Function to update hosts file with Windows host IP
update_hosts_resolution() {
    echo -e "${GREEN}Updating hosts resolution for host.docker.internal...${NC}"
    
    # Get the Windows host IP from /etc/resolv.conf
    HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    
    if [ -z "$HOST_IP" ]; then
        echo -e "${RED}Error: Could not determine Windows host IP${NC}"
        return 1
    fi
    
    HOSTNAME="host.docker.internal"
    
    if grep -q "$HOSTNAME" /etc/hosts; then
        # Replace the existing entry
        sudo sed -i "s/.*$HOSTNAME/$HOST_IP $HOSTNAME/" /etc/hosts
        echo -e "${GREEN}Updated existing hosts entry for $HOSTNAME -> $HOST_IP${NC}"
    else
        # Append the new entry
        echo "$HOST_IP $HOSTNAME" | sudo tee -a /etc/hosts > /dev/null
        echo -e "${GREEN}Added hosts entry for $HOSTNAME -> $HOST_IP${NC}"
    fi
}

# Install X11 dependencies
echo -e "${GREEN}Installing X11 dependencies...${NC}"
install_package "xorg-xauth"
install_package "coreutils"
install_package "gawk"
install_package "xorg-apps"

# Update hosts resolution for host.docker.internal
update_hosts_resolution

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Get Windows username from WSL environment
WINDOWS_USERNAME=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')

if [ -z "$WINDOWS_USERNAME" ]; then
    echo -e "${YELLOW}Could not detect Windows username automatically.${NC}"
    read -p "Please enter your Windows username: " WINDOWS_USERNAME
fi

echo -e "${GREEN}Detected Windows username: $WINDOWS_USERNAME${NC}"

# Check if .Xauthority already exists and has entries
if [ -f ~/.Xauthority ] && xauth list 2>/dev/null | grep -q "host.docker.internal:0"; then
    echo -e "${YELLOW}Xauthority already configured for host.docker.internal:0${NC}"
else
    echo -e "${GREEN}Setting up Xauthority...${NC}"
    
    # Generate magic cookie
    MAGIC_COOKIE=$(echo "wsl2-x11-$(date +%s)" | tr -d '\n\r' | md5sum | gawk '{print $1}')
    
    # Add authorization for host.docker.internal:0
    xauth add host.docker.internal:0 . "$MAGIC_COOKIE"
    
    echo -e "${GREEN}Xauthority configured with magic cookie: $MAGIC_COOKIE${NC}"
fi

# Copy .Xauthority to Windows user directory
echo -e "\n${GREEN}Copying .Xauthority to Windows user directory...${NC}"
if [ -d "/mnt/c/Users/$WINDOWS_USERNAME" ]; then
    cp ~/.Xauthority "/mnt/c/Users/$WINDOWS_USERNAME/.Xauthority"
    echo -e "${GREEN}Copied .Xauthority to /mnt/c/Users/$WINDOWS_USERNAME/.Xauthority${NC}"
else
    echo -e "${RED}Error: Could not access Windows user directory${NC}"
    exit 1
fi

# Configure DISPLAY and hosts resolution in .profile for each session
echo -e "\n${GREEN}Configuring DISPLAY environment variable and hosts resolution...${NC}"

# Create a script to update hosts resolution
HOSTS_UPDATE_SCRIPT="$HOME/.update-hosts.sh"
cat > "$HOSTS_UPDATE_SCRIPT" << 'EOF'
#!/bin/bash
# Update hosts resolution for host.docker.internal
HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
if [ -n "$HOST_IP" ]; then
    HOSTNAME="host.docker.internal"
    if grep -q "$HOSTNAME" /etc/hosts; then
        sudo sed -i "s/.*$HOSTNAME/$HOST_IP $HOSTNAME/" /etc/hosts >/dev/null 2>&1
    else
        echo "$HOST_IP $HOSTNAME" | sudo tee -a /etc/hosts >/dev/null 2>&1
    fi
fi
EOF

chmod +x "$HOSTS_UPDATE_SCRIPT"

# Add hosts resolution and DISPLAY setup to .profile
PROFILE_LINES=(
    "# X11 WSL2 Configuration"
    "export DISPLAY=host.docker.internal:0"
    "# Update hosts resolution for host.docker.internal"
    "if [ -f ~/.update-hosts.sh ]; then"
    "    ~/.update-hosts.sh"
    "fi"
)

# Add each line to .profile if not already present
for line in "${PROFILE_LINES[@]}"; do
    append_if_not_present "$HOME/.profile" "$line"
done

# Create VcXSrv shortcut script
echo -e "\n${GREEN}Creating VcXSrv shortcut configuration...${NC}"
VCSXRV_CONFIG_DIR="/mnt/c/Users/$WINDOWS_USERNAME/Desktop"
VCSXRV_SHORTCUT="$VCSXRV_CONFIG_DIR/VcXSrv with XAuthority.bat"

# Create batch file for VcXSrv
cat > "$VCSXRV_SHORTCUT" << EOF
@echo off
"C:\Program Files\VcXSrv\VcXSrv.exe" -multiwindow -clipboard -wgl -auth "c:\users\\$WINDOWS_USERNAME\.Xauthority"
pause
EOF

echo -e "${GREEN}Created VcXSrv shortcut: $VCSXRV_SHORTCUT${NC}"

# Create PowerShell script for better error handling
POWERSHELL_SCRIPT="$VCSXRV_CONFIG_DIR/Start-VcXSrv.ps1"
cat > "$POWERSHELL_SCRIPT" << 'EOF'
param(
    [string]$Username = $env:USERNAME
)

$VcXSrvPath = "C:\Program Files\VcXSrv\VcXSrv.exe"
$XAuthorityPath = "C:\Users\$Username\.Xauthority"

if (Test-Path $VcXSrvPath) {
    if (Test-Path $XAuthorityPath) {
        Write-Host "Starting VcXSrv with XAuthority authentication..." -ForegroundColor Green
        & $VcXSrvPath -multiwindow -clipboard -wgl -auth $XAuthorityPath
    } else {
        Write-Host "Error: .Xauthority file not found at $XAuthorityPath" -ForegroundColor Red
        Write-Host "Please run the WSL2 X11 configuration playbook first." -ForegroundColor Yellow
    }
} else {
    Write-Host "Error: VcXSrv not found at $VcXSrvPath" -ForegroundColor Red
    Write-Host "Please install VcXSrv from: https://sourceforge.net/projects/vcxsrv/" -ForegroundColor Yellow
}
EOF

echo -e "${GREEN}Created PowerShell script: $POWERSHELL_SCRIPT${NC}"

echo -e "\n${GREEN}=== X11 WSL2 Configuration Complete ===${NC}"
echo -e "${BLUE}Next steps:${NC}"
echo -e "1. Install VcXSrv on Windows if not already installed"
echo -e "2. Start VcXSrv using the created shortcut on your Desktop"
echo -e "3. Enjoy"
echo -e ""
echo -e "${BLUE}Configuration details:${NC}"
echo -e "- Host resolution for host.docker.internal is updated at each session startup"
echo -e "- DISPLAY variable is set to host.docker.internal:0 in .profile"
echo -e "- A hosts update script is created at ~/.update-hosts.sh"
echo -e ""
echo -e "${YELLOW}Note: The configuration will take effect in new terminal sessions.${NC}" 