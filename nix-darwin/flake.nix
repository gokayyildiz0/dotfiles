{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nix-darwin }: {
    darwinConfigurations."Gokays-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # Architecture for Apple Silicon
      modules = [
        ./darwin-configuration.nix # System-level configuration
        # home-manager.darwinModules.home-manager {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.users.gokayyildiz = import ./home.nix;
        # }
      ];
    };

    homeConfigurations."Gokay's-Mac" = {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Define the package set
      modules = [ ./home.nix ]; # Specify the Home Manager modules
    };
  };
}