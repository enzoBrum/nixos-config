{ config, pkgs, pkgs-stable, ... }: {
  services.displayManager.defaultSession = "hyprland";
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;

        # autoLogin = {
        #   enable = true;
        #   user = "erb";
        # };
      };
    };
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
