{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macos
      darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules = [
          ./darwin.nix
          ./modules/homebrew-common.nix
          ./modules/homebrew-work.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            users.users.oli = {
              name = "oli";
              home = "/Users/oli";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.oli = import ./home.nix;
          }
        ];
      };

      darwinConfigurations."personal" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules = [
          ./darwin.nix
          ./modules/homebrew-common.nix
          ./modules/homebrew-personal.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            users.users.oli = {
              name = "oli";
              home = "/Users/oli";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.oli = import ./home.nix;
          }
        ];
      };
    };
}
