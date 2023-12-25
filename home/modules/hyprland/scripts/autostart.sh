#!/usr/bin/env bash

# variables
config=$HOME/repos/nixos-config/home/modules/hyprland
scripts=$config/scripts

# # clean file
# true > /home/erb/scripts/pts_info

# clipboard manager
copyq --start-server &

# wallpaper
swww init &

#notification daemno
dunst &

# terminal
alacritty &

# bar
# eww open main_window &

if [ $(hyprctl monitors -j | jq length) -eq "2" ]; then
    hyprctl dispatch focusmonitor 1 &
fi

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
