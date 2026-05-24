{ config, pkgs, ... }:

{
  # Enable flatpaks
  services.flatpak.enable = true;
  environment.extraOutputsToInstall = [ "man" "share/applications" ];
  services.flatpak = {
    remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
    {
      name = "pineconemc-repo";
      location = "https://elyprismlauncher.github.io/flatpak/elyprismlauncher.flatpakrepo";
    }
    ];

    packages = [
      "one.ablaze.floorp"
      "org.kde.neochat"
      "io.github.elyprismlauncher.ElyPrismLauncher"
    ];
    uninstallUnmanaged = false;
    update.auto.enable = true;
  };

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

  # Install VmWare
  virtualisation.vmware.host.enable = true;
}
