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
  lazygit
  gitui

  kitty

  stow
  fzf
  fish
  wakatime

  yabai
  skhd

  syncthing

  mkcert
  ddev

  platformsh
  neofetch
]
