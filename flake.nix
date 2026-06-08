{
  description = "TuxMan's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    iloader.url = "github:nab138/iloader";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    pano-scrobbler-flake.url = "github:kawaiiDango/pano-scrobbler-flake";
    nixcord.url = "github:FlameFlag/nixcord";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-dotfiles = {
      url = "git+ssh://git@github.com/tuxmanxd/niri-dotfiles.git?ref=main";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, nix-darwin, iloader, nix-flatpak, pano-scrobbler-flake, nixcord, home-manager, ... }@inputs: {
    nixosConfigurations = {

      # Latitude profile
      latitude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ({ pkgs, ... }:
          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
              (final: prev: { iloader = iloader.packages.${prev.system}.default;
              pano-scrobbler = pano-scrobbler-flake.packages.${prev.system}.default;
              })
            ];
          })

          nix-flatpak.nixosModules.nix-flatpak
          nixcord.nixosModules.nixcord
          home-manager.nixosModules.home-manager
          ./hosts/latitude/configuration.nix
        ];
      };

    };

    darwinConfigurations.latitude-darwin = nix-darwin.lib.darwinSystem {
      modules = [ ./hosts/latitude-darwin/darwin-configuration.nix ];
      specialArgs = { inherit inputs; };
    };
  };
}
