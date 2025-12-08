if vim.g.vscode then
   vim.o.relativenumber = true
   vim.api.nvim_create_autocmd("InsertEnter", {
      pattern = "*",
      callback = function ()
         vim.o.relativenumber = false
      end
   })
   vim.api.nvim_create_autocmd("InsertLeave", {
      pattern = "*",
      callback = function ()
         vim.o.relativenumber = true
      end
   })
end
