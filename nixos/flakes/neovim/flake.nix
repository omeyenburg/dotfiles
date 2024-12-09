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

        # Language Servers
        pkgs.clang-tools
        pkgs.rust-analyzer
        pkgs.glsl_analyzer
        pkgs.lua-language-server
        pkgs.bash-language-server
        pkgs.python312Packages.jedi-language-server

        # Linters
        pkgs.python312Packages.flake8

        # Formatters
        pkgs.shfmt
        pkgs.stylua
        pkgs.rustfmt
        pkgs.black # python312Packages.black

        # Utility Tools
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

# vim: set shiftwidth=2 tabstop=2 expandtab:
