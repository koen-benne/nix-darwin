{ pkgs }:

with pkgs;
[
  dockutil
  btop
  neovim
  nodejs
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

  gnupg
  (pass.withExtensions (extensions: with extensions; [ pass-otp ]))
  browserpass
]
