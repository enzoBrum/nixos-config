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
      nodePackages_latest.vscode-html-languageserver-bin
      (python312.withPackages (ps: with ps; [ black flake8 pylint isort ]))
      ripgrep
      fzf
      fd
    ];
    plugins = with pkgs.vimPlugins; [
      treesitter
    ];
    extraLuaConfig = /* lua */
    ''
      require("config.options")
      require("config.mappings")
      require("config.lazy")
      vim.opt.runtimepath:append("${treesitter-parsers}")

    '';
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitter;
  };
}
