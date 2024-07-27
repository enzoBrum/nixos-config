{ config, pkgs, pkgs-stable, inputs, ... }: {
  programs.hyprland.enable = true;
  #programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  programs.hyprland.xwayland.enable = true;

  programs.mtr.enable = true;
  security.pam.services.swaylock = { };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = [
    pkgs.polkit_gnome
  ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
