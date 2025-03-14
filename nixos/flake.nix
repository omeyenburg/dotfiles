{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs: {
    nixosConfigurations.oskar-nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
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
