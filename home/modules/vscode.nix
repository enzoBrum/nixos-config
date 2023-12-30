{ config, pkgs, ... }:
let
  iekuatiara = pkgs.python311.withPackages (ps: with ps; [ flask cryptography pyhanko redis asn1crypto psycopg2 ]);
in
{
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
}
