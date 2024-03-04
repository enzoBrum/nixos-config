#!/usr/bin/env bash

# variables
config=$HOME/repos/nixos-config/home/modules/hyprland
scripts=$config/scripts

if [ $(hyprctl monitors -j | jq length) -eq "2" ]; then
    hyprctl dispatch focusmonitor 1
else
    for number in {1..10}; do
        hyprctl keyword workspace '$number, monitor:eDP-1' 
    done
    hyprctl dispatch workspace 1
fi

# clipboard manager
wl-paste --watch cliphist store &

# wallpaper
swww init &

#notification daemno
swaync &

# terminal
blackbox &

$scripts/change_color.py &
$scripts/change_wallpaper.py &
$scripts/change_workspace.py &
$scripts/battery_notifier.py &

hyprctl setcursor Catppuccin-Macchiato-Blue-Cursors 26 &
waybar &

eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=ssh) &

# # other
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# sleep 1 && docker kill $(docker ps -q) &
