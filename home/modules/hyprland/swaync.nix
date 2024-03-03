{ pkgs, ... }:
let
  tag = "v0.1.2.1";
in
{
  xdg.configFile."swaync/style.css".text = (builtins.readFile (pkgs.fetchurl
    {
      url = "https://github.com/catppuccin/swaync/releases/download/${tag}/macchiato.css";
      hash = "sha256-6X+KSIYcPRQDGm1YV8rk5mq21Gk/pFCugOEoavh3tBw=";
    }));
}
