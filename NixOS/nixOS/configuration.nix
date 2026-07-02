{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./private.nix
      inputs.hyprland.nixosModules.default
    ];
  fileSystems = {
  "/".options = [ "compress=zstd" ];
  "/home".options = [ "compress=zstd" ];
  "/nix".options = [ "compress=zstd" "noatime" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "mrtaichi-laptop";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  services.xserver.enable = true;
  services.xserver.xkb = {
  layout = "us";
  variant = "altgr-intl";
  options = "grp:win_space_toggle";
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.mrtaichi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user. Y VMs
    packages = with pkgs; [
      aider-chat
      go
      bettercap
      burpsuite
      ettercap
      mitmproxy
      mubeng
      proxify
      proxychains
      redsocks
      rshijack
      zap
      nmap
      rustscan
      albedo
      arjun
      atac
      brakeman
      cameradar
      cansina
      cariddi
      cf-hero
      chopchop
      clairvoyance
      commix
      crackql
      crlfsuite
      dalfox
      dismap
      dirstalk
      dontgo403
      forbidden
      galer
      gau
      genzai
      gospider
      gotestwaf
      gowitness
      graphpython
      graphqlmaker
      graphqlmap
      graphw00f
      h2spec
      hakrawler
      python3Packages.hakuin
      hey
      http-server
      httpx
      jaeles
      jsubfinder
      jwt-hack
      katana
      kiterunner
      mantra
      mitmproxy2swagger
      monsoon
      nikto
      nomore403
      ntlmrecon
      offat
      photon
      plecost
      scraper
      slowlorust
      snallygaster
      subjs
      swaggerhole
      uddup
      urlfinder
      urx
      wad
      wappalyzergo
      webanalyze
      websecprobe
      whatweb
      wprecon
      wpscan
      wsrepl
      wuzz
      xcrawl3r
      xnlinkfinder
      xsubfind3r
      certinfo-go
      chrony
      clamav
      curl
      cyberchef
      dorkscout
      easyeasm
      exiflooter
      flashrom
      girsh
      gtfocli
      httpie
      hurl
      inetutils
      inxi
      iproute2
      iw
      lynx
      macchanger
      nano
      parted
      pwgen
      spyre
      utillinux
      wget
      xh
      xnldorker
      btop
      iftop
      iotop
      eternal-terminal
      mosh
      shellz
      certinfo-go
      cifs-utils
      freerdp
      net-snmp
      nfs-utils
      ntp
      openssh
      openvpn
      samba
      step-cli
      wireguard-go
      wireguard-tools
      xrdp
      ipcalc
      netmask
      tmux
      zellij
      cabextract
      p7zip
      unrar
      unzip
      acltoolkit
      checkip
      ghunt
      ike-scan
      keepwn
      metasploit
      nbutools
      nerva
      nuclei
      nuclei-templates
      openrisk
      osv-scanner
      uncover
      traitor
      vuls
      mx-takeover
      ruler
      swaks
      trustymail
      agneyastra
      ghauri
      laudanum
      mongoaudit
      nosqli
      pysqlrecon
      sqlmap
      sqlmc
      braa
      onesixtyone
      snmpen
      baboossh
      sshchecker
      ssh-audit
      ssh-mitm
      teler
      waf-tester
      wafw00f
      cryptoscan
      mini-pqc
      pqc-bench
      pqcscan
      oshka
      trajan
      terrascan
      tfsec
      chain-bench
      witness
      davtest
      authoscope
      bruteforce-luks
      conpass
      crunch
      h8mail
      hashcat
      hashcat-utils
      hashdeep
      legba
      nasty
      ncrack
      nth
      pywhisker
      sh4d0wup
      spearspray
      spraycharles
      thc-hydra
      truecrack
      exploitdb
      go-exploitdb
      keedump
      padre
      sploitscan
      lmp
      logmap
      aflplusplus
      feroxbuster
      ffuf
      gobuster
      honggfuzz
      radamsa
      regexploit
      scout
      ssdeep
      wfuzz
      zzuf
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
       vim
       wget
       git
       alacritty
       bluetui
       gh
       texlive.combined.scheme-full
       nodejs
       python3
       gcc
       tree
       spotify
       anki-bin
       pkgs.javaPackages.compiler.openjdk25
     emacs
     rofi
     hyprlock
     hyprshot
     hyprpaper
     waybar
     maestral
     inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
       zerotierone
     pkgs.netbird-ui
   ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 */14 * *  root  nix-collect-garbage -d"
    ];
  };

  programs.zsh = {
    enable = true; # Enable Zsh
  ohMyZsh = {
    enable = true; # Enable Oh My Zsh
    plugins = [ "git" ]; # Add desired plugins
    # plugins = [ "git" "zsh-autosuggestions" "zsh-syntax-highlighting" ]; # Add desired plugins
    theme = "agnoster"; # Set your preferred theme (default: robbyrussell)
    };
  };

  users.defaultUserShell = pkgs.zsh; # Set Zsh as the default shell
  environment.shells = [ pkgs.zsh ]; # Add Zsh to available shells

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    # usual Nixpkgs module options
    plugins = [
      inputs.hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3
    ];
    settings = {
      "plugin:hy3" = {};
      
        # --- AUTOSTART ---
        exec-once = [
          "hyprpaper"
          "waybar"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "dropbox start"
          "gnome-keyring-daemon --start --components=secrets,pkcs11,ssh"
          # Carga del plugin hy3
          "hyprctl plugin load ${inputs.hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3}/lib/libhy3.so"
        ];
      
        extraConfig = ''
      
      # See https://wiki.hypr.land/Configuring/Monitors/
      monitor= HDMI-A-1,preferred,auto-up,1, mirror, eDP-1
      monitor=,highres,auto,auto
      
      
      ###################
      ### MY PROGRAMS ###
      ###################
      
      # See https://wiki.hypr.land/Configuring/Keywords/
      
      # Set programs that you use
      $terminal = alacritty
      $menu = ~/.config/rofi/launchers/type-1/launcher.sh
      
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24
      
      
      ###################
      ### PERMISSIONS ###
      ###################
      
      # See https://wiki.hypr.land/Configuring/Permissions/
      # Please note permission changes here require a Hyprland restart and are not applied on-the-fly
      # for security reasons
      
      # ecosystem {
      #   enforce_permissions = 1
      # }
      
      # permission = /usr/(bin|local/bin)/grim, screencopy, allow
      # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
      # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow
      
      
      #####################
      ### LOOK AND FEEL ###
      #####################
      
      # Refer to https://wiki.hypr.land/Configuring/Variables/
      
      # https://wiki.hypr.land/Configuring/Variables/#general
      general {
          gaps_in = 3
          gaps_out = 5
      
          border_size = 1
      
          # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
      
          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false
      
          # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      
          layout = hy3
      }
      
      # https://wiki.hypr.land/Configuring/Variables/#decoration
      decoration {
          rounding = 10
          rounding_power = 2
      
          # Change transparency of focused and unfocused windows
          active_opacity = 1.0
          inactive_opacity = 1.0
      
          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }
      
          # https://wiki.hypr.land/Configuring/Variables/#blur
          blur {
              enabled = true
              size = 3
              passes = 1
      
              vibrancy = 0.1696
          }
      }
      
      # https://wiki.hypr.land/Configuring/Variables/#animations
      animations {
          enabled = yes, please :)
      
          # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
          #        NAME,           X0,   Y0,   X1,   Y1
          bezier = easeOutQuint,   0.23, 1,    0.32, 1
          bezier = easeInOutCubic, 0.65, 0.05, 0.36, 1
          bezier = linear,         0,    0,    1,    1
          bezier = almostLinear,   0.5,  0.5,  0.75, 1
          bezier = quick,          0.15, 0,    0.1,  1
      
          # Default animations, see https://wiki.hypr.land/Configuring/Animations/
          #           NAME,          ONOFF, SPEED, CURVE,        [STYLE]
          animation = global,        1,     10,    default
          animation = border,        1,     5.39,  easeOutQuint
          animation = windows,       1,     4.79,  easeOutQuint
          animation = windowsIn,     1,     4.1,   easeOutQuint, popin 87%
          animation = windowsOut,    1,     1.49,  linear,       popin 87%
          animation = fadeIn,        1,     1.73,  almostLinear
          animation = fadeOut,       1,     1.46,  almostLinear
          animation = fade,          1,     3.03,  quick
          animation = layers,        1,     3.81,  easeOutQuint
          animation = layersIn,      1,     4,     easeOutQuint, fade
          animation = layersOut,     1,     1.5,   linear,       fade
          animation = fadeLayersIn,  1,     1.79,  almostLinear
          animation = fadeLayersOut, 1,     1.39,  almostLinear
          animation = workspaces,    1,     1.94,  almostLinear, fade
          animation = workspacesIn,  1,     1.21,  almostLinear, fade
          animation = workspacesOut, 1,     1.94,  almostLinear, fade
          animation = zoomFactor,    1,     7,     quick
      }
      
      # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      # workspace = w[tv1], gapsout:0, gapsin:0
      # workspace = f[1], gapsout:0, gapsin:0
      # windowrule {
      #     name = no-gaps-wtv1
      #     match:float = false
      #     match:workspace = w[tv1]
      #
      #     border_size = 0
      #     rounding = 0
      # }
      #
      # windowrule {
      #     name = no-gaps-f1
      #     match:float = false
      #     match:workspace = f[1]
      #
      #     border_size = 0
      #     rounding = 0
      # }
      
      # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
      dwindle {
          preserve_split = true # You probably want this
      }
      
      # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
      master {
          new_status = master
      }
      
      # https://wiki.hypr.land/Configuring/Variables/#misc
      misc {
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
      }
      
      
      #############
      ### INPUT ###
      #############
      
      # https://wiki.hypr.land/Configuring/Variables/#input
      input {
          kb_layout = us
          kb_variant = intl
          kb_model =
          kb_options =
          kb_rules =
      
          follow_mouse = 1
      
          sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
      
          touchpad {
              natural_scroll = false
          }
      }
      
      # See https://wiki.hypr.land/Configuring/Gestures
      gesture = 3, horizontal, workspace
      
      # Example per-device config
      # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }
      
      
      ###################
      ### KEYBINDINGS ###
      ###################
      
      
      # Screenshots
      bind = , Print, exec, hyprshot -m region
      bind = SHIFT, Print, exec, hyprshot -m output -m active -o ~/Pictures
      
      # See https://wiki.hypr.land/Configuring/Keywords/
      $mainMod = SUPER # Sets "Windows" key as main modifier
      
      # yprlock
      bind = $mainMod, Escape, exec, hyprlock
      
      # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, $terminal
      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
      bind = $mainMod SHIFT, space, togglefloating,
      bind = $mainMod, D, exec, $menu
      bind = $mainMod, P, pseudo, # dwindle
      
      # Emacs
      bind = $mainMod, E, exec, emacs
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, H, hy3:movefocus, l
      bind = $mainMod, L, hy3:movefocus, r
      bind = $mainMod, K, hy3:movefocus, u
      bind = $mainMod, J, hy3:movefocus, d
      
      # Make group (Stacking HY3) we acuerdate de esto del plugin
      bind = $mainMod, S, hy3:makegroup, tab
      
      # Move current window left, right, up and down
      bind = $mainMod SHIFT, H, hy3:movewindow, l
      bind = $mainMod SHIFT, L, hy3:movewindow, r
      bind = $mainMod SHIFT, K, hy3:movewindow, u
      bind = $mainMod SHIFT, J, hy3:movewindow, d
      
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, hy3:movewindow
      bindm = $mainMod, mouse:273, resizewindow
      
      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
      
      # Requires playerctl
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      
      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################
      
      # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
      # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
      
      # Example windowrules that are useful
      
      windowrule {
          # Ignore maximize requests from all apps. You'll probably like this.
          name = suppress-maximize-events
          match:class = .*
      
          suppress_event = maximize
      }
      
      windowrule {
          # Fix some dragging issues with XWayland
          name = fix-xwayland-drags
          match:class = ^$
          match:title = ^$
          match:xwayland = true
          match:float = true
          match:fullscreen = false
          match:pin = false
      
          no_focus = true
      }
      
      # Hyprland-run windowrule
      windowrule {
          name = move-hyprland-run
      
          match:class = hyprland-run
      
          move = 20 monitor_h-120
          float = yes
      }
      
      
          '';
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true;

services.netbird.enable = true;

services.tailscale.enable = true;

}
