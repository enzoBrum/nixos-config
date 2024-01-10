{config, pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      python311Packages.python-lsp-server
      nil
    ];
    settings = {
      theme = "dracula";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
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
