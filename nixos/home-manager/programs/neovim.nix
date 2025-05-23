{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    extraPackages = with pkgs; [
      # Language Servers
      nixd
      rust-analyzer
      glsl_analyzer
      lua-language-server
      bash-language-server
      cmake-language-server
      haskell-language-server
      python312Packages.jedi-language-server
      unstable.awk-language-server

      # Linters
      python312Packages.flake8

      # Formatters
      jq
      black
      shfmt
      taplo
      stylua
      indent
      rustfmt
      alejandra

      # Tools
      fd
      fzf
      ripgrep
      tree-sitter
      wl-clipboard
      rustup # Provides cargo & rust-analyzer
      unstable.clang-tools # Provides clangd, clang-format & clang-tidy
    ];
  };
}
