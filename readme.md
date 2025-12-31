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

### Zplug

```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

## dotfiles

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply oligot
```
