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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    #package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  # TODO: do this programatically.
  xdg.configFile."nvim/coc-settings.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/coc-settings.json;
  xdg.configFile."nvim/lazy-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/lazy-lock.json;
  xdg.configFile."nvim/lua" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/lua;
    recursive = true;
  };

  xdg.configFile."nvim/ftplugin" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/ftplugin;
    recursive = true;
  };
  xdg.configFile."nvim/init.lua".source =
    pkgs.writeText "init.lua" # lua
      ''
        require("config.options")
        require("config.mappings")
        require("config.lazy")
      '';
  #home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
  #  recursive = true;
  #  source = treesitter;
  #};

}
