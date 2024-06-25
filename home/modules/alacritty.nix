{ inputs, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;
    } // builtins.fromTOML (builtins.readFile (inputs.dracula-alacritty + /dracula.toml));
  };
}
