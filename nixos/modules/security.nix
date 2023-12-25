{ config, pkgs, ... }: {
  # imports = [ sops-nix.nixosModules.sops ];

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;
  users.users.erb.extraGroups = [ "tss" ];

  environment.systemPackages = with pkgs; [ gnome-secrets openssl sops ];

  sops.age.keyFile = "/home/erb/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.vpn_credentials = {
    sopsFile = ../../secrets.yaml;
    mode = "004";
    owner = config.users.users.erb.name;
    group = config.users.users.erb.group;
  };

  sops.secrets.vpn_config = {
    sopsFile = ../../secrets.yaml;
    mode = "004";
    owner = config.users.users.erb.name;
    group = config.users.users.erb.group;
  };
}
