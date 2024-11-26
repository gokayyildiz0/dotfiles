{
  description = "Gokay's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: {
    darwinConfigurations."Gokay's-Mac" = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # Architecture for Apple Silicon
      modules = [
        ./darwin-configuration.nix # System-specific configuration
        inputs.home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gokayyildiz = import ./home.nix; # User-specific Home Manager config
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."Gokay's-Mac".pkgs;
  };
}
