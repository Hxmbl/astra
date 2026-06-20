{
  description = "astra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }: {
    nixosConfigurations = {
      vm-nano = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit zen-browser; };
        modules = [
          ./hosts/vm/nano/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      vm-mini = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit zen-browser; };
        modules = [
          ./hosts/vm/mini/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      vm-full = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit zen-browser; };
        modules = [
          ./hosts/vm/full/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit zen-browser; };
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
