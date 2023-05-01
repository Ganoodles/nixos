{ config, pkgs, ... }:

{
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
		neovim
    zsh	zplug starship	
    neofetch
	
    # dev stuff
		python3Full
		nodejs
		gnumake cargo gcc # build tools
  
    # core system apps
		firefox
    gnome.gnome-clocks

    # other system apps
		spotifywm
		bitwarden
		kdenlive
		webcord
    gimp

    # funny
    cava

    # system utils
		kate
    gnome.nautilus
    gnome.eog

    # customization
    gnome.gnome-tweaks
    gradience
    adw-gtk3
    catppuccin-gtk
    catppuccin-cursors
    lxappearance
    gnome.gnome-themes-extra

    # audio
    pavucontrol
    easyeffects
    wireplumber
    playerctl

		# hypr
    xdg-desktop-portal-hyprland # xdg for hyprland
		rofi-wayland # files 
    swww # animated wallpaper daemon
    hyprpicker # color picker
    grim slurp # screenshot utility 
    mako # notification daemon
    libnotify # pushes notifications to mako
		udiskie # auto mounts stuff
		clipman wl-clipboard # clipboard manager
	];

	# git is being stupid and gh wont work for authentication
#	programs.git.enable = true;
#	programs.git.extraConfig = {
#		core = {
#			sshCommand = "-i ~/.ssh/id_ed25519";
#		};
#	};

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    extraConfig = ''
      confirm_os_window_close 0
      window_padding_width 10
    '';
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };

	programs.zsh = {
		enable = true;
		initExtra = ''
      source ~/.nix/themes/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
			export PATH="$HOME/.local/bin":$PATH
		'';
		shellAliases = {
      an-apply = "sudo nixos-rebuild switch --flake .# --install-bootloader";
      an-update-system = "sudo nix flake update";
      an-update-user = "sudo nix-channel --update";
      an-clean-garbage = "sudo nix-collect-garbage -d";
      ll = "ls -l";
		};
		zplug = {
			enable = true;
			plugins = [
				{ name = "zsh-users/zsh-autosuggestions"; }
				{ name = "zsh-users/zsh-syntax-highlighting"; }
			];
		};
	};

	
  programs.starship = 
    let
      flavour = "mocha";
    in {
      enable = true;
      # Configuration written to ~/.config/starship.toml
		  settings = {
        format = "$all";
        palette = "catppuccin_${flavour}";
		  } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "3e3e544"; # Replace with the latest commit hash
            sha256 = "soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
          } + /palettes/${flavour}.toml));
    };


}


