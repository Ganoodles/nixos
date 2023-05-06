{ config, pkgs, lib, ... }:
let colors = import (../colors.nix);
in {
  home.packages = [ pkgs.libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 1;
        frame_color = "#${colors.text}";
        frame_width = 2;
        corner_radius = 3;
        icon_corner_radius = 3;
        padding = 16;
        horizontal_padding = 16;
        transparency = 10;
        width = 300;
        height = 200;
        offset = "50x50";
      };

      urgency_low = {
        background = "#${colors.mantle}";
        foreground = "#${colors.text}";
        timeout = 4;
      };

      urgency_normal = {
        background = "#${colors.mantle}";
        foreground = "#${colors.text}";
        timeout = 4;
      };
      urgency_high = {
        background = "#a33737";
        foreground = "#${colors.text}";
        timeout = 10;
      };
    };
  };
}
