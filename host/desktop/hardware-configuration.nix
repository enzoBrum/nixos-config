# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a28a5f05-26fa-4e1c-9b38-bbd47d2d0c7a";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/90f14c64-da85-4073-838d-ce5f740a3445";

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/a28a5f05-26fa-4e1c-9b38-bbd47d2d0c7a";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a28a5f05-26fa-4e1c-9b38-bbd47d2d0c7a";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/a28a5f05-26fa-4e1c-9b38-bbd47d2d0c7a";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  fileSystems."/efi" =
    { device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-9cf1eecd1042.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-ce7400264c29.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-e926ba2977c5.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
