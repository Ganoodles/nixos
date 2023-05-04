{
	description = "AAAAAAAAAAAAAAAAAAAAA";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager";
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
              home-manager.users.noodle.imports  = [
                ./noodle/home.nix
                (hyprland.homeManagerModules.default)
              ];
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
