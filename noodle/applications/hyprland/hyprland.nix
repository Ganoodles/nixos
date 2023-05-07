{ config, pkgs, lib, ... }:
let colors = import (../../colors.nix);

in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    extraConfig = ''
      # notification daemon, script accepts background as first value, text color as second
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = 0xff${colors.border},
          col.inactive_border = 0xff${colors.crust},

          layout = dwindle
      }

    '' + builtins.readFile ./hyprland.bash;
  };
}
