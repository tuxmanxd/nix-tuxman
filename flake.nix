{
  description = "TuxMan's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    iloader.url = "github:nab138/iloader";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, iloader, nix-flatpak, ... }@inputs: {
    nixosConfigurations = {

      # Latitude profile
      latitude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, ... }:
          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
              (final: prev: { iloader = iloader.packages.${prev.system}.default; })
            ];
          })

          nix-flatpak.nixosModules.nix-flatpak
          ./hosts/latitude/configuration.nix
        ];
      };

    };
  };
}
