{ config, pkgs, ... }:

{
  # Enable Intel VAAPI
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Enable thermald
  services.thermald.enable = true;

  # Enable system76 scheduler
  services.system76-scheduler.enable = true;

  # Enable hybernation
  boot.resumeDevice = "/dev/disk/by-uuid/c38bf158-04df-4db3-83ec-c00bde335fff";
  powerManagement.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Enable Zram swap
  zramSwap = {
    enable = true;
    memoryPercent = 80;
  };
  boot.kernel.sysctl = {
    "vm.swappiness" = 98;
  };
}
