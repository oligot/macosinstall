{ pkgs, ... }:
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  home.packages = [
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
    pkgs.jira-cli-go
    pkgs.k9s
    pkgs.kanata
    pkgs.kube-capacity
    pkgs.kubecm
    pkgs.kubectx
    pkgs.kubectl
    pkgs.kubernetes-helm
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
    pkgs.opentofu
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
    pkgs.sd
    pkgs.snitch
    pkgs.stylua
    pkgs.taplo
    pkgs.terraform
    pkgs.tig
    pkgs.tldr
    pkgs.tmux
    pkgs.tokei
    pkgs.tree-sitter
    pkgs.uv
    pkgs.vscode-langservers-extracted
    pkgs.watch
    pkgs.yamlfmt
    pkgs.yaml-language-server
    pkgs.yq-go
    pkgs.zoxide
    pkgs.zplug

    (pkgs.writeShellScriptBin "docker" ''
      exec ${pkgs.podman}/bin/podman "$@"
    '')
  ];
}
