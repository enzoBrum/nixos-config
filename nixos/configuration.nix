{ config, pkgs, pkgs-stable, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 14d";
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
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
    kernelParams = [
      "quiet"
      "splash"
      "bgrt_disable"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
      "intel_pstate=active"
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

  swapDevices = [{
    device = "/swap/swapfile";
    size = 10 * 1024;
  }];
  zramSwap.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  users.users.erb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];

  };

  services.fstrim.enable = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [ plymouth breeze-plymouth sbctl ];

  system.stateVersion = "23.05";
}

