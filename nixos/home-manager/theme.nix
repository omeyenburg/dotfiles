{
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
      # adwaita-qt adwaita-qt6
    };
    #cursorTheme = ...
    #iconTheme = ...
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
    # platformTheme.name = "gtk";
    # style.name = "adwaita-dark";
    # style.package = pkgs.adwaita-qt;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
