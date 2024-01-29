{pkgs, ...}: 
let
    helpers = import ./helpers.nix;
in
{
    programs.neovim.plugins = with pkgs.vimPlugins; [
        (helpers.notUsedByVSCode {pkg = indent-blankline-nvim; name = "indent-blankline.nvim"; extraConfig = ''require("ibl").setup()'';} )
    ];
}
