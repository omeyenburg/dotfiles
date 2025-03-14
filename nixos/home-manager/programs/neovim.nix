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
      haskell-language-server
      python312Packages.jedi-language-server

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

      # Utility Tools
      fd
      fzf
      ripgrep
      tree-sitter
      wl-clipboard
    ];
  };
}
