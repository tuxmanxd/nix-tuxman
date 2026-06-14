{ config, pkgs, ... }:

{
  # Enable Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  # Enable Zram swap
  zramSwap = {
    enable = true;
    memoryPercent = 80;
  };
  boot.kernel.sysctl = {
    "vm.swappiness" = 98;
  };
}
