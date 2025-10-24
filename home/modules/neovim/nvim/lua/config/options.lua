vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
if vim.g.vscode then
    vim.o.updatetime = 100
    vim.o.timeoutlen = 200
else
    vim.o.updatetime = 50
    vim.o.timeoutlen = 150
end
vim.o.relativenumber = true;

vim.o.expandtab = true;
vim.o.autoindent = true;
vim.o.smartindent = true;
vim.o.wrap = false;
--vim.o.tabstop = 4
--vim.o.softtabstop = 4
--vim.opt.shiftwidth = 4

local group = vim.api.nvim_create_augroup('FileTypeSettings', { clear = true })

--[[
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'nix',
    command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2',
    group = group,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'py',
    command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4',
    group = group,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cpp',
    command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2',
    group = group,
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4',
    group = group,
})
--]]
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.o.relativenumber = true
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.o.relativenumber = false
    end
})
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        vim.o.relativenumber = true
    end
})

-- Add this to your init.lua or a separate lua file
function OpenNewFileSameDir()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == "" then
        vim.notify("No file currently open", vim.log.levels.WARN)
        return
    end

    local dir = vim.fn.fnamemodify(current_file, ":h") -- get directory of current file
    local new_filename = vim.fn.input("New file name: ", dir .. "/", "file")

    if new_filename == "" then
        vim.notify("Canceled", vim.log.levels.INFO)
        return
    end

    vim.cmd("edit " .. vim.fn.fnameescape(new_filename))
end

-- Optional: create a keybinding
vim.api.nvim_set_keymap("n", "<leader>of", ":lua OpenNewFileSameDir()<CR>", { noremap = true, silent = true })
