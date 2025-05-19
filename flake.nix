{
  description = "KooL's NixOS-Hyprland"; 
  	
  inputs = {
	#nixpkgs.url = "nixpkgs/nixos-24.11";
  	nixpkgs.url = "nixpkgs/nixos-unstable";
	
	hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
	#distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
	ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
        
	zen-browser.url = "github:0xc000022070/zen-browser-flake";
        nixvim.url = "github:dc-tec/nixvim";
  	};

  outputs = 
	inputs@{ self, nixpkgs, ... }:
    	let
      system = "x86_64-linux";
      host = "ilfarin";
      username = "ilfarin";

    pkgs = import nixpkgs {
       	inherit system;
       	config = {
       	allowUnfree = true;
       	};
      };
    in
      {
	nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem rec {
		specialArgs = { 
			inherit system;
			inherit inputs;
			inherit username;
			inherit host;
			};
	   		modules = [ 
				./hosts/${host}/config.nix 
				# inputs.distro-grub-themes.nixosModules.${system}.default
				];
			};
		};
	};
}
