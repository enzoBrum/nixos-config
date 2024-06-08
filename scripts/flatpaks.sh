#!/usr/bin/env bash

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
flatpak install flathub chat.rocket.RocketChat -y
flatpak install flathub com.github.tchx84.Flatseal -y
