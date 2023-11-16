{ config, pkgs, pkgs-stable, ... }: {
  imports = [
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/desktop-environment.nix
    ./modules/fonts.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/security.nix
    ./modules/packages.nix
    ./modules/virtualisation.nix
  ];
}
