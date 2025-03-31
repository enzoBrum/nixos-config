return {
  "let-def/texpresso.vim",
  cond = not vim.g.vscode,
  ft = "tex",
  init = function()
    require('texpresso').attach()

    local open_texpresso = function()
      local filename = vim.fn.expand("%:t")
      vim.cmd("TeXpresso " .. filename);
    end

    local sync = function()
      local filepath = vim.fn.expand("%:p")
      vim.system({ "pkill", "texpresso" }, {}, function()
        vim.system({ "tectonic", "-X", "compile", "--keep-intermediates", filepath }, {}, function()
          vim.defer_fn(open_texpresso, 100)
        end)
      end)
    end
    vim.keymap.set("n", "<leader>lo", open_texpresso, { desc = "[L]atex open texpresso" })
    vim.keymap.set("n", "<leader>ls", sync, { desc = "[L]atex [S]ync" })
  end
}
