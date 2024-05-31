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

    # Completelly broken LOL
    # vim-ext-coc-nvim = { url = "github:neoclide/coc.nvim/release"; flake = false; };
    # vim-ext-coc-pyright = { url = "github:fannheyward/coc-pyright"; flake = false; };
    # vim-ext-coc-basedpyright = { url = "github:fannheyward/coc-basedpyright"; flake = false; };
    # vim-ext-coc-clangd = { url = "github:clangd/coc-clangd"; flake = false; };
    # vim-ext-coc-docker = { url = "github:josa42/coc-docker"; flake = false; };
    # vim-ext-coc-java = { url = "github:neoclide/coc-java"; flake = false; };
    # vim-ext-coc-sumneko-lua = { url = "github:xiyaowong/coc-sumneko-lua"; flake = false; };
    # vim-ext-coc-yaml = { url = "github:neoclide/coc-yaml"; flake = false; };
    # vim-ext-coc-json = { url = "github:neoclide/coc-json"; flake = false; };
    # vim-ext-coc-tsserver = { url = "github:neoclide/coc-tsserver"; flake = false; };
    # vim-ext-coc-prettier = { url = "github:neoclide/coc-prettier"; flake = false; };
    # vim-ext-flash-nvim = { url = "github:folke/flash.nvim"; flake = false; };
    # vim-ext-nvim-autopairs = { url = "github:windwp/nvim-autopairs"; flake = false; };
    # vim-ext-catppuccin-nvim = { url = "github:catppuccin/nvim"; flake = false; };
    # vim-ext-comment-nvim = { url = "github:numToStr/Comment.nvim"; flake = false; };
    # vim-ext-vim-fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
    # vim-ext-vim-rhubarb = { url = "github:tpope/vim-rhubarb"; flake = false; };
    # vim-ext-gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    # vim-ext-indent-blankline-nvim = { url = "github:lukas-reineke/indent-blankline.nvim"; flake = false; };
    # vim-ext-lualine-nvim = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
    # vim-ext-nvim-surround = { url = "github:kylechui/nvim-surround"; flake = false; };
    # vim-ext-nvim-tree-lua = { url = "github:kylechui/nvim-surround"; flake = false; };
    # vim-ext-ReplaceWithRegister = { url = "github:vim-scripts/ReplaceWithRegister"; flake = false; };
    # vim-ext-telescope-fzf-native-nvim = { url = "github:nvim-telescope/telescope-fzf-native.nvim"; flake = false; };
    # vim-ext-plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    # vim-ext-nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    # vim-ext-nvim-treesitter-textobjects = { url = "github:nvim-treesitter/nvim-treesitter-textobjects"; flake = false; };
    # vim-ext-undotree = { url = "github:mbbill/undotree"; flake = false; };
    # vim-ext-vim-sleuth = { url = "github:tpope/vim-sleuth"; flake = false; };
    # vim-ext-which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };
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
                name = pkgs.lib.strings.removePrefix "vim-ext-" name;
                value = builtins.getAttr name inputs;
              }
            )
            (
              builtins.filter
                (
                  name: (pkgs.lib.strings.hasPrefix "vim-ext-" name)
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
            coc-extensions = coc-extensions system;
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
