{ config, lib, pkgs, ... }:
let
  p10kTheme = "/home/erb/repos/nixos-config/scripts/.p10k.zsh";
  aliases = {
    cat = "bat --theme Dracula --style=plain";
    update =
      "sudo nix-channel --update && nh os switch --update";
    rebuild =
      "nh os switch";
    ls = "eza --icons=always";
    screenshoot = ''grim -g "$(slurp -d)" - | swappy -f -'';
    rebuild-test =
      "sudo nixos-rebuild test --flake /home/erb/repos/nixos-config -I nixos-config=/home/erb/repos/nixos-config/configuration.nix -L";
  };
  flavour = "macchiato";
in
{
  programs.starship = {
    enable = true;
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

      aws.style = "bold #ffb86c";
      cmd_duration.style = "bold #f1fa8c";
      directory.style = "bold #50fa7b";
      hostname.style = "bold #ff5555";
      git_branch.style = "bold #ff79c6";
      git_status.style = "bold #ff5555";
      username = {
        format = "[$user]($style) on ";
        style_user = "bold #bd93f9";
      };
      character = {
        success_symbol = "[λ](bold #f8f8f2)";
        error_symbol = "[λ](bold #ff5555)";
      };
    };
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = aliases;

    sessionVariables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = 1;
      FZF_DEFAULT_OPTS = ''--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'';
    };

    initExtra =
      let
        grc-zsh = pkgs.fetchFromGitHub
          {
            owner = "garabik";
            repo = "grc";
            rev = "f4a579e08d356a3ea00a8c6fda7de84fff5f676a";
            sha256 = "sha256-bv+m+850edLSmo2/mlFUlYmcV8NJ5bxsa0jHyEl0Rp8=";
          } + /grc.zsh;
      in
      ''
        bindkey '^H' backward-kill-word
        bindkey '5~' kill-word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
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


  home.sessionVariables = {
    FZF_DEFAULT_OPTS = ''
      \
                   --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
                   --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
                   --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'';

    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    # ZELLIJ_AUTO_ATTACH = "true";
  };

  programs.fish = {
    enable = true;

    # to run zellij on start.
    # eval (zellij setup --generate-auto-start fish | string collect)
    interactiveShellInit = /* fish */ ''
      if status is-interactive
        set fish_greeting
        set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /usr/share /var/lib/flatpak/exports/share $HOME/.local/share/flatpak/exports/share
        fzf_configure_bindings --directory=\cf

        fastfetch
      end
    '';

    shellAliases = aliases;

    plugins = with pkgs.fishPlugins; [
      {
        name = "grc";
        src = grc.src;
      }
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
    ];
  };

}
