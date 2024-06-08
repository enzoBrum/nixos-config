{ pkgs, ... }:
let helpers = import ./helpers.nix;
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    (helpers.notUsedByVSCode {
      pkg = vim-fugitive;
      name = "vim-fugitive";
    })
    (helpers.notUsedByVSCode {
      pkg = vim-rhubarb;
      name = "vim-rhubarb";
    })
    (helpers.notUsedByVSCode {
      pkg = gitsigns-nvim;
      name = "gitsigns.nvim";
      extraConfig = /* lua */
        ''
          require('gitsigns').setup()
        '';
    })
  ];
}
