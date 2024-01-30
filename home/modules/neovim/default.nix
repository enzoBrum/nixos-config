{ config, lib, pkgs, ... }:
let
  ignoredFiles = [ "helpers.nix" "vim-visual-multi.nix" ];
  plugins = lib.filesystem.listFilesRecursive ./plugins;
in
{
  # functional black magic! Love it.
  imports = lib.filter
    (plugin:
      !lib.any (ignored: lib.strings.hasSuffix ignored plugin) ignoredFiles)
    plugins;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = /* lua */
      ''
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
        vim.o.updatetime = 250
        vim.o.timeoutlen = 300
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

        -- [[ Basic Keymaps ]]

        -- Keymaps for better default experience
        -- See `:help vim.keymap.set()`
        vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

        -- Remap for dealing with word wrap
        vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
        vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

        -- clipboard 
        vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Copy to system clipboard" })
        vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = "Paste after cursor from system clipboard" })
        vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = "Paste before cursor from system clipboard" })


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
      '';
  };
}
