{
  description = "Configuration NixOS de Nit";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      specialArgs = { inherit inputs; }; 
      
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        ./kde.nix
        ./boot-configuration.nix
        ./system-users-packages.nix
	./wireguard.nix
        inputs.agenix.nixosModules.default
      ];

    };
  };
}

