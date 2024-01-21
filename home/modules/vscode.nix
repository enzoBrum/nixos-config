{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
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
        rustc
        cargo
        rust-analyzer
      ]);
  };
}
