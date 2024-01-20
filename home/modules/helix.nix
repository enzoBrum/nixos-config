{config, pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      python311Packages.python-lsp-server
      nil
    ];
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        true-color = true;
        auto-save = true;
      };
      
      keys.normal = {
        A-x = ["extend_line_up" "extend_to_line_bounds"];
      };

      keys.select = {
        A-x = ["extend_line_up" "extend_to_line_bounds"];
      };
    };
  };
}
