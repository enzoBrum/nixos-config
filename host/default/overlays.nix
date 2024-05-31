{ pkgs, coc-extensions, ... }:
let
  coc-packages = (super: builtins.listToAttrs (
    map
      (name: {
        name = name;
        value = super.vimUtils.buildVimPlugin { inherit name; src = builtins.getAttr name coc-extensions; };
      })
      (builtins.attrNames { coc-pyright = super.coc-pyright.src; coc-basedpyright = coc-extensions.coc-basedpyright; })));
in
{
  # nixpkgs = {
  #   overlays = [
  #     (self: super: {
  #       vimPlugins = super.vimPlugins // (coc-packages super);
  #       # inherit coc-packages;
  #       # coc-basedpyright = pkgs.vimUtils.buildVimPlugin { name = "coc-basedpyright"; src = coc-extensions.coc-basedpyright; };
  #     })
  #   ];
  # };
}
