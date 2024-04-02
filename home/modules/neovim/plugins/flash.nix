{ pkgs, ... }:
let
  flash-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "flash-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "flash.nvim";
      rev = "48817af25f51c0590653bbc290866e4890fe1cbe";
      sha256 = "sha256-j917u46PaOG6RmsKKoUQHuBMfXfGDD/uOBzDGhKlwTE=";
    };
  };
in
{
  programs.neovim.plugins = [{
    plugin = flash-nvim;
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

