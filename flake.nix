{
  description = "astra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      vm-nano = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/vm/nano/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      vm-mini = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/vm/mini/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      vm-full = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/vm/full/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
