{ pkgs }:

with pkgs;
[
  dockutil
  btop
  neovim
  nodejs
  zoxide
  git
  ripgrep
  lazygit
  gitui
  kitty
  tmux
  stow
  fzf

  yabai
  skhd

  # fish plugins
  fishPlugins.z
  fishPlugins.pisces
  fishPlugins.bobthefish
]
