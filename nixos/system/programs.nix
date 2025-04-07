{pkgs, ...}: {
  programs = {
    # Enable firefox
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

    gnupg.agent = {
      enable = true;
      # enableSSHSupport = true; # Optional: Allows using GPG keys as SSH keys
      # enableExtraSocket = true; # Optional: Useful for tools like pass or browser integration
      # enableBrowserSocket = false; # Set to true if using GPG in the browser (e.g., for web-based password managers)
      pinentryPackage = pkgs.pinentry-curses; # Non-GUI-prompt
      settings = {
        # Passphrase stays cached for 20 minutes after use up to 4 hours
        default-cache-ttl = 1200;
        max-cache-ttl = 7200;
      };
    };

    thunderbird = {
      enable = true;
      preferences = {};
      preferencesStatus = "default";
    };
  };
}
