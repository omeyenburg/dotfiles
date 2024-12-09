{
  description = "Neovim FHS environment with isolated dependencies";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    packages.x86_64-linux.neovim = pkgs.buildFHSUserEnv {
      name = "nvim";
      targetPkgs = pkgs: [
        pkgs.neovim
        pkgs.rust-analyzer
        pkgs.lua-language-server
        pkgs.python312Packages.jedi-language-server
        pkgs.python312Packages.flake8
        pkgs.python312Packages.black
        pkgs.rustfmt
        pkgs.fd
        pkgs.fzf
        pkgs.ripgrep
        pkgs.tree-sitter
        pkgs.wl-clipboard
      ];
      runScript = "${pkgs.neovim}/bin/nvim";
    };
  };
}
