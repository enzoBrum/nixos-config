# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.enable = true;
  dconf.settings = {
    "org/fedorahosted/background-logo-extension" = {
      logo-always-visible = true;
      logo-border = mkUint32 50;
      logo-position = "bottom-left";
    };

    "org/gnome/control-center" = {
      last-panel = "power";
      window-state = mkTuple [ 656 1028 false ];
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri =
        "file:///home/erb/repos/nixos-config/assets/wallpaper/wallhaven-7pm1qy_1920x1080.png";
      picture-uri-dark =
        "file:///home/erb/repos/nixos-config/assets/wallpaper/wallhaven-7pm1qy_1920x1080.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      sources = [ (mkTuple [ "xkb" "br" ]) ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri =
        "file:///home/erb/repos/nixos-config/assets/wallpaper/wallhaven-7pm1qy_1920x1080.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/wm/keybindings" = {
      maximize = [ "<Super>Up" ];
      minimize = [ "<Shift><Control><Alt><Super>F1" ];
      move-to-monitor-down = [ ];
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];
      move-to-monitor-up = [ ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-group = [ "<Super>Above_Tab" "<Alt>Above_Tab" ];
      switch-group-backward = [ ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
      switch-to-workspace-1 = [ ];
      switch-to-workspace-last = [ ];
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];
      unmaximize = [ "<Super>Down" "<Alt>F5" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      auto-raise = false;
      button-layout = "appmenu:close";
      focus-mode = "click";
      num-workspaces = 20;
      workspace-names = [ ];
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = false;
      edge-tiling = false;
      workspaces-only-on-primary = false;
    };

    "org/gnome/mutter/keybindings" = {
      cancel-input-capture = [ ];
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };

    "org/gnome/mutter/wayland/keybindings" = { restore-shortcuts = [ ]; };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      control-center = [ "<Super>e" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      logout = [ "<Alt><Super>q" ];
      next = [ "<Shift><Super>space" ];
      play = [ "<Super>space" ];
      rotate-video-lock-static = [ ];
      screensaver = [ "<Super>q" ];
      www = [ "<Super>z" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>Return";
        command = "blackbox";
        name = "terminal";
      };

    "org/gnome/shell" = {
      enabled-extensions = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "focus-changer@heartmire"
        "Vitals@CoreCoding.com"
        "caffeine@patapon.info"
        "pano@elhan.io"
        "paperwm@paperwm.github.com"
        "blur-my-shell@aunetx"
      ];
      favorite-apps = [
        "org.gnome.Calendar.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Software.desktop"
        "org.mozilla.firefox.desktop"
      ];
      welcome-dialog-last-shown-version = "45.0";
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      customize = true;
      whitelist = [ ];
      # whitelist = [ "com.raggesilver.BlackBox" ];
    };

    "org/gnome/shell/extensions/pano" = {
      global-shortcut = [ "<Super>v" ];
      paste-on-select = false;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
    };

    "org/gnome/shell/extensions/paperwm" = {
      restore-attach-modal-dialogs = "true";
      restore-edge-tiling = "true";
      restore-keybinds = ''
        {"cancel-input-capture":{"bind":"[\\"<Super><Shift>Escape\\"]","schema_id":"org.gnome.mutter.keybindings"},"toggle-tiled-right":{"bind":"[\\"<Super>Right\\"]","schema_id":"org.gnome.mutter.keybindings"},"toggle-tiled-left":{"bind":"[\\"<Super>Left\\"]","schema_id":"org.gnome.mutter.keybindings"},"restore-shortcuts":{"bind":"[\\"<Super>Escape\\"]","schema_id":"org.gnome.mutter.wayland.keybindings"},"switch-to-workspace-last":{"bind":"[\\"<Super>End\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"move-to-monitor-right":{"bind":"[\\"<Super><Shift>Right\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-to-workspace-left":{"bind":"[\\"<Super>Page_Up\\",\\"<Super><Alt>Left\\",\\"<Control><Alt>Left\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-applications":{"bind":"[\\"<Super>Tab\\",\\"<Alt>Tab\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"move-to-monitor-down":{"bind":"[\\"<Super><Shift>Down\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-applications-backward":{"bind":"[\\"<Shift><Super>Tab\\",\\"<Shift><Alt>Tab\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-to-workspace-1":{"bind":"[\\"<Super>Home\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-to-workspace-right":{"bind":"[\\"<Super>Page_Down\\",\\"<Super><Alt>Right\\",\\"<Control><Alt>Right\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-group-backward":{"bind":"[\\"<Shift><Super>Above_Tab\\",\\"<Shift><Alt>Above_Tab\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"move-to-monitor-up":{"bind":"[\\"<Super><Shift>Up\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"move-to-monitor-left":{"bind":"[\\"<Super><Shift>Left\\"]","schema_id":"org.gnome.desktop.wm.keybindings"},"switch-to-application-1":{"bind":"[\\"<Super>1\\"]","schema_id":"org.gnome.shell.keybindings"},"shift-overview-down":{"bind":"[\\"<Super><Alt>Down\\"]","schema_id":"org.gnome.shell.keybindings"},"toggle-message-tray":{"bind":"[\\"<Super>n\\"]","schema_id":"org.gnome.shell.keybindings"},"switch-to-application-2":{"bind":"[\\"<Super>2\\"]","schema_id":"org.gnome.shell.keybindings"},"shift-overview-up":{"bind":"[\\"<Super><Alt>Up\\"]","schema_id":"org.gnome.shell.keybindings"},"rotate-video-lock-static":{"bind":"[\\"<Super>o\\",\\"XF86RotationLockToggle\\"]","schema_id":"org.gnome.settings-daemon.plugins.media-keys"}}
      '';
      restore-workspaces-only-on-primary = "true";
      show-workspace-indicator = false;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>w" ];
      live-alt-tab = [ "" ];
      move-down = [ "<Shift><Super>j" ];
      move-down-workspace = [
        "<Control><Super>Page_Down"
        "<Shift><Super>braceright"
        "<Shift><Super>at"
      ];
      move-left =
        [ "<Control><Super>comma" "<Shift><Super>comma" "<Shift><Super>h" ];
      move-monitor-left = [
        "<Shift><Control><Super>Left"
        "<Shift><Super>Left"
        "<Shift><Alt><Super>h"
      ];
      move-monitor-right = [
        "<Shift><Control><Super>Right"
        "<Shift><Super>Right"
        "<Shift><Alt><Super>l"
      ];
      move-right =
        [ "<Control><Super>period" "<Shift><Super>period" "<Shift><Super>l" ];
      move-up = [ "<Shift><Super>k" ];
      move-up-workspace = [
        "<Control><Super>Page_Up"
        "<Shift><Super>braceleft"
        "<Shift><Super>exclam"
      ];
      new-window = [ "<Super>n" ];
      previous-workspace = [ "" ];
      switch-down = [ "<Super>j" ];
      switch-down-workspace =
        [ "<Super>Page_Down" "<Super>bracketright" "<Super>2" ];
      switch-down-workspace-from-all-monitors = [ "" ];
      switch-left = [ "<Super>h" ];
      switch-monitor-left = [ "<Alt><Super>h" "<Super>Left" ];
      switch-monitor-right = [ "<Alt><Super>l" "<Super>Right" ];
      switch-right = [ "<Super>l" ];
      switch-up = [ "<Super>k" ];
      switch-up-workspace =
        [ "<Super>Page_Up" "<Super>1" "<Super>bracketleft" ];
      toggle-maximize-width = [ "<Super>Tab" ];
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ "<Shift><Super>n" ];
      shift-overview-down = [ ];
      shift-overview-up = [ ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      toggle-message-tray = [ ];
    };

    "org/gnome/system/location" = { enabled = true; };
  };
}
