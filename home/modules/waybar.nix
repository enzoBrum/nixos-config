{ config, pkgs, ... }: {
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [ "eDP-1" "HDMI-A-1" ];
      modules-left = [ "image" "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "battery" "network" ];

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
    };
  };

  programs.waybar.style = ''
    #workspaces button {
         color: #a7cad2;
         font-size: 15px;
    }
     #workspaces button.empty {
         color: #3f717c ;
         font-size: 9px;
    }
     #workspaces button.active {
         color: #a7cad2;
         font-size: 15px;
    }
     #battery {
         margin-left: 8px;
         padding-left: 16px;
         padding-right: 16px;
    }
     #network {
         margin-left: 8px;
         padding-left: 16px;
         padding-right: 16px;
    }
     #pulseaudio {
         margin-left: 8px;
         padding-left: 16px;
         padding-right: 16px;
    }
     .modules-right {
         color: #4d4d4d;
         margin-left: 8px;
         padding-left: 16px;
         padding-right: 16px;
         background: #a7cad2;
         border-radius: 13px;
    }
     .modules-center {
         color: #4d4d4d;
         margin-left: 8px;
         padding-left: 16px;
         padding-right: 16px;
         background: #bd93f9;
         border-radius: 13px;
    }
     .modules-left {
         margin-left: 8px;
         padding-left: 16px;
         padding-right: 16px;
         background: #424242;
         border-radius: 13px;
    }

  '';
}
