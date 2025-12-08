{
  inputs,
  config,
  lib,
  pkgs,
  pkgs-small,
  ...
}:
{
  xdg.configFile."kitty/diff.conf".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/kitty/diff.conf;
  xdg.configFile."kitty/dracula.conf".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/kitty/dracula.conf;
  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink /home/erb/repos/nixos-config/home/modules/kitty/kitty.conf;

}
