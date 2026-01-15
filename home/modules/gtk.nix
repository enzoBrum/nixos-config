{ config, pkgs, ... }: {
  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
    size = 24;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    #theme.package = pkgs.dracula-theme;
    #theme.name =
    #  "Dracula"; # note to self, the name is important. If you do not know the name, use gnome-tweaks.

    #iconTheme.name = "Dracula";
    #iconTheme.package = pkgs.dracula-icon-theme;
  };
  xdg.dataFile."flatpak/overrides/global".text = ''
    [Context]
    filesystems=/home/erb/.icons:ro;/home/erb/.themes:ro;/home/erb/.cursors:ro;

    [Environment]
    GTK_THEME=Dracula
    ICON_THEME=Dracula
    XCURSOR_THEME=Dracula
  '';
}
