{ config, pkgs, ... }:

{
  # Enable Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia-container-toolkit.enable = true;

  boot.kernelParams = [ "snd_intel_dspcfg.dsp_driver=3" ];
  hardware.enableAllFirmware = true;

  # Enable Zram swap
  zramSwap = {
    enable = true;
    memoryPercent = 80;
  };
  boot.kernel.sysctl = {
    "vm.swappiness" = 98;
  };
}
