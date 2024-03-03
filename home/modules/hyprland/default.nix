{ config, pkgs, inputs, ... }: {
  imports = [ ./packages.nix ./hyprlock.nix ./swaync.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    extraConfig = ''
      # This is an example Hyprland config file.
      #
      # Refer to the wiki for more information.

      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #
      general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
      	col.active_border = rgba(C86986ff)
      	col.inactive_border = rgba(643443ff)
        layout = dwindle
      }

      monitor=eDP-1,1920x1080@60,0x0,1
      monitor=HDMI-A-1,1920x1080@60,1920x0,1
      workspace=1, monitor:HDMI-A-1
      workspace=2, monitor:HDMI-A-1
      workspace=3, monitor:HDMI-A-1
      workspace=4, monitor:HDMI-A-1
      workspace=5, monitor:HDMI-A-1
      workspace=6, monitor:HDMI-A-1
      workspace=7, monitor:HDMI-A-1
      workspace=8, monitor:HDMI-A-1
      workspace=9, monitor:HDMI-A-1
      workspace=10, monitor:HDMI-A-1
      workspace=11, monitor:eDP-1
      workspace=12, monitor:eDP-1
      workspace=13, monitor:eDP-1
      workspace=14, monitor:eDP-1
      workspace=15, monitor:eDP-1
      workspace=16, monitor:eDP-1
      workspace=17, monitor:eDP-1
      workspace=18, monitor:eDP-1
      workspace=19, monitor:eDP-1
      workspace=20, monitor:eDP-1

      input {
          kb_layout = br
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = yes
        
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }



      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more


          # these rules only apply to alacritty (see window rules)
          inactive_opacity = 1
          active_opacity = 1

          rounding = 15

          blur {
            enabled = true
            size = 6
            passes = 3
            ignore_opacity = true
            new_optimizations = true
          }

          #inactive_opacity = 0
          drop_shadow = true
          shadow_range = 6
          shadow_render_power = 5
          shadow_ignore_window = true
          col.shadow = rgba(1a1a1aee)
          dim_inactive = false
          dim_strength = 0.1
      }

      #blurls=notifications

      animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsMove, 1, 7, default, popin 80%
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
      }

      misc {
          animate_manual_resizes = false
          enable_swallow = true
          swallow_regex = ^(Alacritty|kitty|org.wezfurlong.wezterm|com.raggesilver.BlackBox)$
      }

      Binds {
          workspace_back_and_forth = true
      }


      #windowrulev2 = opacity 0.9 ,class:^(Alacritty)$
      windowrulev2 = noblur, class:^(?!.*(Alacritty|kitty|org.wezfurlong.wezterm|com.raggesilver.BlackBox)).*$ 
      # windowrulev2 = opaque, class:^(?!.*(Alacritty|kitty)).*$
      windowrulev2 = float, class:^(.*(copyq|iwgtk|pavucontrol|MEGAsync)).*$
      windowrulev2 = tile, class:^(.*(Mars)).*$
      windowrulev2 = workspace 11, class:^(.*(Rocket.Chat)).*$
      windowrulev2 = workspace 12, class:^(.*(Spotify)).*$

      $mainMod = SUPER
      $scripts = "$HOME/repos/nixos-config/home/modules/hyprland/scripts"

      exec-once = $scripts/autostart.sh

      bind = $mainMod, V, exec, $scripts/launch_fuzzel.py clipboard
      bind = $mainMod, A, toggleopaque
      bind = $mainMod, Return, exec, blackbox
      bind = $mainMod, W, killactive, 
      bind = $mainMod_ALT, Q , exit, 
      bind = $mainMod, F , fullscreen, 0 
      bind = $mainMod,TAB  , fullscreen, 1 
      bind = $mainMod, Z, exec, google-chrome-stable
      bind = $mainMod, X, exec, code
      bind = $mainMod_SHIFT,SPACE , togglefloating, 
      bind = $mainMod,SPACE, exec, playerctl play-pause
      bind = $mainMod, R, exec, $scripts/launch_fuzzel.py app
      bind = $mainMod, Q, exec, eww open --toggle main_window
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, S, togglesplit, # dwindle
      bind = $mainMod, G, togglegroup
      bind = $mainMod, B, changegroupactive, f

      # Move focus with mainMod + arrow keys
      bind = $mainMod_ALT, h, workspace, e-1
      bind = $mainMod_ALT, l, workspace, e+1
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      # move window with mainMod + Shift + arrow keys
      bind = $mainMod_SHIFT, h, movewindow, l
      bind = $mainMod_SHIFT, l, movewindow, r
      bind = $mainMod_SHIFT, k, movewindow, u
      bind = $mainMod_SHIFT, j, movewindow, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 0, workspace, 10
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod_ALT, 0, workspace, 20 
      bind = $mainMod_ALT, 1, workspace, 11 
      bind = $mainMod_ALT, 2, workspace, 12 
      bind = $mainMod_ALT, 3, workspace, 13 
      bind = $mainMod_ALT, 4, workspace, 14 
      bind = $mainMod_ALT, 5, workspace, 15 
      bind = $mainMod_ALT, 6, workspace, 16 
      bind = $mainMod_ALT, 7, workspace, 17 
      bind = $mainMod_ALT, 8, workspace, 18 
      bind = $mainMod_ALT, 9, workspace, 19 


      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      bind = $mainMod_ALT_SHIFT, 1, movetoworkspacesilent, 11
      bind = $mainMod_ALT_SHIFT, 2, movetoworkspacesilent, 12
      bind = $mainMod_ALT_SHIFT, 3, movetoworkspacesilent, 13
      bind = $mainMod_ALT_SHIFT, 4, movetoworkspacesilent, 14
      bind = $mainMod_ALT_SHIFT, 5, movetoworkspacesilent, 15
      bind = $mainMod_ALT_SHIFT, 6, movetoworkspacesilent, 16
      bind = $mainMod_ALT_SHIFT, 7, movetoworkspacesilent, 17
      bind = $mainMod_ALT_SHIFT, 8, movetoworkspacesilent, 18
      bind = $mainMod_ALT_SHIFT, 9, movetoworkspacesilent, 19
      bind = $mainMod_ALT_SHIFT, 0, movetoworkspacesilent, 20

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

    '';
  };
}
