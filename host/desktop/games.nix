{config, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.wayland
  ];
}
