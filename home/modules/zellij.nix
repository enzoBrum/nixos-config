{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  xdg.configFile."zellij/config.kdl".text = /* kdl */ ''
    copy_command "wl-copy"
    theme "catppuccin-macchiato"
  '';
}
