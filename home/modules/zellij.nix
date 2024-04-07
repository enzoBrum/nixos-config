{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  xdg.configFile."zellij/config.kdl".text = /* kdl */ ''
    theme "catppuccin-macchiato"
  '';
}
