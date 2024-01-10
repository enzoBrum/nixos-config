{config, lib, pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs; [
      vimPlugins.nvim-treesitter.withAllGrammars
    ];

    extraConfig = let
      files = lib.filesystem.listFilesRecursive ./lua;
      concatenate = (b: a: (builtins.readFile b) + "\n" + a);
      initial = "";
    in
      lib.fold concatenate initial files;
  };
}