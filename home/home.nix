{ config, lib, pkgs, ... }:
let
  p10kTheme = "./scripts/.p10k.zsh";
in
{
  imports = [ ./modules.nix ];

  home.username = "erb";
  home.homeDirectory = "/home/erb";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
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
