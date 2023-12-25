{ config, pkgs, ... }:
let
  iekuatiara = pkgs.python311.withPackages (ps: with ps; [ flask cryptography pyhanko redis asn1crypto psycopg2 ]);
  p10kTheme = "./scripts/.p10k.zsh";
in
{
  imports = [ ./modules.nix ];

  home.username = "erb";
  home.homeDirectory = "/home/erb";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
        iekuatiara
        gcc
        clang
        clang-tools
        neovim
        git
        ghc
        fish
        bash
        zlib
        openssl.dev
        pkg-config
        grc
        fzf
        gnumake
        gdb
        jdk21
        maven
        nixd
        nixpkgs-fmt
        nil
      ]);
  };

  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
  };

  # bluetooth-related settings
  services.mpris-proxy.enable = true;

  # virtualisation-related settings.
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
