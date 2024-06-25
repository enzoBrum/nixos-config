{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins;
    [
      {
        plugin = dracula-nvim;
        type = "lua";
        config = "vim.cmd.colorscheme 'dracula' ";
      }
    ];
}
