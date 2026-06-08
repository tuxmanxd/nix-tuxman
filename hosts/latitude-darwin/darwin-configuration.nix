{ config, pkgs, inputs, ... }: {
  environment.systemPackages = [ pkgs.vim pkgs.git pkgs.fastfetch ];
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.stateVersion = 7;

  networking.hostName = "latitude-darwin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nixcord.darwinModules.nixcord
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.tuxman = {
    imports = [ ../../home.nix ];

    home.packages = with pkgs; [
      btop
      (discord.override { withVencord = true; })
      floorp-bin
    ];
  };

  users.users.tuxman = {
    name = "tuxman";
    home = "/Users/tuxman";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
        showLastFmLogo = false;
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
      friendsSince.enable=true;
      gameActivityToggle.enable=true;
      permissionsViewer.enable=true;
      };
    };
}
