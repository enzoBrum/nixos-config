{ config, pkgs, ... }: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" "https://nix-community.cachix.org" "https://cosmic.cachix.org/"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };

    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 7d";

    extraOptions = ''
      !include ${config.sops.secrets.github_access_token.path}
    '';
  };
  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE="1";
  };
  programs.nix-ld.enable = true;
}
