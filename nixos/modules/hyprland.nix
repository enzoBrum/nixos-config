{ config, pkgs, pkgs-stable, ... }: {
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
