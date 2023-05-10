{ config, pkgs, lib, nix-gaming, ... }:
let 
  colors = import (./colors.nix);
in {
  # app imports
  imports = [
    ./applications/waybar.nix
    ./applications/hyprland/hyprland.nix

    ./applications/neovim.nix

    ./services/dunst.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noodle";
  home.homeDirectory = "/home/noodle";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Stuff in the path
  home.sessionPath = [ "$HOME/.local/bin" ];

  # Allows unfree programs
  nixpkgs.config.allowUnfree = true;

  # packages
  home.packages = with pkgs; [
    
    #flakes
    nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable

    # cli tools
    alacritty
    zsh
    zplug
    starship

    neofetch

    killall
    inotify-tools
    tree
    lazygit

    #wine
    wineWowPackages.stable
    winetricks

    # this is for dependencies, not for dev work, use nix-shell
    python310Full
    python310Packages.pip
    nodejs
    gnumake
    cargo
    gcc # build tools
    nixfmt

    # core system apps
    firefox
    gnome.gnome-clocks

    # other system apps
    librewolf
    libreoffice
    webcord
		mousai
    spotify
    spot
    tidal-hifi
    motrix
    bitwarden
    gimp
    krita
    steam
    gnome.gnome-font-viewer

    kdenlive
    glaxnimate
    mlt
    mediainfo

    # funny
    cava

    # system utils
    vscode
    kate
    cinnamon.nemo
    gnome.eog
    celluloid

    # customization
    gradience
    adw-gtk3
    catppuccin-gtk
    catppuccin-cursors
    gnome.gnome-themes-extra

    # audio
    pavucontrol
    easyeffects
    wireplumber
    playerctl
    wireplumber
    mpdris2

    # desktop stuff
    xdg-desktop-portal-hyprland # xdg for hyprland
    rofi-wayland # files
    bemenu
    swww # animated wallpaper daemon
    hyprpicker # color picker
    grim
    slurp # screenshot utility
    dunst # notification daemon
    libnotify # pushes notifications to dunst
    udiskie # auto mounts stuff
    clipman
    wl-clipboard # clipboard manager
  ];

  # git is being stupid and gh wont work for authentication
  #	programs.git.enable = true;
  #	programs.git.extraConfig = {
  #		core = {
  #			sshCommand = "-i ~/.ssh/id_ed25519";
  #		};
  #	};

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-gstreamer
      obs-vaapi
      input-overlay
      wlrobs
    ];
  };

  programs.kitty = {
    enable = true;
    extraConfig = ''
      background #${colors.base}
      foreground #${colors.text}

      confirm_os_window_close 0
      window_padding_width 15
      background_opacity 0.95

      foreground            #${colors.text}
      cursor                #${colors.cursor}
      selection_background  #${colors.selection}

      color0                #${colors.normal.black}
      color1                #${colors.normal.red}
      color2                #${colors.normal.green}
      color3                #${colors.normal.yellow}
      color4                #${colors.normal.blue}
      color5                #${colors.normal.magenta}
      color6                #${colors.normal.cyan}
      color7                #${colors.normal.white}

      color8                #${colors.bright.black}
      color9                #${colors.bright.red}
      color10               #${colors.bright.green}
      color11               #${colors.bright.yellow}
      color12               #${colors.bright.blue}
      color13               #${colors.bright.magenta}
      color14               #${colors.bright.cyan}
      color15               #${colors.bright.white}


      selection_foreground #000000
    '';
  };


	programs.zsh = {
    enable = true;

		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
		
		autocd = true;

		initExtra = "neofetch";

		dirHashes = {
			nix = "$HOME/.nix";
			dl = "$HOME/Downloads";
			dc = "$HOME/Documents";
			code = "$HOME/code";
		};

    shellAliases = {
      nix-shell-dev = "nix-shell ~/.nix/shells/dev.nix";
 
      an-apply =
        "sudo nixos-rebuild switch --flake ~/.nix --install-bootloader";
      an-update-system = "sudo nix flake update";
      an-update-user = "sudo nix-channel --update";
      an-clean-garbage = "sudo nix-collect-garbage -d";
      ll = "ls -l";
    };

    oh-my-zsh = {
			custom = "$HOME/.nix/dotfiles/zsh/";
      enable = true;
      plugins = [ "git" "thefuck" "copyfile" "copybuffer" "dirhistory" "sudo" "history" ];
      theme = "oxide";
    };
  };

}
