{ config, pkgs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    username = "oskar";
    homeDirectory = "/home/oskar";

    packages = with pkgs; [
      gtk3
      gtk4
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Configure Neovim dependencies.
    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        # Language Servers
        pkgs.nixd
        pkgs.rust-analyzer
        pkgs.glsl_analyzer
        pkgs.lua-language-server
        pkgs.bash-language-server
        pkgs.python312Packages.jedi-language-server

        # Linters
        pkgs.python312Packages.flake8

        # Formatters
        pkgs.black
        pkgs.shfmt
        pkgs.stylua
        pkgs.rustfmt

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
    # "org/gnome/desktop/background" = {
    #   picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    # };
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

  # Wayland, X, etc. support for session vars
  # systemd.user.sessionVariables = config.home-manager.users.oskar.home.sessionVariables;
  # systemd.user.sessionVariables = config.home-manager.users.oskar.home.sessionVariables;

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
