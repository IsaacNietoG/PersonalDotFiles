# Personal DotFiles

Este repositorio contiene mis configuraciones personalizadas para diversas herramientas y entornos que utilizo en mi día a día, incluyendo **Doom Emacs**, **i3 Window Manager** y **Oh My ZSH**. Las configuraciones están organizadas para mi computadora de escritorio y mi laptop.

## Contenido

- **Doom Emacs**: Configuración personalizada para mejorar la productividad con Emacs.
- **i3 Desktop Setup**: Configuración de i3 para mi computadora de escritorio.
- **i3 Laptop Setup**: Configuración de i3 optimizada para mi laptop.
- **Oh My ZSH**: Mi configuración de ZSH usando el framework Oh My ZSH para una shell más productiva y estilizada.

## Instalación

Para utilizar cualquiera de estas configuraciones, simplemente clona este repositorio en tu máquina y crea enlaces simbólicos (symlinks) en los directorios correspondientes.

```bash
git clone https://github.com/usuario/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Configuración de Doom Emacs

1. Instala Doom Emacs siguiendo las instrucciones oficiales: [Doom Emacs](https://github.com/hlissner/doom-emacs).
2. Crea un symlink hacia la configuración de Emacs:

   ```bash
   ln -sf ~/dotfiles/doomEmacs/config.el ~/.doom.d/config.el
   ln -sf ~/dotfiles/doomEmacs/init.el ~/.doom.d/init.el
   ln -sf ~/dotfiles/doomEmacs/packages.el ~/.doom.d/packages.el
   ```

3. Recarga la configuración de Doom Emacs:

   ```bash
   doom sync
   ```

### Configuración de i3 (Desktop & Laptop)

1. Para la computadora de escritorio:

   ```bash
   ln -sf ~/dotfiles/i3/Desktop/config ~/.config/i3/config
   sudo ln -sf ~/dotfiles/i3/Desktop/i3status/config/i3status.conf /etc/i3status.conf
   ```

2. Para la laptop:

   ```bash
   ln -sf ~/dotfiles/i3/Laptop/config ~/.config/i3/config
   sudo ln -sf ~/dotfiles/i3/Laptop/i3status/config/i3status.conf /etc/i3status.conf
   ```

### Configuración de Oh My ZSH

1. Instala **Oh My ZSH** si no lo tienes ya instalado:

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. Crea un symlink para la configuración de ZSH:

   ```bash
   ln -sf ~/dotfiles/OhMyZsh/.zshrc ~/.zshrc
   ```

## Personalización

Este repositorio está configurado particularmente para mis necesidades en mis equipos, por lo que es probable que si quieres utilizarlo en tu computadora tengas que realizar modificaciones al mismo para ajustarlo a tus necesidades (baterías no incluídas)
pero sientete libre de usarlo como inspiración jaja

## Lista de features en cada programa
### Doom Emacs
- Atomic Chrome para poder invocar instancias de emacs y editar textos dentro del navegador (no puedo vivir sin los bindings de emacs)
- Evil Mode
- LSP Java
- Magit
- Fondo con cierta transparencia para que se vea fancy

### i3 Desktop
- Configuracion de monitores ajustada a mis necesidades
- i3 status bar ajustada a mis necesidades
- Bindings de VIM ajustados
- Invocación de Picom y feh para el fondo de pantalla y el compositor

### i3 Laptop
- i3 status bar ajustada a mis necesidades
- Bindings de VIM ajustados
- Compatibilidad con KDE
- Invocacion de Picom y feh para el fondo de pantalla y el compositor

### Oh my ZSH
- Temas custom y variables de entorno
