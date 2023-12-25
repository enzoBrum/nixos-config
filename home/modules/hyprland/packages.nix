{ config, pkgs, pkgs-stable, ... }: {
  home.packages = with pkgs; [
    wl-clipboard
    mako
    dmenu
    playerctl
    swww
    python312Packages.pywal
    fuzzel
    eww-wayland
    dunst
    copyq
  ];
}
