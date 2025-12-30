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
            pkgs.aerospace
            pkgs.argocd
            pkgs.aspell
            pkgs.aspellDicts.fr
            pkgs.awscli2
            pkgs.bash-language-server
            pkgs.bat
            pkgs.delta
            pkgs.devpod
            pkgs.difftastic
            pkgs.direnv
            # pkgs.docker
            pkgs.eza
            pkgs.fd
            pkgs.fzf
            pkgs.gh
            pkgs.git
            pkgs.git-extras
            pkgs.glab
            pkgs.go
            pkgs.helm-ls
            pkgs.himalaya
            pkgs.hl-log-viewer
            pkgs.k9s
            pkgs.kanata
            pkgs.kube-capacity
            pkgs.kubecm
            pkgs.kubectx
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.librewolf
            (pkgs.lima.override {
              withAdditionalGuestAgents = true;
            })
            pkgs.kustomize
            pkgs.lua-language-server
            pkgs.marksman
            pkgs.neovim
            pkgs.nil
            pkgs.nixfmt-rfc-style
            pkgs.nova
            pkgs.ov
            pkgs.overmind
            pkgs.pay-respects
            pkgs.podman
            pkgs.podman-compose
            pkgs.postgresql
            pkgs.prettier
            pkgs.python313Packages.cfn-lint
            pkgs.ranger
            pkgs.ripgrep
            pkgs.saml2aws
            pkgs.stylua
            pkgs.taplo
            pkgs.tig
            pkgs.tldr
            pkgs.tmux
            pkgs.tokei
            pkgs.tree-sitter
            # pkgs.uv
            pkgs.vscode-langservers-extracted
            pkgs.yamlfmt
            pkgs.yaml-language-server
            pkgs.yq-go
            pkgs.zoxide
            pkgs.zplug

            (pkgs.writeShellScriptBin "docker" ''
              exec ${pkgs.podman}/bin/podman "$@"
            '')
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
          security.pam.services.sudo_local.reattach = true;

          # Turn off nix-darwin’s management of the Nix installation
          nix.enable = false;
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
