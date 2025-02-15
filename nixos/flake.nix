#  _   _ _       ___  ____
# | \ | (_)_  __/ _ \/ ___|
# |  \| | \ \/ / | | \___ \
# | |\  | |>  <| |_| |___) |
# |_| \_|_/_/\_\\___/|____/
#

{
  inputs = {
    # Select the channel, e.g. github:NixOS/nixpkgs/nixos-unstable.
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Add hardware input module.
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Add the Home Manager input from the community repository.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin theme.
    catppuccin.url = "github:catppuccin/nix";

    # Add ghostty input.
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    catppuccin,
    ghostty,
    ...
  }: {
    # Use your hostname here.
    # Alternatively, you can select a configuration with:
    # nixos-rebuild switch --flake '/etc/nixos#hostname'.
    nixosConfigurations.oskar-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Set all inputs parameters as special arguments for all submodules,
      # so you can directly use all dependencies in inputs in submodules.
      specialArgs = { inherit inputs; };
      modules = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix

        # Include macbook/intel specific configuration.
        ./macos-configuration.nix

        # Include main configuration.
        ./configuration.nix

        # Add catppuccin theme.
        catppuccin.nixosModules.catppuccin
        { catppuccin.enable = true; }

        # Import Home Manager as a NixOS module.
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            # Optionally, use home-manager.extraSpecialArgs
            # to pass arguments to home.nix.
            extraSpecialArgs = { inherit inputs; };

            users.oskar.imports = [
              ./home.nix
            ];
          };

          # Wayland, X, etc. support for session vars.
          # systemd.user.sessionVariables = config.home-manager.users.oskar.home.sessionVariables;
        }
      ];
    };
  };
}
