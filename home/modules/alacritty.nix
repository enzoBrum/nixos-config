{ inputs, config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = let
      name = "MesloLGS NF";
    in {
      window.opacity = 0.8;
      font = {
        normal = {
          family = name;
          style = "Regular";
        };
        bold = {
          family = name;
          style = "Bold";
        };
        italic = {
          family = name;
          style = "Italic";
        };
        bold_italic = {
          family = name;
          style = "Bold Italic";
        };
      };
    } // builtins.fromTOML (builtins.readFile (inputs.dracula-alacritty + /dracula.toml));
  };
}
