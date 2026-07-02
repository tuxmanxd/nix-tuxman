{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./desktop-optimizations.nix
      ./packages.nix
      ../../shared/wm.nix
      ../../shared/users-and-locale.nix
      ../../shared/packages.nix
      ../../shared/system.nix
    ];
  # Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

  networking.hostName = "desktop";
  system.stateVersion = "26.05";

}
