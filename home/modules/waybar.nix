{ inputs, pkgs, ... }: {
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [ "eDP-1" "HDMI-A-1" ];
      modules-left = [ "image" "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "battery" "network" "custom/notification" ];

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
        format = "{:%b %d    %R}  ";
        interval = 60;
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

      network = {
        tooltip = false;
        "format-wifi" = "     {essid}";
        "format-ethernet" = " {ipaddr}";
      };

      pulseaudio = {
        tooltip = false;
        "scroll-step" = 5;
        format = "{icon} {volume}%";
        "format-icons" = { "default" = [ "" "" "" ]; };
      };

      image = {
        path = "/home/erb/repos/nixos-config/assets/nix_logo.png";
        size = 20;
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    };
  };

  programs.waybar.style = ''
window#waybar {
    background: transparent;
}

#workspaces button {
    color: #f9c5a7;
    font-size: 15px;
    transition: all 0.2s ease;
}

#workspaces button.empty {
    color: #8a6a5a;
    font-size: 10px;
    opacity: 0.6;
}

#workspaces button.active {
    color: #ffd9bf;
    font-size: 16px;
}

#workspaces button:hover {
    color: #ffd4b3;
}

#battery,
#network,
#pulseaudio,
#custom-notification {
    margin-left: 8px;
    padding: 0 16px;
}

.modules-right {
    color: #2d2d2d;
    margin-left: 8px;
    padding: 4px 16px;
    background: linear-gradient(135deg, #7ec8a3 0%, #6ab58f 100%);
    border-radius: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.modules-center {
    color: #2d2d2d;
    margin-left: 8px;
    padding: 4px 16px;
    background: linear-gradient(135deg, #ff9a76 0%, #ff7f59 100%);
    border-radius: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.modules-left {
    margin-left: 8px;
    padding: 4px 16px;
    background: linear-gradient(135deg, #5a5a5a 0%, #454545 100%);
    border-radius: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}
  '';
}
