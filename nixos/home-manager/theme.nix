{
  pkgs,
  # inputs,
  ...
}: {
  # imports = [
  #   inputs.catppuccin.homeManagerModules.catppuccin
  # ];

  # catppuccin = {
  #   enable = false;
  #   nvim.enable = false;
  #   btop.enable = false;
  #   gtk.enable = false;
  #   spotify-player.enable = true;
  # };

  home.packages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    gnome-themes-extra
    libsForQt5.qt5ct
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      size = 24;
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
