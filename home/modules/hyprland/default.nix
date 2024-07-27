{ config, lib, pkgs, inputs, ... }: {
  imports = [ ./packages.nix ./hyprlock.nix ./swaync.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/hyprland/hyprland.conf;
}
