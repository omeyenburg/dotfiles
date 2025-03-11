#  _   _ _       ___  ____
# | \ | (_)_  __/ _ \/ ___|
# |  \| | \ \/ / | | \___ \
# | |\  | |>  <| |_| |___) |
# |_| \_|_/_/\_\\___/|____/
#
{
  pkgs,
  ...
}: {
  home = {
    username = "oskar";
    homeDirectory = "/home/oskar";
    packages = [
      pkgs.gtk3
      pkgs.gtk4
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
      # adwaita-qt adwaita-qt6
    };
    #cursorTheme = ...
    #iconTheme = ...

    # use this together with: imports = [inputs.catppuccin.homeManagerModules.catppuccin];
    # catppuccin = {
    #   enable = true;
    #   flavor = "mocha";
    #   accent = "pink";
    #   size = "standard";
    #   tweaks = [ "normal" ];
    # };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/javascript" = "nvim.desktop";
      "application/json" = "nvim.desktop";
      "application/x-sh" = "nvim.desktop";
      "application/x-shellscript" = "nvim.desktop";
      "application/x-yaml" = "nvim.desktop";
      "application/xhtml+xml" = "nvim.desktop";
      "application/xml" = "nvim.desktop";
      "application/pdf" = "librefox.desktop";
      "image/*" = "gimp.desktop";
      "inode/*" = "yazi.desktop";
      "text/*" = "nvim.desktop";
      "x-scheme-handler/ssh" = "com.mitchellh.ghostty.desktop";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
