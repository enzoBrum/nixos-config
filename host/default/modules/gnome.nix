{ config, pkgs, pkgs-stable, ... }: {
  services.xserver.desktopManager.gnome.enable = true;
  security.pam.services.erb.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs.gnomeExtensions;
    [ paperwm vitals caffeine clipboard-indicator blur-my-shell user-themes ];
}
