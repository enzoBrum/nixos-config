{ config, pkgs, pkgs-stable, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./modules.nix ./overlays.nix ./vars.nix ];


  powerManagement.cpuFreqGovernor = "performance";
  powerManagement.enable = true;

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
      pkiBundle = "/etc/secureboot";
    };
    initrd.luks.devices."root".preLVM = true;
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
    ];
  };

  fileSystems = {
    "/".options = [ "compress=zstd" "subvol=@" "noatime" "discard=async" ];
    "/home".options =
      [ "compress=zstd" "subvol=@home" "noatime" "discard=async" ];
    "/nix".options =
      [ "compress=zstd" "subvol=@nix" "noatime" "discard=async" ];
    "/swap".options = [ "noatime" "subvol=swap" ];
  };

  zramSwap.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
  	package = config.boot.kernelPackages.nvidiaPackages.beta;
	modesetting.enable = true;
	powerManagement.enable = false;

	open = true;
	nvidiaSettings = true;
  };
  hardware.graphics.enable = true;
  hardware.opengl.extraPackages = with pkgs; [vaapiVdpau nvidia-vaapi-driver];
  hardware.opengl.enable = true;

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
  environment.systemPackages = with pkgs; [ plymouth breeze-plymouth sbctl ];

  system.stateVersion = "24.05";
}

