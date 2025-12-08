local vscode = not vim.g.vscode

return {
  {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      cond = vscode,
      dependencies = {
        {"nvim-tree/nvim-web-devicons", cond = not vim.g.vscode },
      },
      config = function()
        require("nvim-tree").setup {}

        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- empty setup using defaults
        require("nvim-tree").setup() 
        
        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
      end
  }
}
