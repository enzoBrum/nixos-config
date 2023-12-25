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
      fastfetch

      set monitor_count (hyprctl monitors -j | jq length)
      if test $monitor_count -eq 2; and test "$USING_TWO_MONITORS" != "true"
        set -Ux USING_TWO_MONITORS true
        echo "Using two monitors..."
        set workspaces
        for num in (seq 1 10)
          set -a workspaces "keyword workspace $num, monitor:HDMI-A-1;"
        end
        hyprctl --batch "$workspaces"
      end
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
