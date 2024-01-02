{ config, pkgs, ... }: {
  imports = [
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/hyprland/default.nix
    ./modules/dconf-gnome.nix
    ./modules/vscode.nix
    ./modules/direnv.nix
    ./modules/waybar.nix
    ./modules/ags/default.nix
  ];
}
