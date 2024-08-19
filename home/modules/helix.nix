{ config, pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    extraPackages = with pkgs; [ pkgs.pyright nil ];
    languages = {
      language-server = {
        pyright = {
          command = "pyright-langserver";
          args = ["--stdio"];
          config = {};
        };
      };
      language = [
        {
          name = "python";
          language-servers = ["pyright"];
        }
      ];
    };
    settings = {
      theme = "dracula";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        true-color = true;
        auto-save = true;
      };

      keys.normal = { A-x = [ "extend_line_up" "extend_to_line_bounds" ]; };

      keys.select = { A-x = [ "extend_line_up" "extend_to_line_bounds" ]; };
    };
  };
}
