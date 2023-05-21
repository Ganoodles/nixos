{ config, pkgs, lib, nix-gaming, ... }:
let 
  colors = import (./colors.nix);
in {
  # app imports
  imports = [
    ./applications/waybar.nix
    ./applications/hyprland/hyprland.nix

    ./applications/neovim/neovim.nix

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
    
    # rice/desktop
    xdg-desktop-portal-hyprland 
    rofi-wayland swww # wall
    grim slurp # screenshots
    dunst libnotify # notifs
    clipman wl-clipboard
    hyprpicker # utilities
    gradience adw-gtk3 # customization

    # gui supported
    firefox librewolf mullvad-browser
    onlyoffice-bin
    pavucontrol easyeffects # audio
    mousai motrix # small gtk
    spotify tidal-hifi amberol # moosic
    gnome.gnome-disk-utility gnome.gnome-clocks gnome.gnome-font-viewer gnome.gnome-system-monitor
    gnome.nautilus gnome.totem gnome.file-roller gnome.adwaita-icon-theme # files
    gimp krita gnome.eog # imgs
    kdenlive celluloid # vids
    vscode kate # text
    webcord element-desktop # social
    steam
    libreoffice
    mullvad-vpn qbittorrent
    kitty
    bitwarden
    popsicle
    remmina
    ungoogled-chromium
    filezilla

    # nextcloud
    iotas

    # cli utilities
    udiskie
    killall
    tree
    gnupg
    appimage-run
    glib
    
    # cli apps
    zsh
    neofetch
    pfetch
    lazygit
    cava
    ffmpeg # also is a dependency
    
    # gaming
    lutris
    ryujinx cemu # emu
    wineWowPackages.stable winetricks
    nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable # comment out if building flake for the first time

    # dependencies
    inotify-tools
    wireplumber playerctl mpdris2
    glaxnimate mlt mediainfo # kdenlive
    rnix-lsp nodePackages.pyright lua53Packages.lua-lsp # neovim lsp
    xorg.xinput # controller
    jq # grimblast

    # dev
    python310Full python310Packages.pip
    nodejs
    gnumake cargo gcc # compilers
    nixfmt # nix formatter
     
  ];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
  };

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

