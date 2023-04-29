{
	description = "AAAAAAAAAAAAAAAAAAAAA";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-22.11";
		home-manager.url = "github:nix-community/home-manager/release-22.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { nixpkgs, home-manager, hyprland, ... }: 
	let
		system = "x86_64-linux";
		
		pkgs = import nixpkgs {
			inherit system;
			config = { allowUnfree = true; };
		};
		
		lib = nixpkgs.lib;

	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;

				modules = [
					(home-manager.nixosModules.home-manager)
				    	{
						config = {
							home-manager.users.noodle = import ./noodle/home.nix;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
						};
					}
					hyprland.nixosModules.default
					{ programs.hyprland.enable = true; }
					./system/configuration.nix
				];
			};
		};
		
	};
}
