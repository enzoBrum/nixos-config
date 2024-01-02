{ config, pkgs, ... }: {
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];
      modules-left = [ "image" "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "mpris" ];
      modules-right = [ "clock" "battery" "network" ];

      "battery" = {
        bat = "BAT1";
        interval = 60;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        "format-icons" = [ "" "" "" "" "" ];
        "max-length" = 25;
      };

      clock = {
        format = "{:%H:%M} \uf017 ";
        "format-alt" = "{:%A, %B %d, %Y (%R)} \uf5ef ";
        "tooltip-format" = "\n<span size='9pt' font='WenQuanYi Zen Hei Mono'>{calendar}</span>";
        calendar = {
          mode = "year";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "on-click-right" = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          "on-click-right" = "mode";
          "on-click-forward" = "tz_up";
          "on-click-backward" = "tz_down";
          "on-scroll-up" = "shift_up";
          "on-scroll-down" = "shift_down";
        };
      };

      "hyprland/workspaces" = {
        "active-only" = false;
        format = "{icon}";
        "format-icons" = {
          active = "";
          default = "";
          empty = "";
        };

        "persistent-workspaces" = {
          "eDP-1" = [ 11 12 13 14 15 16 17 18 19 20 ];
          "HDMI-A-1" = [ 1 2 3 4 5 6 7 8 9 10 ];
        };
      };

      mpris = {
        format = "DEFAULT: {player_icon} {dynamic}";
        "format-paused" = "DEFAULT: {status_icon} <i>{dynamic}</i>";
        "player-icons" = {
          default = "▶";
          mpv = "🎵";
        };
        "status-icons" = {
          paused = "⏸";
        };
      };
    };
  };


  programs.waybar.style = ''
    #workspaces button {
      color: #a7cad2;
      font-size: 15px;
    }
    #workspaces button.empty {
      color: #3f717c;
      font-size: 9px;
    }
    #workspaces button.active {
      color: #a7cad2;
      font-size: 15px;
    }
  '';
}
