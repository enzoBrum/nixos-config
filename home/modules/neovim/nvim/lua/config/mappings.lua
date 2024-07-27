vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clipboard 
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = "Paste after cursor from system clipboard" })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = "Paste before cursor from system clipboard" })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>z', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
