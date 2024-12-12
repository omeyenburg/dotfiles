{
  inputs = {
    # Select the channel, e.g. github:NixOS/nixpkgs/nixos-unstable
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Add the Home Manager input from the community repository.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    # Use your hostname here.
    # Alternatively, you can select a configuration with:
    # nixos-rebuild switch --flake '/etc/nixos#hostname'
    nixosConfigurations.oskar-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Set all inputs parameters as special arguments for all submodules,
      # so you can directly use all dependencies in inputs in submodules
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        # Import Home Manager as a NixOS module.
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # backupFileExtension = "backup";
            users.oskar = import ./home.nix;
          };

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
