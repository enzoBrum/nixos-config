{ config, pkgs, pkgs-stable, ... }:
let
  run = pkgs.writeScriptBin "run" ''
    #!/usr/bin/env bash
    program=$(cat $1 | head -n 1 | awk -F '/' '{print $NF}')
    sed '1s/.*/\/usr\/bin\/env $program/' $1 | bash -s - $2 $3 $4 $5 $6 $7
  '';
in
{
  environment.systemPackages = with pkgs; [
    xorg.xhost
    fd
    nix-search-cli
    tree
    eza
    jq
    firefox-bin
    google-chrome
    tldr
    obs-studio
    wget
    ripgrep
    kitty
    blackbox-terminal
    home-manager
    python312
    networkmanagerapplet
    htop
    fzf
    grc
    killall
    discord
    webcord
    run
    spotify
    slurp
    grim
    brightnessctl
    wineWowPackages.waylandFull
    winetricks
    vulkan-tools
    lutris
    fastfetch
    libsForQt5.kdenlive
    acpi
    swaylock
    libnotify
    unzip
    xfce.thunar
    neovim
    p7zip
    lazydocker
    lazygit
  ];
}
