{
  description = "NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
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

    hyprland.url = "github:hyprwm/Hyprland/v0.40.0";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-stable
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
      vscode-extensions = system: nix-vscode-extensions.extensions.${system};
    in
    {
      nixosConfigurations = {
        enzoPC = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            pkgs-stable = pkgs-stable system;
          };

          modules = [
            ./host/default/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.erb = import ./home/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit inputs;
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
