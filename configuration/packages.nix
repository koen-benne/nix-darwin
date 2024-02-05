{ pkgs }:

with pkgs;
[
  gnupg
  browserpass
  zbar

  dockutil
  btop
  neovim

  nodejs
  nodePackages.pnpm
  nodePackages.yarn

  git
  ripgrep
  fd
  gitui

  stow
  fzf
  wakatime

  mkcert
  ddev

  platformsh
  neofetch
]
