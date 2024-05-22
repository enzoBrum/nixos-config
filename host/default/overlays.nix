{ pkgs, coc-extensions, ... }:
let
  coc-packages = builtins.listToAttrs (map (name: pkgs.vimUtils.buildVimPlugin { inherit name; src = builtins.getAttr coc-extensions name; }) (builtins.attrNames coc-extensions));
in
{
  nixpkgs = {
    overlays = [
      (self: super: {
        inherit coc-packages;
      })
    ];
  };
}
