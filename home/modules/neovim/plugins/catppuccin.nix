{ pkgs, ... }:
let helpers = import ./helpers.nix;
in {
  programs.neovim.plugins = with pkgs.vimPlugins;
    [
      (helpers.notUsedByVSCode {
        pkg = catppuccin-nvim;
        name = "catppuccin-nvim";
        extraConfig = "vim.cmd.colorscheme 'catppuccin-macchiato' ";
      })
    ];
}
