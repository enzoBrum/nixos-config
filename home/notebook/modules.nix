{ config, pkgs, ... }: {
  imports = [
    ../modules/git.nix
    ../modules/shell.nix
    ../modules/hyprland/default.nix
    ../modules/dconf-gnome.nix
    ../modules/vscode.nix
    ../modules/direnv.nix
    ../modules/waybar.nix
    ../modules/helix.nix
    ../modules/alacritty.nix
    ../modules/bat.nix
    ../modules/neovim/default.nix
    ../modules/zellij.nix
    ../modules/wezterm.nix
    ../modules/gdb.nix
    ../modules/bluetooth.nix
    ../modules/gtk.nix
    ../modules/ghostty.nix
    ../modules/cfg.nix
    # ../modules/ags/default.nix
  ];
}
