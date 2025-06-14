{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    #nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
    #distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    #nixvim config inspired with Lazyvim
    #nixvim.url = "github:dc-tec/nixvim";
    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #};


    #nixvim = {
    #    url = "github:nix-community/nixvim";
    #    # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
    #    inputs.nixpkgs.follows = "nixpkgs";
    #};



    nvf = {
      url = "github:notashelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
    };


#   nvf = {
#    url = "github:jack-thesparrow/schrovimger";
#    inputs.nixpkgs.follows = "nixpkgs";
#};



    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Yazi config
    # yazi.url = "github:sxyazi/yazi";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      anyrun,
      #nixvim,
      nvf,
      ...
    }:
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

#      packages."x86_64-linux".default = 
#      (nvf.lib.neovimConfiguration {
#
#	pkgs = nixpkgs.legacyPackages."x86_64-linux";
#	modules = [./nfx-configuration.nix];
#}).neovim; 

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
            { environment.systemPackages = [ anyrun.packages.${system}.anyrun ]; }
            # inputs.distro-grub-themes.nixosModules.${system}.default
            inputs.home-manager.nixosModules.default
            nvf.nixosModules.default # <- this imports the NixOS module that provides the options
            # (
            #       { pkgs, ... }:
            #{
            #                environment.systemPackages = [ yazi.packages.${pkgs.system}.default ];
            # }
            # )
          ];
        };
      };

      #  homeConfigurations = {
      # "${host}" = home-manager.lib.homeManagerConfiguration {
      # inherit pkgs;

      # modules = [
      # ./home-manager/default.nix # default config generated via `home-manager init`
      #  ];
      # };
      # };

    };
}
