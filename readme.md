# macosinstall

>  Install scripts to setup my development environment on MacOS

## Terminal

[Download and install Ghostty](https://ghostty.org/download)

## Nix

### Install

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
sudo nix run nix-darwin -- switch --flake .
```

### Update

```bash
nix flake update --commit-lock-file
make install
```

## Tools

### Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## dotfiles

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply oligot
```
