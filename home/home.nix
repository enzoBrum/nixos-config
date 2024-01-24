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
in {
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
    theme.name =
      "Catppuccin-Macchiato-Standard-Pink-Dark"; # note to self, the name is important. If you do not know the name, use gnome-tweaks.
  };

  xdg.configFile."gdb/gdbinit".text = ''
    python
    import sys
    sys.path.insert(0, '${pkgs.libgcc.lib}/share/gcc-${pkgs.libgcc.lib.version}/python')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
    end
  '';

  xdg.dataFile."blackbox/schemes/Catppuccin-Macchiato.json".text = # json
    ''
      {
        "name": "Catppuccin-Macchiato",
        "comment": "Soothing pastel theme for the high-spirited!",
        "background-color": "#24273A",
        "foreground-color": "#CAD3F5",
        "badge-color": "#5B6078",
        "bold-color": "#5B6078",
        "cursor-background-color": "#F4DBD6",
        "cursor-foreground-color": "#24273A",
        "highlight-background-color": "#F4DBD6",
        "highlight-foreground-color": "#24273A",
        "palette": [
          "#494D64",
          "#ED8796",
          "#A6DA95",
          "#EED49F",
          "#8AADF4",
          "#F5BDE6",
          "#8BD5CA",
          "#B8C0E0",
          "#5B6078",
          "#ED8796",
          "#A6DA95",
          "#EED49F",
          "#8AADF4",
          "#F5BDE6",
          "#8BD5CA",
          "#A5ADCB"
        ],
        "use-badge-color": false,
        "use-bold-color": false,
        "use-cursor-color": true,
        "use-highlight-color": true,
        "use-theme-colors": false
      }
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
