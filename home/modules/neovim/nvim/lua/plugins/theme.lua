return {
  {
    "Mofiqul/dracula.nvim", name = "dracula", priority = 1000, 
    cond = not vim.g.vscode,
    config = function ()
      vim.cmd.colorscheme "dracula"
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#a4ffff" })
    end
  }
}
