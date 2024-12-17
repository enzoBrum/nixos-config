{ config, lib, pkgs, ... }:
{
  imports = [ ./modules.nix ./vars.nix ];

  home.username = "erb";
  home.homeDirectory = "/home/erb";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
