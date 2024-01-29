{
  notUsedByVSCode = {pkg, name, extraConfig ? ""}: {
    plugin = pkg;
    type = "lua";
    config = /* lua */
    ''
      if not vim.g.vscode then
        vim.cmd("packadd ${name}")
        ${extraConfig}
      end
    '';
  };
}
