{ config, pkgs, pkgs-stable, ... }:
let
  run = pkgs.writeScriptBin "run" ''
    #!/usr/bin/env bash
    program=$(cat $1 | head -n 1 | awk -F '/' '{print $NF}')
    sed '1s/.*/\/usr\/bin\/env $program/' $1 | bash -s - $2 $3 $4 $5 $6 $7
  '';
in {
  environment.systemPackages = with pkgs; [
    catppuccin
    tree
    eza
    jq
    firefox-bin
    tldr
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    ripgrep
    kitty
    home-manager
    python312
    networkmanagerapplet
    htop
    nodejs
    fzf
    clang
    gcc
    grc
    killall
    discord
    webcord
    run
    spotify
    gnumake
    slurp
    grim
    brightnessctl
    wineWowPackages.waylandFull
    winetricks
    vulkan-tools
    lutris
    fastfetch
    obs-studio
    libsForQt5.kdenlive
    acpi
    swaylock
    libnotify
    unzip
    xfce.thunar
    neovim
    p7zip
  ];
}
