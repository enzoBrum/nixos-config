{config, pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = /* lua */ ''
        require('nvim-treesitter.configs').setup {
          highlight = {
            enable = true,
          },

          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn", -- set to `false` to disable one of the mappings
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },

          indent = { enable = true };
          rainbow = {enable = true};
        }
      '';
    }
  ];
}
