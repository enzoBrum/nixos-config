{ config, pkgs, pkgs-stable, ... }: {
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
        defaultSession = "hyprland";
        autoLogin = {
          enable = true;
          user = "erb";
        };
      };
      desktopManager.gnome.enable = true;
    };
  };
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  security.pam.services.swaylock = { };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
