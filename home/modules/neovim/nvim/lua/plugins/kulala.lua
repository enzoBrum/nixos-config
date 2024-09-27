vim.filetype.add({
    extension = {
        ['http'] = 'http',
    },
})
return {
    'mistweaverco/kulala.nvim',
    opts = {},
    branch = "main",
    keys = {
        {
            "<leader>h",
            mode = "n",
            function()
                require("kulala").run()
            end,
            desc = "Run [H]ttp request"
        },
    }
}
