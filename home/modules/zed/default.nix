{
  inputs,
  config,
  lib,
  pkgs,
  pkgs-small,
  ...
}:
#let
#  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
#  treesitter-parsers = pkgs.symlinkJoin {
#    name = "treesitter-parsers";
#    paths = treesitter.dependencies;
#  };
#in
{
  programs.zed-editor = {
    enable = true;
  };

  # TODO: do this programatically.
  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/zed/settings.json;
  xdg.configFile."zed/keymap.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/zed/keymap.json;
}
