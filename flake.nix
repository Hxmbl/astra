{
  description = "astra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      vm-nano = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/vm/nano/configuration.nix ];
      };

      vm-mini = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/vm/mini/configuration.nix ];
      };

      vm-full = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/vm/full/configuration.nix ];
      };
    };
  };
}
