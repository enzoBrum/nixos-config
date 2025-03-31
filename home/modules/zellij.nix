{ pkgs, ... }: {
  home.packages = [
    pkgs.zellij
  ];
  xdg.configFile."zellij/config.kdl".text = /* kdl */ ''
    copy_command "wl-copy"
    theme "dracula"

    keybinds {
      unbind "Ctrl h"
      move {
        bind "Ctrl e" { SwitchToMode "Normal"; }
      }
      shared_except "move" "locked" {
        bind "Ctrl e" { SwitchToMode "Move"; }
      }
    }
  '';
}
