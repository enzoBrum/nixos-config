{ config, pkgs, pkgs-stable, ... }: {
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
        defaultSession = "gnome";

        # autoLogin = {
        #   enable = true;
        #   user = "erb";
        # };
      };
    };
  };

  nixpkgs = {
    overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope' (selfg: superg: {
          gnome-shell = superg.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [
              (
                let
                  bg = pkgs.fetchurl {
                    url =
                      "https://github.com/enzoBrum/nixos-config/raw/main/assets/wallpaper/blurred";
                    sha256 =
                      "sha256-U3nJ8AaAltSE3bIVYLwTm+vyV4Susg/5pl73lCTZbAk=";
                  };
                in
                pkgs.writeText "bg.patch" ''
                  --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                  +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                  @@ -15,4 +15,5 @@ $_gdm_dialog_width: 23em;
                   /* Login Dialog */
                   .login-dialog {
                     background-color: $_gdm_bg;
                  +  background-image: url('file://${bg}');
                   }
                ''
              )
            ];
          });
        });
      })
    ];
  };

  # see: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${
      pkgs.writeText "gdm-monitors.xml" ''
        <monitors version="2">
          <configuration>
            <logicalmonitor>
              <x>1920</x>
              <y>0</y>
              <scale>1</scale>
              <primary>yes</primary>
              <monitor>
                <monitorspec>
                  <connector>HDMI-1</connector>
                  <vendor>GSM</vendor>
                  <product>LG FULL HD</product>
                  <serial>305AZHY29025</serial>
                </monitorspec>
                <mode>
                  <width>1920</width>
                  <height>1080</height>
                  <rate>60.000</rate>
                </mode>
              </monitor>
            </logicalmonitor>
            <logicalmonitor>
              <x>0</x>
              <y>0</y>
              <scale>1</scale>
              <monitor>
                <monitorspec>
                  <connector>eDP-1</connector>
                  <vendor>BOE</vendor>
                  <product>0x0812</product>
                  <serial>0x00000000</serial>
                </monitorspec>
                <mode>
                  <width>1920</width>
                  <height>1080</height>
                  <rate>59.997</rate>
                </mode>
              </monitor>
            </logicalmonitor>
          </configuration>
        </monitors>
      ''
    }"
  ];
}
