{ pkgs, ... }: {
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };
      aggregated = pkgs.buildEnv {
        name = "system-fonts-and-icons";
        paths = with pkgs; [
          (catppuccin-gtk.override
            {
              accents = [ "blue" ];
              size = "standard";
              variant = "macchiato";
            })
          catppuccin-cursors.macchiatoBlue
          dracula-theme
          dracula-icon-theme
        ];
        pathsToLink = [ "/share/themes" "/share/icons" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/home/erb/.cursors" = mkRoSymBind "${aggregated}/share/icons";
      "/home/erb/.themes" = mkRoSymBind "${aggregated}/share/themes";
    };
}
