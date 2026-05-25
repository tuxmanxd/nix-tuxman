{ config, pkgs, ... }:

{
  # Linux CachyOS kernel binary cache configs
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
  };

  # Enable "Silent boot"
  consoleLogLevel = 3;
  initrd.verbose = false;
  kernelParams = [
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
  ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
  loader.timeout = 0;
  };

  # Enable garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;
  boot.loader.systemd-boot.configurationLimit = 3;

  # Enable auto upgrades
  system.autoUpgrade = {
    enable = true;
    flake = "path:/etc/nixos#latitude";
    flags = [
      "--print-build-logs"
      "--update-input" "nixpkgs"
      "--update-input" "nix-cachyos-kernel"
    ];
    dates = "weekly";
    allowReboot = false;
  };

  # Enable btrfs compression
  fileSystems."/".options = [ "compress-force=zstd:1" "noatime" ];
  fileSystems."/home".options = [ "compress-force=zstd:1" "noatime" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


}
