# Personal DotFiles

Este repositorio contiene mis configuraciones personalizadas para diversas herramientas y entornos que utilizo en mi día a día, incluyendo **Doom Emacs**, **i3 Window Manager** y **Oh My ZSH**.

## Acerca de este Repositorio

Este repositorio utiliza **Programación Letrada** (Literate Programming), un paradigma propuesto por Donald Knuth en 1984. Todas las configuraciones nacen de un único documento fuente que combina documentación y código en una sola fuente de verdad.

### Estructura del Repositorio

El repositorio se divide en tres partes principales:

1. **Parte Letrada** (`docs/main.org`): El documento fuente principal escrito en org-mode
   - Contiene toda la documentación explicando cada decisión de diseño
   - Incluye los bloques de código que generan las dotfiles
   - **Esta es la parte maestra** - todos los cambios se hacen aquí

2. **Parte Documentación** (`docs/main.pdf`): Documentación autogenerada en PDF
   - Generada automáticamente desde el archivo org
   - Útil para lectura sin necesidad de Emacs

3. **Parte Código** (dotfiles en el repositorio): Las configuraciones reales
   - Generadas automáticamente desde `docs/main.org` mediante "tangling"
   - No contienen comentarios (toda la documentación está en la parte letrada)

## 📖 Cómo Leer este Repositorio

**Recomendación**: Para entender realmente este repositorio, la mejor forma es leer la parte letrada (`docs/main.org`) en Emacs con org-mode. Esto te permitirá:
- Ver la documentación completa de cada configuración
- Entender el "por qué" detrás de cada decisión
- Navegar fácilmente entre secciones relacionadas

Si no tienes Emacs, puedes:
- Leer el PDF en `docs/main.pdf`
- Explorar los archivos de configuración directamente (aunque perderás el contexto)

## 🚀 Instalación

Este repositorio utiliza **playbooks** modulares (vagamente inspirados en Ansible) para instalar cada componente. Cada playbook:
- Instala la herramienta y sus dependencias
- Configura los dotfiles correspondientes mediante enlaces simbólicos

### Playbooks Disponibles

- `playbooks/install-doom-emacs.sh` - Instala Doom Emacs y configura los dotfiles
- `playbooks/install-i3.sh` - Instala i3 Window Manager y configura los dotfiles
- `playbooks/install-ohmyzsh.sh` - Instala Oh My ZSH y configura los dotfiles

### Uso

```bash
# Ejemplo: Instalar Doom Emacs
./playbooks/install-doom-emacs.sh
```

**Nota**: Los playbooks están diseñados para Arch Linux y usan `pacman` como gestor de paquetes.

## 🛠️ Componentes Incluidos

### Doom Emacs
- Atomic Chrome para editar textos en el navegador
- Evil Mode (bindings estilo Vim)
- LSP para Java, C y C++
- Magit para control de versiones
- Configuración con transparencia

### i3 Window Manager
- Configuración unificada (Desktop/Laptop)
- Bindings estilo Vim
- Integración con Picom (compositor) y feh (wallpaper)
- Integración como gestor de ventanas bajo entorno principal: KDE Plasma

### Oh My ZSH
- Temas personalizados
- Variables de entorno configuradas

## 📝 Personalización

Este repositorio está configurado para mis necesidades específicas. Si quieres usarlo:

1. **Lee primero** `docs/main.org` para entender las configuraciones
2. **Modifica** `docs/main.org` según tus necesidades
3. **Regenera** las dotfiles ejecutando el tangle en Emacs (o manualmente si prefieres)

**Importante**: Si vas a hacer cambios, modifica `docs/main.org`, no los archivos de configuración directamente. Los archivos de configuración se regeneran desde el org.

## ⚙️ Requisitos

- **Sistema Operativo**: Arch Linux (o derivados)
- **Gestor de Paquetes**: pacman
- **Para editar la parte letrada**: Emacs con org-mode (recomendado Doom Emacs)

## 📚 Más Información

Para documentación detallada sobre cada componente, decisiones de diseño y explicaciones completas, consulta:
- `docs/main.org` (recomendado, en Emacs)
- `docs/main.pdf` (alternativa sin Emacs)

## 🔄 Archivos Legacy

Los archivos antiguos y configuraciones deprecadas se encuentran en el directorio `legacy/` para referencia histórica.

---

**Nota**: Este repositorio sigue el paradigma de Programación Letrada. Toda la documentación y el código provienen de `docs/main.org`. Si encuentras algo que no está documentado allí, considera que puede estar en proceso de migración o ser parte de los archivos legacy.
