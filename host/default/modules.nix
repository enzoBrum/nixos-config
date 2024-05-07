{ config, pkgs, pkgs-stable, ... }: {
  imports = [
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/fonts.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/security.nix
    ./modules/packages.nix
    ./modules/virtualisation.nix
    ./modules/gdm.nix
    # ./modules/hyprland.nix
    ./modules/gnome.nix
    ./modules/steam.nix
    ./modules/flatpak_themes.nix
    ./modules/nh.nix
    ./modules/phone.nix
  ];
}
