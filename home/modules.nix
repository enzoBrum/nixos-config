{ config, pkgs, ... }: {
  imports = [
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/hyprland/default.nix
    ./modules/ags/default.nix
    ./modules/dconf-gnome.nix
    ./modules/vscode.nix
  ];
}
