{ config, pkgs, pkgs-stable, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./modules.nix ./overlays.nix ];

  programs.nix-ld.enable = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" "https://nix-community.cachix.org" "https://cosmic.cachix.org/"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };

    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 7d";

    extraOptions = ''
      !include ${config.sops.secrets.github_access_token.path}
    '';
  };

  nixpkgs.config.allowUnfree = true;
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
  environment.systemPackages = with pkgs; [ plymouth breeze-plymouth sbctl ];

  system.stateVersion = "24.05";
}

