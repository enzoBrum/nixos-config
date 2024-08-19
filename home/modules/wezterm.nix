{ pkgs, ... }: {
  programs.wezterm = {
    enable = false;
    extraConfig = /* lua */
      ''
        config = {
          -- ...your existing config
          color_scheme = "Dracula",
          use_fancy_tab_bar = false,
        }

        config.keys = {}
        for i = 1, 9 do
          table.insert(config.keys, {
            key = tostring(i),
            mods = 'ALT',
            action = wezterm.action.ActivateTab( (i % 9) - 1 ) -- 1 --> 0, 2 --> 1, ..., 9 --> -1
          })
        end

        return config
      '';
  };
}
