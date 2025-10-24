{
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
    ./overlays.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
  powerManagement.enable = true;
  services.usbmuxd.enable = true;

  boot = {
    tmp.cleanOnBoot = true;
    bootspec.enable = true;
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    initrd.systemd.enable = true;

    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "udev.log_level=3"
      "quiet"
      "splash"
      "vt.global_cursor_default=0"
      "intel_pstate=active"
    ];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 10 * 1024;
    }
  ];
  zramSwap.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.erb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

  };

  services.fstrim.enable = true;
  services.flatpak.enable = true;
  services.usbmuxd.user = "erb";
  environment.systemPackages = with pkgs; [
    plymouth
    kdePackages.breeze-plymouth
    sbctl

    libimobiledevice
    usbmuxd
    ifuse
    idevicerestore
  ];

  system.stateVersion = "24.05";
}
