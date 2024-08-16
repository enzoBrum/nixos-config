{ config, lib, pkgs, ... }:
let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter.dependencies;
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      basedpyright
      nodePackages_latest.vscode-json-languageserver
      dockerfile-language-server-nodejs
      docker-compose-language-service
      clang-tools
      nodePackages_latest.vscode-langservers-extracted
      (python312.withPackages (ps: with ps; [ black flake8 pylint isort ]))
      ripgrep
      fzf
      fd
      lua-language-server
      typescript-language-server
      typescript
      jdt-language-server
      nodejs_22
      nil
    ];
    plugins = with pkgs.vimPlugins; [
      treesitter
    ];
  };

  # TODO: do this programatically.
  xdg.configFile."nvim/coc-settings.json".source = config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/coc-settings.json;
  xdg.configFile."nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/lazy-lock.json;
  xdg.configFile."nvim/lua" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/neovim/nvim/lua;
    recursive = true;
  };
  xdg.configFile."nvim/init.lua".source = pkgs.writeText "init.lua" /* lua */ ''
      require("config.options")
      require("config.mappings")
      require("config.lazy")

      if not vim.g.vscode then
        vim.opt.runtimepath:append("${treesitter-parsers}")
      end
  '';
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitter;
  };

}
