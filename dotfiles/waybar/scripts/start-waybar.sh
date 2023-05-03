#!/bin/bash

style_path="$HOME/.nix/dotfiles/waybar/style.css"
config_path="$HOME/.nix/dotfiles/waybar/config"

# Start waybar if it's not running
if ! pgrep -x "waybar" > /dev/null; then
  waybar &
fi

# Monitor the style.css and config files for changes
while true; do
  inotifywait -q -e modify $style_path $config_path
  # Kill and restart waybar if either file has changed
  pkill waybar
  waybar &
done

