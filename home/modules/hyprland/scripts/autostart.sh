#!/usr/bin/env bash

# variables
config=$HOME/repos/nixos-config/home/modules/hyprland
scripts=$config/scripts

if [ $(hyprctl monitors -j | jq length) -eq "2" ]; then
    hyprctl dispatch focusmonitor 1
    waybar &
else
    for number in {1..10}; do
        hyprctl keyword workspace "$number, monitor:eDP-1"
    done
    hyprctl dispatch workspace 1
    waybar -c "$config/waybar_one_monitor.json" &
fi

# clipboard manager
wl-paste --watch cliphist store &

# wallpaper
swww init &

#notification daemno
swaync &

# terminal
alacritty &

$scripts/change_color.py &
$scripts/change_wallpaper.py &
$scripts/battery_notifier.py &
$scripts/handle_events.py &

hyprctl setcursor Dracula-cursors 24 &

eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=ssh) &

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# # other
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# sleep 1 && docker kill $(docker ps -q) &
