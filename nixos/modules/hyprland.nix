{ config, pkgs, pkgs-stable, hyprland, ... }: {
  programs.hyprland.enable = true;
  # programs.hyprland.package = hyprland.packages.${pkgs.system}.hyprland;
  programs.hyprland.xwayland.enable = true;

  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  security.pam.services.swaylock = { };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
