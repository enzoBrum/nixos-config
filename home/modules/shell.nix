{ config, lib, pkgs, ... }:
let
  p10kTheme = "/home/erb/repos/nixos-config/scripts/.p10k.zsh";
  aliases = {
    cat = "bat --theme catppuccin-macchiato --style=plain";
    update =
      "sudo nix-channel --update && cd /home/erb/repos/nixos-config && nix flake update && cd - && rebuild";
    rebuild =
      "sudo nixos-rebuild switch --flake /home/erb/repos/nixos-config -I nixos-config=/home/erb/repos/nixos-config/configuration.nix -L";
    ls = "eza --icons=always";
    screenshoot = ''grim -g "$(slurp -d)" - | swappy -f -'';
    rebuild-test =
      "sudo nixos-rebuild test --flake /home/erb/repos/nixos-config -I nixos-config=/home/erb/repos/nixos-config/configuration.nix -L";
  };
  flavour = "macchiato";
in {
  programs.starship = {
    enable = false;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "$username"
        "$hostname"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$docker_context"
        # "$package"
        "$c"
        # "$cmake"
        # "$golang"
        "$java"
        # "$nodejs"
        "$python"
        # "$rust"
        "$nix_shell"
        # "$conda"
        # "$meson"
        "$direnv"
        "$custom"
        "$sudo"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$time"
        "$status"
        "$os"
        "$container"
        "$shell"
        "$character"
      ];

      palette = "catppuccin_${flavour}";
    } // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    } + /palettes/${flavour}.toml));
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = aliases;

    sessionVariables = {
      EDITOR = "hx";
      NIXOS_OZONE_WL = 1;
      FZF_DEFAULT_OPTS='' \
              --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
              --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
              --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'';
    };

    initExtra = 
    let
      grc-zsh = pkgs.fetchFromGitHub {
        owner = "garabik";
        repo = "grc";
        rev = "f4a579e08d356a3ea00a8c6fda7de84fff5f676a";
        sha256 = "sha256-bv+m+850edLSmo2/mlFUlYmcV8NJ5bxsa0jHyEl0Rp8=";
      } + /grc.zsh;
    in
    ''
      source ${grc-zsh}
      setopt NO_CASE_GLOB
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' 
      source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      source "${pkgs.fzf}/share/fzf/completion.zsh"
      setopt AUTO_CD
      [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
      fastfetch
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-z";
        src = pkgs.zsh-z;
        file = "share/zsh-z/zsh-z.plugin.zsh";
      }
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /usr/share /var/lib/flatpak/exports/share $HOME/.local/share/flatpak/exports/share
      fastfetch
    '';

    shellAliases = aliases;

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

}
