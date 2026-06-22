{ config, pkgs, ... }:
{

    # Install Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # Enable gamemode
    programs.gamemode.enable = true;

    # Enable OpenRGB
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      server.port = 6742;
    };

    # Enable gpu passthrough to docker
    virtualisation.docker.rootless.daemon.settings.features.cdi = true;

    environment.systemPackages = with pkgs; [
      heroic
      lutris
      mangohud
    ];

    services.flatpak.packages = [
      "com.dec05eba.gpu_screen_recorder"
    ];
}
