{ config, pkgs, ... }:

{
  # Enable flatpaks
  services.flatpak.enable = true;
  environment.extraOutputsToInstall = [ "man" "share/applications" ];

  # Enable podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List of system packages
  environment.systemPackages = with pkgs; [
  pkgs.distrobox pkgs.gnome-disk-utility
  ];

  # Install firefox.
  programs.firefox.enable = true;
}
