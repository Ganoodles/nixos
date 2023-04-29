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

	# Allows unfree programs
	nixpkgs.config.allowUnfree = true;

	# packages
	home.packages = with pkgs; [
		alacritty
		spotify
		bitwarden
		kdenlive
		discord
		zsh
	];

	programs.zsh = {
		enable = true;
		shellAliases = {
                        an-apply = "sudo nixos-rebuild switch --flake .#";
                        an-update-system = "nix flake update";
                        an-update-user = "nix-channel --update";
                        an-clean-garbage = "sudo nix-collect-garbage -d";
                        ll = "ls -l";
		};
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "fishy";
		};
	};

}
