{ config, lib, pkgs, ... }:
let
  p10kTheme = "./scripts/.p10k.zsh";
in
{
  imports = [ ./modules.nix ];

  home.username = "erb";
  home.homeDirectory = "/home/erb";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
  };


  # bluetooth-related settings
  services.mpris-proxy.enable = true;

  # virtualisation-related settings.
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
