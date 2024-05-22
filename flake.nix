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

    waybar.url = "github:Alexays/Waybar/0.10.3";

    coc-nvim = { url = "github:neoclide/coc.nvim"; flake = false; };
    coc-pyright = { url = "github:fannheyward/coc-pyright"; flake = false; };
    coc-clangd = { url = "github:clangd/coc-clangd"; flake = false; };
    coc-docker = { url = "github:josa42/coc-docker"; flake = false; };
    coc-java = { url = "github:neoclide/coc-java"; flake = false; };
    coc-sumneko-lua = { url = "github:xiyaowong/coc-sumneko-lua"; flake = false; };
    coc-yaml = { url = "github:neoclide/coc-yaml"; flake = false; };
    coc-json = { url = "github:neoclide/coc-json"; flake = false; };
    coc-tsserver = { url = "github:neoclide/coc-tsserver"; flake = false; };
    coc-prettier = { url = "github:neoclide/coc-prettier"; flake = false; };
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
      coc-extensions = (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        builtins.listToAttrs (
          map
            (
              name: {
                inherit name;
                value = builtins.getAttr name;
              }
            )
            (
              builtins.filter
                (
                  name: pkgs.lib.strings.hasPreffix "coc-" name
                )
                (
                  builtins.attrNames inputs
                )
            )
        )
      );
    in
    {
      nixosConfigurations = {
        enzoPC = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            inherit coc-extensions;
            pkgs-stable = pkgs-stable system;
          };

          modules = [
            ./host/default/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.erb = import ./home/home.nix;
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
