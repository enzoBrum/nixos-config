return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    cond = false,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'java', 'dockerfile', 'json' ,'yaml', 'lua', 'luadoc', 'markdown', 'regex', 'markdown_inline', 'jsdoc', "http", "comment"},
        auto_install = false,
        sync_install = false,
        highlight = { enable = false },
        indent = { enable = true },
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
    end
  }
}
