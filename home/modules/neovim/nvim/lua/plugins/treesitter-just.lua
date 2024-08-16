if not vim.g.vscode then
  return {
    "IndianBoy42/tree-sitter-just",
    enable = not vim.g.vscode,
    cond = not vim.g.vscode
  }
else
  return {}
end
