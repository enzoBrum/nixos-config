{ config, pkgs, ... }:
let
  p10kTheme = "./scripts/.p10k.zsh";
in
{
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
    interactiveShellInit = ''
      set fish_greeting
      set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /usr/share /var/lib/flatpak/exports/share $HOME/.local/share/flatpak/exports/share
      fastfetch
    '';

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


}
