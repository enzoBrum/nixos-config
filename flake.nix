{
  description = "NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ags = {
    #   url = "github:Aylur/ags/v1.8.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.2";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dracula-alacritty = {
      url = "github:dracula/alacritty";
      flake = false;
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { nixpkgs
    , nixpkgs-stable
    , nixpkgs-small
    , home-manager
    , lanzaboote
    , sops-nix
    , nix-vscode-extensions
    , ...
    }@inputs:
    let
      pkgs-stable = system: import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-small = system: import nixpkgs-small { inherit system; config.allowUnfree = true; };
      vscode-extensions = system: nix-vscode-extensions.extensions.${system};
    in
    {
      nixosConfigurations = {
        enzoPC = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            pkgs-stable = pkgs-stable system;
            pkgs-small = pkgs-small system;
          };

          modules = [
            ./host/notebook/configuration.nix
            inputs.nixos-cosmic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.erb = import ./home/notebook/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                pkgs-small = pkgs-small system;
                pkgs-stable = pkgs-stable system;
                vscode-extensions = vscode-extensions system;
              };
            }
            lanzaboote.nixosModules.lanzaboote
            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
