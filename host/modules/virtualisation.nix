{ config, pkgs, pkgs-stable, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    dns = [ "8.8.8.8" "1.1.1.1" ];
  };
  virtualisation.docker.storageDriver = "btrfs";
  virtualisation.podman.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [ virt-manager distrobox ];

  users.users.erb.extraGroups = [ "libvirtd" "docker" ];
}
