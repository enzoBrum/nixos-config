{pkgs, ...}: 
let
  helpers = import ./helpers.nix;
in
{
    programs.neovim.plugins = with pkgs.vimPlugins; [
      (helpers.notUsedByVSCode {pkg = which-key-nvim; name = "which-key.nvim"; extraConfig = ''require("which-key").setup {}'';})
    ];
}
