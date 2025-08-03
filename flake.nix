{

  description = "My first flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # User Settings
      userSettings = {
        username = "buddia";
        name = "Alan";
        email = "fife.alan@protonmail.com";
      };
    in {
    nixosConfigurations = {
      alan-laptop-nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./bluebubbles.nix
          ./pi.nix
          ./obsstudio.nix
          ./steam.nix
          ./uxplay.nix
          ./remote-desktop.nix
        ];
        specialArgs = {
          inherit userSettings;
        };
      };
    };
    homeConfigurations = {
      buddia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit userSettings;
        };
        modules = [ ./home.nix ];
      };
    };
  };
  
}
