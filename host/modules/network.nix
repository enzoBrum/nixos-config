{
  config,
  pkgs,
  pkgs-stable,
  ...
}:
{
  networking.hostName = config.custom.hostName;
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = [  pkgs.networkmanager-strongswan];
  services.strongswan.enable = true;
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    socat
    ifuse
    networkmanager-openvpn
  ];
  programs.openvpn3.enable = true;
  networking.firewall = {
    allowedTCPPorts = [
      80
      3000
      8080
      8000
    ];
  };
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
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "erb" ];
      UseDns = true;
      PermitRootLogin = "prohibit-password";
    };
    openFirewall = true;
  };

  networking.hosts = {
    "127.0.0.1" = [
      "keycloak"
      "keycloak-carc"
      "keycloak-assinador"
      "satosa"
      "localhost"
      "keycloak-ades"
    ];
  };
  #networking.nameservers = [ "127.0.0.1" "::1" "1.1.1.1" "8.8.8.8" ];
  services.dnsmasq.enable = false;
  services.resolved.enable = true;
  services.avahi.enable = true;
}
