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
      awk-language-server
      bash-language-server
      cmake-language-server
      glsl_analyzer
      haskell-language-server
      lua-language-server
      nixd
      python312Packages.jedi-language-server
      rust-analyzer

      # Linters
      python312Packages.flake8

      # Formatters
      alejandra
      black
      indent
      jq
      rustfmt
      shfmt
      stylua
      taplo

      # Tools
      cargo
      clang-tools # Provides clangd, clang-format & clang-tidy
      fd
      fzf
      ripgrep
      tree-sitter
      wl-clipboard
    ];
  };
}
