{
  description = "Kilian's NixOS coniguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
    };

    fluctus = {
      url = "path:/home/kilianm/projects/fluctus";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      inherit (nixpkgs) lib;
    in
    {
      packages.${system} = import ./pkgs { inherit pkgs; };

      homeManagerModules = import ./modules/home;

      nixosConfigurations = {
        albrecht = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self;
            host = "albrecht";
          };
          modules = [
            ./hosts/albrecht
          ];
        };

        loid = lib.nixosSystem {
          specialArgs = {
            host = "loid";
            inherit inputs outputs self;
          };
          modules = [
            ./hosts/loid
          ];
        };
      };

      homeConfigurations = {
        "kilianm@albrecht" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            host = "albrecht";
            inherit inputs outputs self;
          };
          modules = [
            ./home
            self.homeManagerModules.all
            inputs.zen-browser.homeModules.beta
          ];
        };

        "kilianm@loid" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            host = "loid";
            inherit inputs outputs self;
          };
          modules = [
            ./home
            self.homeManagerModules.all
            inputs.zen-browser.homeModules.beta
          ];
        };
      };
    };
}
