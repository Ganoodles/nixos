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
		alacritty
		kitty # for hypr
		neovim
		
		python3Full
		nodejs
		gnumake
		cargo
		gcc
  
    # system apps
		firefox
    gnome.gnome-clocks

		spotify
    spotifyd
		bitwarden
		kdenlive
		webcord
    gimp

    # system utils
		kate
    dolphin
		
		zsh	
		zplug
		starship	

		# hypr
    libnotify
		rofi-wayland
    eww-wayland
		grim
		slurp
		hyprpaper
    mako
		udiskie
		clipman
		wl-clipboard
    xdg-desktop-portal-hyprland
	];

	# git is being stupid and gh wont work for authentication
#	programs.git.enable = true;
#	programs.git.extraConfig = {
#		core = {
#			sshCommand = "-i ~/.ssh/id_ed25519";
#		};
#	};

	programs.zsh = {
		enable = true;
		initExtra = ''
			export PATH="$HOME/.local/bin":$PATH
		'';
		shellAliases = {
      an-apply = "sudo nixos-rebuild switch --flake .# --install-bootloader";
      an-update-system = "nix flake update";
      an-update-user = "nix-channel --update";
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

	
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
		settings = {
			# add_newline = false;

			# character = {
			#   success_symbol = "[➜](bold green)";
			#   error_symbol = "[➜](bold red)";
			# };

			# package.disabled = true;
		};
  };

}
