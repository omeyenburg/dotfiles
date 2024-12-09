{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim.url = "path:./flakes/neovim";
  };

  #outputs = { self, nixpkgs, neovimEnv-flake, ... }: {
  outputs = inputs@{ self, nixpkgs, ... }: {
    # Use your hostname here.
    # Alternatively, you can select a configuration with:
    # nixos-rebuild switch --flake '/etc/nixos#my-hostname'
    nixosConfigurations.oskar-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Set all inputs parameters as special arguments for all submodules,
      # so you can directly use all dependencies in inputs in submodules
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
