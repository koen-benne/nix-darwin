{ pkgs, lib, inputs, config, ... }:

{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # Switch focus
      alt - k : yabai -m window --focus prev
      alt - j : yabai -m window --focus next
      # Resize window
      # alt - h : yabai -m window west --resize right:-300:0 2> /dev/null || yabai -m window --resize right:-300:0
      # alt - l : yabai -m window east --resize left:300:0 2> /dev/null || yabai -m window --resize left:300:0
      # shift window in current workspace
      alt + shift - h : yabai -m window --swap west
      alt + shift - j : yabai -m window --swap south
      alt + shift - k : yabai -m window --swap north
      alt + shift - l : yabai -m window --swap east
      # set insertion point in focused container
      alt + ctrl - h : yabai -m window --insert west
      alt + ctrl - j : yabai -m window --insert south
      alt + ctrl - k : yabai -m window --insert north
      alt + ctrl - l : yabai -m window --insert east
      # move focused window to next/prev workspace
      alt + shift - 1 : yabai -m window --space 1
      alt + shift - 2 : yabai -m window --space 2
      alt + shift - 3 : yabai -m window --space 3
      alt + shift - 4 : yabai -m window --space 4
      alt + shift - 5 : yabai -m window --space 5
      alt + shift - 6 : yabai -m window --space 6
      alt + shift - 7 : yabai -m window --space 7
      alt + shift - 8 : yabai -m window --space 8
      alt + shift - 9 : yabai -m window --space 9
      # shift monitor focus
      ctrl + alt - n : yabai -m display --focus next
      ctrl + alt - p : yabai -m display --focus prev
      # switch spaces
      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5
      alt - 6 : yabai -m space --focus 6
      alt - 7 : yabai -m space --focus 7
      alt - 8 : yabai -m space --focus 8
      alt - 9 : yabai -m space --focus 9
      # open terminal
      # alt -return : ~/.scripts/launch-iterm
      alt - return : ~/.scripts/launch-kitty
      alt - p : ~/.scripts/kittypass
      # open browser
      alt - w : sudo -u koenbenne /Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser
      # close current window
      alt - q : yabai -m window --close
      # enter fullscreen mode for the focused container
      alt - f : yabai -m window --toggle zoom-fullscreen
      # toggle window native fullscreen
      alt + shift - f : yabai -m window --toggle native-fullscreen
      # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
      shift + cmd - n : yabai -m space --create && \
                        index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')" && \
                        yabai -m window --space "$\{index}" && \
                        yabai -m space --focus "$\{index}"

      alt - space : ~/.scripts/popup.sh ~/.scripts/launcher.sh
    '';
  };
}
