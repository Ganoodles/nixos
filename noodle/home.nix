{ config, pkgs, lib, ... }:
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

    # dev stuff
    python3Full
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
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      an-apply =
        "sudo nixos-rebuild switch --flake ~/.nix --install-bootloader";
      an-update-system = "sudo nix flake update";
      an-update-user = "sudo nix-channel --update";
      an-clean-garbage = "sudo nix-collect-garbage -d";
      ll = "ls -l";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "copyfile" "copybuffer" "dirhistory" "sudo" "history" ];
      theme = "fishy";
    };
 
    plugins = [
    {
      name = "zsh-syntax-highlighting";
      file = "zsh-syntax-highlighting.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "754cefe0181a7acd42fdcb357a67d0217291ac47";
        sha256 = "kWgPe7QJljERzcv4bYbHteNJIxCehaTu4xU9r64gUM4=";
      };
    }
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "zsh-autosuggestions";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "584bcbac7aca914e32cd67bf20ba0f3f38f44d17";
        sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
      };
    }
    ];
  };

}
