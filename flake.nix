{
  description = "TuxMan's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    iloader.url = "github:nab138/iloader";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    pano-scrobbler-flake.url = "github:kawaiiDango/pano-scrobbler-flake";
    nixcord.url = "github:FlameFlag/nixcord";

  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, iloader, nix-flatpak, pano-scrobbler-flake, nixcord, ... }@inputs: {
    nixosConfigurations = {

      # Latitude profile
      latitude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
          ./hosts/latitude/configuration.nix
        ];
      };

    };
  };
}
