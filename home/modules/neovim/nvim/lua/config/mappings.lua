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

vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split [V]ertically" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Split [H]orizontally" })
vim.keymap.set("n", "<leader>w", ":close<CR>", { desc = "Close split" })
vim.keymap.set("n", "<leader>=", "<C-w>=")

vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "[T]ab [O]pen" })
vim.keymap.set("n", "<leader>tw", ":tabclose<CR>", { desc = "[T]ab close" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "[T]ab [N]ext" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "[T]ab [P]revious" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
