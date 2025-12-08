{ config, pkgs, pkgs-stable, ... }: {
  services.xserver.desktopManager.gnome.enable = false;
  security.pam.services.erb.enableGnomeKeyring = false;

  environment.systemPackages = with pkgs.gnomeExtensions;
    [ paperwm vitals caffeine clipboard-indicator blur-my-shell user-themes ];
}
