{pkgs, ...}: {
  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };

    librewolf = {
      enable = true;
      settings = {};
      languagePacks = ["en-GB" "de"];
    };

    btop = {
      enable = true;
    };

    yazi = {
      enable = true;
    };

    # Configure Neovim dependencies.
    neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      withRuby = false;
      withNodeJs = false;
      withPython3 = false;
      defaultEditor = true;
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
  };
}
