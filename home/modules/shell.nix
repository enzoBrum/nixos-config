{ config, lib, pkgs, ... }:
let
  p10kTheme = "/home/erb/repos/nixos-config/scripts/.p10k.zsh";
in
{
  programs.starship = {
    enable = false;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$docker_context"
        # "$package"
        # "$c"
        # "$cmake"
        # "$golang"
        # "$java"
        # "$nodejs"
        # "$python"
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
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      cat = "bat --style=plain";
      update = "sudo nix-channel --update && cd /home/erb/repos/nixos-config && nix flake update && cd - && rebuild";
      rebuild = "sudo nixos-rebuild switch --flake /home/erb/repos/nixos-config -I nixos-config=/home/erb/repos/nixos-config/configuration.nix -L";
      ls = "eza --icons=always";
    };

    sessionVariables = {
      EDITOR = "hx";
      NIXOS_OZONE_WL = 1;
    };

    initExtra = ''
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
    ];

    # zplug = {
    #   enable = true;
    #   plugins = [
    #     { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
    #     {
    #       name = "romkatv/powerlevel10k";
    #       tags = [ "as:theme" "depth:1" ];
    #     } # Installations with additional options. For the list of options, please refer to Zplug README.
    #     { name = "zsh-users/zsh-syntax-highlighting"; }
    #     { name = "marlonrichert/zsh-autocomplete"; }
    #   ];
    # };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /usr/share /var/lib/flatpak/exports/share $HOME/.local/share/flatpak/exports/share
      fastfetch
    '';

    shellAliases = {
      cat = "bat --style=plain";
      update = "sudo nix-channel --update && cd /home/erb/repos/nixos-config && nix flake update && cd - && rebuild";
      rebuild = "sudo nixos-rebuild switch --flake /home/erb/repos/nixos-config -I nixos-config=/home/erb/repos/nixos-config/configuration.nix -L";
      ls = "eza --icons=always";
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


}
