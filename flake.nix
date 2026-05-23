{
  description = "TuxMan's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    iloader.url = "github:nab138/iloader";

  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, iloader, ... }@inputs: {
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


          ./hosts/latitude/configuration.nix
        ];
      };

    };
  };
}
