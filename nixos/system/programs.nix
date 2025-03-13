{
  programs = {
    # Install firefox.
    firefox.enable = true;

    # Install gamemode wrapper for games.
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          desiredgov = "performance";
          softrealtime = "auto";
          renice = 10; # Negated niceness value.
        };
      };
    };

    # Install hyprland.
    # xdg-desktop-portal-hyprland is automatically started with hyprland.
    hyprland.enable = true;

    # Install steam.
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };
}
