{
  description = "Configuración personal de Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.56.0";
    };
    zen-browser = {
        url = "github:youwen5/zen-browser-flake/458cd16116c362a5e92d5db6bdc3599e4e8b1f4a";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  outputs = { self, nixpkgs,  ... }@inputs: {
    nixosConfigurations.mrtaichi-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        
      ];
    };
  };
}
