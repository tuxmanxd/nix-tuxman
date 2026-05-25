{ config, pkgs, ... }:
{
  home.username = "tuxman";
  home.homeDirectory = "/home/tuxman";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
        ll = "ls -l";
        update = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#latitude";
    };
    history.size = 10000;
    oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "gnzh";
    };
  };
   programs.kitty = {
        enable = true;
        font = {
            name = "MesloLGS Nerd Font";
            size = 11;
        };
    };

}
