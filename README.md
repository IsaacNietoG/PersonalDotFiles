# Personal DotFiles

Este repositorio contiene mis configuraciones personalizadas para un setup de **i3 Window Manager** integrado con **Plasma Desktop**, junto con **Doom Emacs** y **Oh My ZSH**. Las configuraciones están organizadas para mi computadora de escritorio y mi laptop.

## 🎯 Setup Actual: i3 + Plasma

Mi configuración actual utiliza **i3 como window manager** dentro del entorno **Plasma Desktop**, aprovechando lo mejor de ambos mundos:
- **i3** para gestión eficiente de ventanas y tiling
- **Plasma** para integración del sistema, notificaciones y panel nativo

### 🔧 Integración Automática
El setup incluye **integración automática** de i3 con Plasma mediante:
- **Systemd user service** que reemplaza KWin con i3
- **Configuración automática** de Plasma para usar i3
- **Variables de entorno** optimizadas para la integración

## 📁 Contenido

### ✅ Componentes Activos
- **i3 Window Manager**: Configuración optimizada para integración con Plasma
  - `i3/Desktop/config` - Configuración para escritorio
  - `i3/Laptop/config` - Configuración para laptop
  - `i3/plasma-i3.service` - Systemd service para integración
  - `i3/configure-plasma-i3.sh` - Script de configuración automática
  - `i3/activate-i3-plasma.sh` - Script de activación manual
- **Doom Emacs**: Configuración personalizada para productividad
- **Oh My ZSH**: Configuración de shell con framework Oh My ZSH
- **Wallpapers**: Fondos de pantalla para cada setup
- **Scripts**: Scripts esenciales (solo `mount_google_drive.sh` activo)

### ⚠️ Componentes Legacy
- **Polybar**: Barra de estado (reemplazada por panel nativo de Plasma)
- **Dunst**: Servicio de notificaciones (reemplazado por notificaciones nativas de Plasma)
- **Scripts adicionales**: Algunos scripts pueden estar sin usar

Ver `LEGACY.md` para detalles completos sobre componentes legacy.

## 🚀 Instalación Rápida

### Opción 1: Instalación Automática (Recomendada)
```bash
git clone https://github.com/usuario/dotfiles.git ~/PersonalDotFiles
cd ~/PersonalDotFiles

# Instalar dependencias
./install_dependencies.sh

# Instalar configuraciones (incluye configuración automática de i3 + Plasma)
./install.sh
```

### Opción 2: Instalación Manual

#### Dependencias
```bash
# Paquetes principales
sudo pacman -S i3-wm feh picom rofi wmctrl
sudo pacman -S zsh oh-my-zsh-git emacs
sudo pacman -S plasma-desktop kde-applications systemd

# Doom Emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Configuraciones
```bash
# i3 (selecciona Desktop o Laptop)
ln -sf ~/PersonalDotFiles/i3/Desktop/config ~/.config/i3/config
# o
ln -sf ~/PersonalDotFiles/i3/Laptop/config ~/.config/i3/config

# Configurar i3 + Plasma (automático con install.sh)
chmod +x ~/PersonalDotFiles/i3/configure-plasma-i3.sh
~/PersonalDotFiles/i3/configure-plasma-i3.sh

# Doom Emacs
ln -sf ~/PersonalDotFiles/doomEmacs/config.el ~/.doom.d/config.el
ln -sf ~/PersonalDotFiles/doomEmacs/init.el ~/.doom.d/init.el
ln -sf ~/PersonalDotFiles/doomEmacs/packages.el ~/.doom.d/packages.el

# Oh My Zsh
ln -sf ~/PersonalDotFiles/OhMyZsh/.zshrc ~/.zshrc
ln -sf ~/PersonalDotFiles/OhMyZsh/custom ~/.oh-my-zsh/custom

# Scripts esenciales
ln -sf ~/PersonalDotFiles/Scripts/mount_google_drive.sh ~/.local/bin/mount_google_drive.sh
```

## 🎨 Características del Setup

### i3 + Plasma Integration
- **Gestión de ventanas**: i3 para tiling eficiente
- **Panel nativo**: Plasma panel en lugar de polybar
- **Notificaciones**: Sistema nativo de Plasma
- **Integración completa**: Workspaces, system tray, widgets de Plasma
- **Compatibilidad**: Funciona perfectamente con aplicaciones KDE
- **Systemd service**: Integración automática mediante systemd user service
- **Configuración automática**: Plasma se configura automáticamente para usar i3

### Doom Emacs
- **Evil Mode**: Bindings de Vim
- **LSP**: Soporte para Java, C, C++
- **Magit**: Git integration
- **Atomic Chrome**: Edición desde navegador
- **Transparencia**: Fondo con transparencia

### Oh My ZSH
- **Temas custom**: Configuración personalizada
- **Variables de entorno**: Optimizadas para el workflow

## 🔧 Gestión del Servicio i3 + Plasma

### Verificar estado del servicio:
```bash
systemctl --user status plasma-i3.service
```

### Activar manualmente (si ya está instalado):
```bash
chmod +x ~/PersonalDotFiles/i3/activate-i3-plasma.sh
~/PersonalDotFiles/i3/activate-i3-plasma.sh
```

### Desactivar temporalmente:
```bash
systemctl --user stop plasma-i3.service
systemctl --user disable plasma-i3.service
```

### Reactivar:
```bash
systemctl --user enable plasma-i3.service
systemctl --user start plasma-i3.service
```

## 🔄 Migración desde Setup Anterior

Si vienes del setup anterior con polybar y dunst:

1. **Notificaciones**: Ahora usas el sistema nativo de Plasma
2. **Panel**: Plasma panel reemplaza polybar
3. **Integración**: Mejor integración con aplicaciones KDE
4. **Scripts**: Solo se instala `mount_google_drive.sh` por defecto
5. **Window Manager**: i3 reemplaza KWin automáticamente

## 📚 Componentes Legacy

Los componentes legacy están preservados en:
- `polybar/` - Configuraciones de polybar (marcado como legacy)
- `dunst/` - Configuración de dunst (marcado como legacy)
- `Scripts/` - Scripts adicionales (revisar cuáles usar)

Ver `LEGACY.md` para documentación completa.

## 🛠️ Personalización

Este setup está optimizado para mi workflow específico. Siéntete libre de:
- Modificar configuraciones de i3
- Ajustar temas de Doom Emacs
- Personalizar Oh My ZSH
- Revisar scripts legacy para reutilizar
- Modificar el service de systemd si necesitas ajustes específicos

## 📝 Notas

- **Plasma Integration**: El setup aprovecha las características nativas de Plasma
- **Performance**: Menos componentes = mejor rendimiento
- **Mantenimiento**: Setup más simple y fácil de mantener
- **Flexibilidad**: Puedes volver a componentes legacy si es necesario
- **Automación**: La integración i3 + Plasma se configura automáticamente
- **Systemd**: Usa systemd user services para gestión robusta del servicio

---

*Setup actual: i3 + Plasma Desktop con integración automática*
*Última actualización: $(date)*
