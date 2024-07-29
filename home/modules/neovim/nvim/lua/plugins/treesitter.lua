return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    dev = true,
    opts = {
        indent = {
            enable = true
        },
        autotag = {
            enable = true
        },
        highlight = {
            -- `false` will disable the whole extension
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<leader>n',
                node_incremental = '<leader>n',
                scope_incremental = '<leader>s',
                node_decremental = '<leader>r',
            },

        },
    }

}
