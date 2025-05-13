{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
