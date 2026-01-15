{ config, pkgs, inputs, pkgs-stable, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./modules.nix ./overlays.nix ./vars.nix ./games.nix ];


  powerManagement.cpuFreqGovernor = "performance";
  powerManagement.enable = true;

  documentation.man.generateCaches = false;
  boot = {
    supportedFilesystems = ["ntfs"];
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
    initrd.luks.devices."root".preLVM = true;
    initrd.systemd.enable = true;

    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    lanzaboote = {
	enable = true;
	pkiBundle = "/var/lib/sbctl";
    };

    #kernelPackages = pkgs.linuxPackages_latest;
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
  };

  zramSwap.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
	package = config.boot.kernelPackages.nvidiaPackages.latest;
	modesetting.enable = true;
	powerManagement.enable = true;
	open = false;
	nvidiaSettings = true;
  };
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [libva-vdpau-driver nvidia-vaapi-driver];
  hardware.graphics.enable32Bit = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.erb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];

  };


  services.fstrim.enable = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [ plymouth kdePackages.breeze-plymouth sbctl 
    glslang
    spirv-cross
    spirv-headers
    spirv-tools
    vulkan-extension-layer
    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-utility-libraries
    vulkan-validation-layers
    vkdisplayinfo
    vkd3d
    vkd3d-proton
    vk-bootstrap
    lutris
    #steam
    #steam-devices-udev-rules
    #proton-ge-bin
  ];

  system.stateVersion = "24.05";
}

