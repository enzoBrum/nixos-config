{ pkgs, ... }:
{
  programs.neovim.plugins = [{
    plugin = pkgs.vimPlugins.flash-nvim;
    type = "lua";
    config = /* lua */
      ''
        require("flash").setup({})
        vim.keymap.set({"n", "x", "o"}, "s", function() require("flash").jump() end)
        vim.keymap.set({"n", "x", "o"}, "S", function() require("flash").treesitter() end)
        vim.keymap.set("o", "r", function() require("flash").remote() end)
        vim.keymap.set({"x", "o"}, "R", function() require("flash").treesitter_search() end)
        vim.keymap.set("c", "<c-s>", function() require("flash").toogle() end)
      '';
  }];
}

