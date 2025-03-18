{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.oskar-nixos = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        overlay-unstable = final: prev: {
          unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
        };
      };
      modules = [
        ./hardware-configuration.nix
        ./hosts/macbook.nix
        ./home-manager
        ./system
      ];
    };
  };
}
