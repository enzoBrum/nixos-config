{ config, pkgs, pkgs-stable, ... }:
let
  chwall = pkgs.writeScriptBin "chwall" /* bash */ ''
    #!/usr/bin/env bash
    
    if [ "$#" -ne 1 ]; then
      echo "Usage: chwall <path-to-wallpaper>"
      exit 1
    fi
    swww img $1
    wal -s -n -i $1
    echo "wallpaper changed" | socat - UNIX-CONNECT:/tmp/color_server.sock
  ''; 
in
{
  home.packages = with pkgs; [
    chwall
    wl-clipboard
    mako
    dmenu
    playerctl
    swww
    python312Packages.pywal
    fuzzel
    eww-wayland
    dunst
    cliphist
    swappy
  ];
}
