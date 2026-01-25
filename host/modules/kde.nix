{ config, pkgs, pkgs-stable, ... }: {
  services.displayManager.defaultSession = "plasma";
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
	sddm.wayland.enable = true;

        autoLogin = {
           enable = true;
           user = "erb";
        };
      };
    };
  };


  # see: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.desktopManager.plasma6.enable = true;  
}
