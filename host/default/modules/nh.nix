{ config, pkgs, ... }: {
  programs.nh = {
    enable = true;
    flake = "/home/erb/repos/nixos-config";
  };
}
