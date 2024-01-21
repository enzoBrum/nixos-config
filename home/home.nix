{ config, lib, pkgs, ... }:
let
  theme-name = "Catppuccin-Macchiato-Compact-Pink-Dark";
  theme-pkg = pkgs.catppuccin-gtk.override {
    accents = [ "pink" ];
    size = "compact";
    variant = "macchiato";
  };
  # theme-name = "Dracula";
  # theme-pkg = pkgs.dracula-theme;
in
{
  imports = [ ./modules.nix ];

  home.username = "erb";
  home.homeDirectory = "/home/erb";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme.package = pkgs.catppuccin-gtk.override {
      accents = [ "pink" ];
      size = "standard";
      variant = "macchiato";
    };
    theme.name = "Catppuccin-Macchiato-Standard-Pink-Dark"; # note to self, the name is important. If you do not know the name, use gnome-tweaks.
  };

  xdg.configFile."gdb/gdbinit".text = ''
  python
  import sys
  sys.path.insert(0, '${pkgs.libgcc.lib}/share/gcc-${pkgs.libgcc.lib.version}/python')
  from libstdcxx.v6.printers import register_libstdcxx_printers
  register_libstdcxx_printers (None)
  end
  '';

  # bluetooth-related settings
  services.mpris-proxy.enable = true;

  # virtualisation-related settings.
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
