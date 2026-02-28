return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()

        require("nvim-surround").setup()

        vim.g.nvim_surround_no_normal_mappings = true
        vim.keymap.set("n", "<leader>z", "<Plug>(nvim-surround-normal)", {
            desc = "Add a surrounding pair around a motion (normal mode)",
        })
        vim.keymap.set("n", "<leader>x", "<Plug>(nvim-surround-delete)", {
            desc = "Add a surrounding pair around a motion (normal mode)",
        })
        vim.keymap.set("n", "<leader>c", "<Plug>(nvim-surround-change)", {
            desc = "Add a surrounding pair around a motion (normal mode)",
        })
    end
  }
}
