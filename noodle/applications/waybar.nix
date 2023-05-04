{ config, pkgs, ... }: 
let
  colors = import (../colors.nix);
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }); # I forgot what this was for but it wont work unless its enabled
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

      #mode, #clock, #battery, #mpris, #tray, #workspaces, #window, #custom-weather, #wireplumber {
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
