{
  description = "Home Manager configuration of sul";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixgl, nixpkgs, home-manager, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ nixgl.overlay ];
      };
    in {
      homeConfigurations."sul" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          [ ./home.nix inputs.nixvim.homeManagerModules.nixvim ./shell.nix ];
        # Optionally use extraSpecialArgs
        extraSpecialArgs = { inherit inputs nixgl; };
      };
    };
}
