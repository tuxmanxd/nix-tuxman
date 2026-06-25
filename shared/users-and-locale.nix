{ config, pkgs, inputs, ... }:

{
  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.tuxman = {
      imports = [
        ../home.nix
      ];

      home.packages = with pkgs; [
        kdePackages.kate
        kitty
        fastfetch
        btop
        (discord.override { withVencord = true; })
        git
        iloader
        pano-scrobbler
        pkgs.osu-lazer-bin
        nicotine-plus
      ];
    };
  };

  # Define a user account
  users.users.tuxman = {
      isNormalUser = true;
      description = "TuxMan";
      extraGroups = [ "networkmanager" "wheel" ];
    };

  # Set your time zone.
  time.timeZone = "Africa/Tunis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.profiles = [
    "$HOME/.local/share/flatpak/exports"
    "/var/lib/flatpak/exports"
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
