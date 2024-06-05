return {
  {
    "catppuccin/nvim", name = "catppuccin", priority = 1000, 
    config = function ()
      vim.cmd.colorscheme "catppuccin-macchiato"
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#8bd5ca" })
    end
  }
}
