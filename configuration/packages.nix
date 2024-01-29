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
  tmux
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
  fastfetch
]
