{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable xwayland
  programs.xwayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable qt6ct
  qt = {
    enable = true;
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kde";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  environment.systemPackages = with pkgs; [
  pkgs.adw-gtk3 kdePackages.qt6ct kdePackages.knewstuff kdePackages.kcmutils kdePackages.qqc2-desktop-style xwayland-satellite
  ];

  # Install DMS
  programs.niri.enable = true;
  programs.dms-shell.enable = true;

}
