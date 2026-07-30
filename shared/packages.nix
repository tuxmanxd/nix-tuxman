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
      "org.musicbrainz.Picard"
      "org.telegram.desktop"
      "org.localsend.localsend_app"
      "us.zoom.Zoom"
      "org.qbittorrent.qBittorrent"
      "com.brave.Browser"
      "com.vysp3r.ProtonPlus"
      "org.kde.haruna"
    ];
    uninstallUnmanaged = true;
    update.auto.enable = true;
  };

  # Enable podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
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

  # Enable 32bit support
  hardware.graphics.enable32Bit = true;

  # List of system packages
  environment.systemPackages = with pkgs; [
  distrobox
  gnome-disk-utility
  libimobiledevice
  ifuse
  qemu
  android-tools
  podman-compose
  podman-tui
  thunar
  unrar
  pmbootstrap
  ];

  # Enable arm64 virtualisation
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  # Install usbmuxd
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install VmWare
  virtualisation.vmware.host.enable = true;

  # Install ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.meslo-lg
    ];
  };

  # Enable vencord
  programs.nixcord = {
    enable = true;
    discord.vencord.enable = true;
    user = "tuxman";
    config.useQuickCss = true;
    config.themeLinks = [
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-auto.theme.css"
      ];
    config.frameless = true;
    config.plugins = {
      fakeNitro.enable = true;
      decor = {
        enable=true;
        agreedToGuidelines=true;
        };
      ircColors.enable = true;
      LastFMRichPresence = {
        enable = true;
        shareUsername = true;
        useListeningStatus = true;
        username = "TuxKun";
        showLogo = false;
        apiKey = "e37f4dcae47f450af6b41fa7c1b4e1b1";
        };
      showHiddenThings.enable = true;
      youtubeAdblock.enable=true;
      USRBG.enable=true;
      alwaysTrust.enable=true;
      ReviewDB.enable=true;
      betterUploadButton.enable=true;
      ClearURLs.enable=true;
      crashHandler.enable=true;
      disableCallIdle.enable=true;
      expressionCloner.enable=true;
      fixImagesQuality.enable=true;
      #friendsSince.enable=true;
      gameActivityToggle.enable=true;
      permissionsViewer.enable=true;
      };
    };
}
