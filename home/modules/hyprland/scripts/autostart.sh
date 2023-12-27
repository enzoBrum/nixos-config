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
copyq --start-server &

# wallpaper
swww init &

#notification daemno
dunst &

# terminal
alacritty &


$scripts/change_color.py &
sleep 1 && $scripts/change_wallpaper.py &
$scripts/change_workspace.py &
$scripts/battery_notifier.py &

# # change bar rounding and margin to follow hyprland
# # sleep 1 && $scripts/init_eww.py &

# # rokcet-chat
# # $scripts/init_rocket-chat.py > /dev/null 2>&1 &

# # other
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# sleep 1 && docker kill $(docker ps -q) &
