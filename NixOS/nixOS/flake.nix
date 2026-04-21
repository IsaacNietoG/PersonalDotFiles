{
  description = "Configuración personal de Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      hyprland.url = "github:hyprwm/Hyprland/59f9f2688ac508a0584d1462151195a6c4992f99";
      hy3 = {
        url = "github:outfoxxed/hy3";
        inputs.hyprland.follows = "hyprland";
      };
    zen-browser = {
        url = "github:youwen5/zen-browser-flake";
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

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.mrtaichi-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
