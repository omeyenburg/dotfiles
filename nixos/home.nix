#  _   _ _       ___  ____
# | \ | (_)_  __/ _ \/ ___|
# |  \| | \ \/ / | | \___ \
# | |\  | |>  <| |_| |___) |
# |_| \_|_/_/\_\\___/|____/
#

{ config, pkgs, inputs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    username = "oskar";
    homeDirectory = "/home/oskar";

    packages = [
      pkgs.gtk3
      pkgs.gtk4
      inputs.ghostty.packages."${pkgs.system}".default
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };

    btop = {
      enable = true;
    };

    yazi = {
      enable = true;
    };

    emacs = {
      enable = true;

      # Install additional Emacs packages with Home Manager
      #extraPackages = epkgs: with epkgs; [
        ## Org mode packages
        #epkgs.org
        #epkgs.org-contrib
        #epkgs.org-bullets
        #
        ## Evil mode packages
        #epkgs.evil
        #epkgs.evil-collection
        #epkgs.evil-org
        #evil-surround
#
        #use-package
      #];
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
        pkgs.nixd
        pkgs.rust-analyzer
        pkgs.glsl_analyzer
        pkgs.lua-language-server
        pkgs.bash-language-server
        pkgs.haskell-language-server
        pkgs.python312Packages.jedi-language-server

        # Linters
        pkgs.python312Packages.flake8

        # Formatters
        pkgs.jq
        pkgs.black
        pkgs.shfmt
        pkgs.taplo
        pkgs.stylua
        pkgs.indent
        pkgs.rustfmt
        pkgs.alejandra

        # Utility Tools
        pkgs.fd
        pkgs.fzf
        pkgs.ripgrep
        pkgs.tree-sitter
        pkgs.wl-clipboard
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
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["com.github.johnfactotum.Foliate.desktop"];
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
