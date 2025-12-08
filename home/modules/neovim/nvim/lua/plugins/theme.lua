return {
  {
    "Mofiqul/dracula.nvim", name = "dracula", priority = 1000, 
    cond = not vim.g.vscode,
    config = function ()
      vim.cmd.colorscheme "dracula"
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#a4ffff" })
      vim.api.nvim_set_hl(0, "SignColumn", {bg = nil})
      vim.api.nvim_set_hl(0, "NormalFloat", {bg = nil})
      --vim.api.nvim_set_hl(0, "FloatBorder", {fg = "#ffffff"})

      

      vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
      ]]
    end
  }
}
