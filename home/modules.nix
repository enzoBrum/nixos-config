{ config, pkgs, ... }: {
  imports = [
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/hyprland/default.nix
  ];
}
