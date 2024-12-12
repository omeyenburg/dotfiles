# NeoVim flake
This flake encapsulates some dependencies for NeoVim, that are available from within NeoVim.
But I would advice you to prefer using home-manager over this flake, as home-manager provides more flexibility.

You can use the modified NeoVim package in your configuration.nix as:
`inputs.neovim.packages."${pkgs.system}".neovim`

This requires `inputs` to be one of the function parameters.
Your `flake.nix` of your system should look something like this:

```
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim.url = "path:path/to/flake";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
```
