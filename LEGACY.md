# Legacy Dotfiles

This document tracks dotfiles that are no longer used in the current i3 + Plasma setup but are preserved for reference or potential future use.

## Overview

These dotfiles were part of the original setup but are no longer needed since switching to i3 + Plasma workflow. They are kept for:
- Reference and learning purposes
- Potential future use if switching back to standalone tools
- Historical documentation of the setup evolution

## Legacy Components

### Polybar (Status Bar)
**Location:** `polybar/`
**Status:** ❌ **LEGACY** - No longer used
**Reason:** Using Plasma's native panel instead of standalone status bar
**Files:**
- `polybar/desktop/config.ini` - Desktop polybar configuration
- `polybar/laptop/config.ini` - Laptop polybar configuration  
- `polybar/launch.sh` - Polybar launch script

**Alternative:** Plasma's native panel provides all necessary functionality

### Dunst (Notification Daemon)
**Location:** `dunst/`
**Status:** ❌ **LEGACY** - No longer used
**Reason:** Using Plasma's native notification system
**Files:**
- `dunst/dunstrc` - Dunst notification configuration

**Alternative:** Plasma's notification system is more integrated and feature-rich

### Unused Scripts
**Location:** `Scripts/`
**Status:** ⚠️ **REVIEW NEEDED** - Some scripts may be unused

#### Potentially Unused Scripts:
- `Scripts/changeVolume` - Volume control script (Plasma has native controls)
- `Scripts/devMode` - Development mode script (review if still needed)
- `Scripts/dockedMode` - Docking mode script (review if still needed)
- `Scripts/update-hosts` - Hosts file update script (review if still needed)

#### Still Used Scripts:
- `Scripts/mount_google_drive.sh` - ✅ **ACTIVE** - Still used in i3 config

## Current Active Setup

### Core Components:
- ✅ **i3 Window Manager** - Main window manager
- ✅ **Plasma Desktop** - Desktop environment integration
- ✅ **Picom** - Compositor for visual effects
- ✅ **Rofi** - Application launcher
- ✅ **Doom Emacs** - Text editor
- ✅ **Oh My Zsh** - Shell configuration
- ✅ **Feh** - Wallpaper management

### Configuration Files:
- `i3/Desktop/config` - Desktop i3 configuration
- `i3/Laptop/config` - Laptop i3 configuration
- `doomEmacs/` - Doom Emacs configuration
- `OhMyZsh/` - Zsh configuration
- `wallpapers/` - Wallpaper files

## Migration Notes

### From Polybar to Plasma Panel:
- System tray icons now handled by Plasma
- Workspace indicators use Plasma's native workspace switcher
- System information available through Plasma widgets

### From Dunst to Plasma Notifications:
- Notifications now use Plasma's native system
- Better integration with KDE applications
- More customization options through Plasma settings

## Future Considerations

If you ever want to:
1. **Switch back to standalone tools:** Legacy files are preserved
2. **Use on non-Plasma systems:** Polybar and Dunst configs are available
3. **Customize further:** Reference the legacy configurations for ideas

## Cleanup Options

When you're confident these are no longer needed, you can:
1. Move them to a separate `legacy/` directory
2. Delete them entirely
3. Keep them as reference material

---

*Last updated: $(date)*
*Current setup: i3 + Plasma* 