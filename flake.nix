{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.awscli2
            pkgs.bash-language-server
            pkgs.bat
            pkgs.delta
            pkgs.difftastic
            pkgs.direnv
            pkgs.eza
            pkgs.fd
            pkgs.fzf
            pkgs.go
            pkgs.kubectl
            (pkgs.lima.override {
              withAdditionalGuestAgents = true;
            })
            pkgs.lua-language-server
            pkgs.marksman
            pkgs.neovim
            pkgs.nodejs_22
            pkgs.nil
            pkgs.nixfmt-rfc-style
            pkgs.pay-respects
            pkgs.ripgrep
            pkgs.stylua
            pkgs.tig
            pkgs.tmux
            pkgs.tree-sitter
            pkgs.uv
            pkgs.vscode-langservers-extracted
            pkgs.yaml-language-server
            pkgs.zoxide
            pkgs.zplug
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          security.pam.services.sudo_local.touchIdAuth = true;
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Oliviers-MacBook-Air
      darwinConfigurations."Oliviers-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
