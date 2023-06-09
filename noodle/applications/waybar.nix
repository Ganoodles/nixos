{ config, pkgs, ... }:
let colors = import (../colors.nix);
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }); # This is so workspaces work, since its experimental

    settings = {
      secondaryMonitors = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "HDMI-A-1" ];

        modules-left = [ "wlr/workspaces" "hyprland/submap" ];
      };

      mainMonitor = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "DP-3" ];

        modules-left = [ "wlr/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right =
          [ "tray" "mpris" "custom/pw-levels" "custom/weather" "clock" ];

        "clock" = { format = "{:%A, %B %d   •   %I:%M %p}"; };
        
        "tray" = {
          spacing = 10;
        };

        "mpris" = {
          format = "{player_icon}  {artist} - {title}";
          format-paused = "{status_icon}  {artist} - {title}";
          player-icons = {
            default = "󰐊 ";
            mpv = "󰎄 ";
          };
          status-icons = { paused = "󰏤 "; };
        };

        "custom/pw-levels" = {
          exec = "sh ~/.nix/scripts/waybar/pw-levels.sh";
          on-scroll-down = "sh ~/.nix/scripts/waybar/pw-control.sh 5 down";
          on-scroll-up = "sh ~/.nix/scripts/waybar/pw-control.sh 5 up";
          on-click = "pavucontrol";
          tooltip = false;
          max-length = 10;
        };

        "custom/weather" = {
          exec = "python ~/.nix/scripts/waybar/weather.py";
          restart-interval = 300;
          return-type = "json";
        };

      };
    };

    style = ''
      window#waybar {
        background: alpha(#${colors.normal.black}, 0.95);
        color: #${colors.text}
      }
            
      * {
          border: none;
          border-radius: 0;
          font-family: Ubuntu, Helvetica, Arial, sans-serif;
          font-size: 13px;
          min-height: 0;
          transition: all 0.2s;
          font-weight: bold;
      }

      #mode, #clock, #battery, #mpris, #tray, #workspaces, #window, #custom-weather, #custom-pw-levels, #wireplumber {
          padding-right: 20px;
      }

      #workspaces button {
          padding: 0 7px;
          padding-top: 2px;
          background: transparent;
          color: white;
          border-bottom: 3px solid transparent;
      }

      #workspaces button.active {
          background: @base;
          border-bottom: 3px solid white;
      }

      tooltip {
        background: #${colors.crust};
        border-radius: 3px;
        border: 1px solid rgba(133, 133, 133, 0.5);
      }

    '';
  };
}
