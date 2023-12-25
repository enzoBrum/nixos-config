{ config, pkgs, pkgs-stable, ... }:
let
  vpn_password = builtins.readFile config.sops.secrets.vpn_password.path;
in
{
  networking.hostName = "enzoPC";
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [ networkmanagerapplet socat ];
  users.users.erb.extraGroups = [ "networkmanager" ];
  services.openvpn.servers = {
    labsec = {
      config = ''
        config ${config.sops.secrets.vpn_config.path}
        auth-user-pass ${config.sops.secrets.vpn_credentials.path}
      '';
      autoStart = false;
      up = ''
        echo -n "vpn-up" | ${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/color_server.sock
      '';

      down = ''
        echo -n "vpn-down" | ${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/color_server.sock
      '';
    };
  };

  networking.hosts = { "127.0.0.1" = [ "keycloak" "keycloak-carc" "keycloak-assinador" "satosa.assina.dev" ]; };
  networking.nameservers = [ "127.0.0.1" "::1" "1.1.1.1" "8.8.8.8" ];
  networking.networkmanager.dns = "dnsmasq";
  services.dnsmasq.enable = true;
  services.avahi.enable = true;
}
