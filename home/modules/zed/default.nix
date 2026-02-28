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
    extraPackages = with pkgs; [
      basedpyright
      nodePackages_latest.vscode-json-languageserver
      dockerfile-language-server-nodejs
      docker-compose-language-service
      clang-tools
      pkgs.nodePackages_latest.vscode-langservers-extracted
      (python312.withPackages (
        ps: with ps; [
          black
          flake8
          pylint
          isort
        ]
      ))
      ripgrep
      fzf
      fd
      lua-language-server
      typescript-language-server
      typescript
      jdt-language-server
      nodejs_22
      nil
      libxml2
      curl
      gcc
      jq
      gnumake
      nodejs_22
      openjdk21
    ];
  };

  # TODO: do this programatically.
  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/zed/settings.json;
  xdg.configFile."zed/keymap.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/zed/keymap.json;
}
