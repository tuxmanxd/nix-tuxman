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

    environment.systemPackages = with pkgs; [
      heroic
      lutris
      mangohud
    ];
}
