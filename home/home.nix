{ config, lib, pkgs, ... }:
{
  imports = [ ./modules.nix ];

  home.username = "erb";
  home.homeDirectory = "/home/erb";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
    size = 24;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name =
      "Dracula"; # note to self, the name is important. If you do not know the name, use gnome-tweaks.

    iconTheme.name = "Dracula";
    iconTheme.package = pkgs.dracula-icon-theme;
  };

  xdg.configFile."gdb/gdbinit".text = ''
    python
    import sys
    sys.path.insert(0, '${pkgs.libgcc.lib}/share/gcc-${pkgs.libgcc.lib.version}/python')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
    end
  '';


  xdg.dataFile."flatpak/overrides/global".text = ''
    [Context]
    filesystems=/home/erb/.icons:ro;/home/erb/.themes:ro;/home/erb/.cursors:ro;

    [Environment]
    GTK_THEME=Dracula
    ICON_THEME=Dracula
    XCURSOR_THEME=Dracula
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
