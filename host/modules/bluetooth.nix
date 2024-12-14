{ pkgs, pkgs-stable, lib, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  services.pipewire.wireplumber.enable = true;
}
