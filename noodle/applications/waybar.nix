{ config, pkgs, ... }: 
let
  colors = import (../colors.nix);
  settings =  builtins.fromJSON ("{ mainBar = " + builtins.readFile ./settings.json + "}" ); 
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }); # I forgot what this was for but it wont work unless its enabled

    settings = {
      secondaryMonitors = {
        layer = "top";
        position = "top";
        height = 30;
        output = ["HDMI-A-1"];

        modules-left = ["wlr/workspaces" "hyprland/submap"];
      };

      mainMonitor = {
        layer = "top";
        position = "top";
        height = 30;
        output = ["DP-3"];

        modules-left = ["wlr/workspaces" "hyprland/submap"];
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "mpris" "custom/pw-levels" "custom/weather" "clock"];

        "wlr/workspaces" = {
          format = "{name}";
          separate-outputs = true;
        };

        "clock" = {
          format = "{:%A, %B %d   •   %I:%M %p}";
        };

        "mpris" = {
          format = "{player_icon} {artist} - {title}";
          format-paused = "{status_icon} {artist} - {title}";
          player-icons = {
            default = "▶️";
            mpv = "🎸";
          };
          status-icons = {
            paused = "⏸️";
          };
        };

        "wireplumber" = {
          format = "🎸 {volume}%";
          on-scroll-down = "sh ~/.nix/scripts/waybar/pw-control.sh 5 down";
          on-scroll-up = "sh ~/.nix/scripts/waybar/pw-control.sh 5 up";
          format-muted = "🔇";
          on-click = "pavucontrol";
        };

        "custom/pw-levels" = {
          exec = "sh ~/.nix/scripts/waybar/pw-levels.sh";
          on-scroll-down = "sh ~/.nix/scripts/waybar/pw-control.sh 5 down";
          on-scroll-up = "sh ~/.nix/scripts/waybar/pw-control.sh 5 up";
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
        background: alpha(#${colors.crust}, 0.9);
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

      #tray menu {
        padding: 10px;
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
