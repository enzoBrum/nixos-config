{ config, pkgs, ... }:
let
  iekuatiara = pkgs.python311.withPackages (ps: with ps; [ flask cryptography pyhanko redis asn1crypto psycopg2 ]);
  p10kTheme = "./scripts/.p10k.zsh";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "erb";
  home.homeDirectory = "/home/erb";

  # Packages that should be installed to the user profile.


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  #home.stateVersion = "23.05";
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Enzo Brum";
    userEmail = "darosabrumenzo@gmail.com";
  };

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


  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    shellAliases = {
      ll = "ls -l";
      cat = "bat --style=plain";
      update =
        "sudo nix-channel --update && sudo nixos-rebuild switch && home-manager switch";
    };

    sessionVariables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = 1;
    };

    initExtra = ''
      [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
      fastfetch
    '';

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "marlonrichert/zsh-autocomplete"; }
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

  };

  programs.fish = {
    enable = true;
    interactiveShellInit =
      "	set fish_greeting # Disable greeting\n	fastfetch\n      ";

    shellAliases = {
      cat = "bat --style=plain";
      update = "sudo nix-channel --update && cd /home/erb/repos/nixos-config && nix flake update && cd - && rebuild";
      rebuild = "sudo nixos-rebuild switch --flake /home/erb/repos/nixos-config -I nixos-config=/home/erb/repos/nixos-config/configuration.nix";
    };

    plugins = with pkgs.fishPlugins; [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = grc.src;
      }

      # Manually packaging and enable a plugin
      {
        name = "z";
        src = z.src;
      }

      {
        name = "tide";
        src = tide.src;
      }

      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }

      {
        name = "forgit";
        src = forgit.src;
      }

      {
        name = "done";
        src = done.src;
      }

    ];
  };

  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
  };

  services.mpris-proxy.enable = true;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
