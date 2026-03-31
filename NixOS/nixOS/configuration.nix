{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      inputs.hyprland.nixosModules.default
    ];
  fileSystems = {
  "/".options = [ "compress=zstd" ];
  "/home".options = [ "compress=zstd" ];
  "/nix".options = [ "compress=zstd" "noatime" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
       vim
       wget
       git
       microsoft-edge
       alacritty
     emacs
   ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
      #...
    ];
    settings = {
    # ...
    };
  };

}
