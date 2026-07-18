{ config, pkgs, ... }:

{
  # Enable Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia-container-toolkit.enable = true;

  hardware.enableAllFirmware = true;

  # Enable Zram swap
  zramSwap = {
    enable = true;
    memoryPercent = 98;
  };
  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
  };
}
