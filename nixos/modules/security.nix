{ config, pkgs, ... }: {
  # imports = [ sops-nix.nixosModules.sops ];

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units" &&
            action.lookup("unit") == "openvpn-labsec.service" &&
            subject.user == "erb") {
                return polkit.Result.YES;
        }
    });
  '';
  
  security.sudo.extraRules = [
    {
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl start openvpn-labsec";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/systemctl stop openvpn-labsec";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }
  ];
  users.users.erb.extraGroups = [ "tss" ];

  environment.systemPackages = with pkgs; [ gnome-secrets openssl sops ];

  sops.age.keyFile = "/etc/age-keys.txt";
  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.vpn_credentials = {
    sopsFile = ../../secrets.yaml;
    mode = "0040";
    owner = config.users.users.erb.name;
    group = config.users.users.erb.group;
  };

  sops.secrets.vpn_config = {
    sopsFile = ../../secrets.yaml;
    mode = "0040";
    owner = config.users.users.erb.name;
    group = config.users.users.erb.group;
  };
}
