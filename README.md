# Personal DotFiles

Este repositorio contiene mis configuraciones personalizadas para diversas herramientas y entornos que utilizo en mi día a día, incluyendo **Doom Emacs**, **i3 Window Manager** y **Oh My ZSH**. Las configuraciones están organizadas para mi computadora de escritorio y mi laptop.

## Contenido

- **Doom Emacs**: Configuración personalizada para mejorar la productividad con Emacs.
- **i3 Desktop Setup**: Configuración de i3 para mi computadora de escritorio.
- **i3 Laptop Setup**: Configuración de i3 optimizada para mi laptop.
- **Oh My ZSH**: Mi configuración de ZSH usando el framework Oh My ZSH para una shell más productiva y estilizada.
- **Dunst**: Configuraciones para el servicio de notificaciones Dunst que uso en mis dos setups
- **Polybar**: Configuraciones para polybar, que es la barra que uso para mis dos setups. Dos configuraciones una para cada setup.
- **Scripts**: Scripts personalizados para acciones varias

## Instalación

La organización de este repositorio está modularizada en "playbooks" (medio inspirado en Ansible lol), cada uno de los cuales instala una o varias de las configuraciones que contiene este repositorio, te recomiendo que las explores y declarativamente las uses para crear selectivamente el entorno de trabajo que buscas.

## Personalización

Este repositorio está configurado particularmente para mis necesidades en mis equipos, por lo que es probable que si quieres utilizarlo en tu computadora tengas que realizar modificaciones al mismo para ajustarlo a tus necesidades (baterías no incluídas)
pero sientete libre de usarlo como inspiración jaja

Todas las configuraciones dan por hecho que están en un ambiente basado en Arch Linux, instalando paquetes usando pacman y dando por hecho la existencia de los que existen en los repositorios oficiales de Arch Linux

## Lista de features en cada programa
### Doom Emacs
- Atomic Chrome para poder invocar instancias de emacs y editar textos dentro del navegador (no puedo vivir sin los bindings de emacs)
- Evil Mode
- LSP Java
- LSP C y C++
- Magit
- Fondo con cierta transparencia para que se vea fancy

### i3 Desktop
- Configuracion de monitores ajustada a mis necesidades
- Polybar configurada a mis necesidades en Desktop
- Bindings de VIM ajustados
- Invocación de Picom y feh para el fondo de pantalla y el compositor
- Uso de dunst para las notificaciones, con configuración incluida
- Script para montar mi Drive en $HOME, para más facil acceso.

### i3 Laptop
- Polybar configurada a mis necesidades en Laptop
- Bindings de VIM ajustados
- Compatibilidad con KDE (en realidad no lo uso mucho lol)
- Invocacion de Picom y feh para el fondo de pantalla y el compositor
- Uso de dunst para las notificaciones, con configuración incluida
- Script para subir y bajar volumen con notificación cool

### Oh my ZSH
- Temas custom y variables de entorno

### Dunst
- Notifiaciones perronas

### Polybar
- Configuraciones custom para cada una de las setups.
- Script de inicio ajustado para multiples monitores

### Y más
Dependiendo del playbook que utilices. (TODO: Documentar esto jaja)