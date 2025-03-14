{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./theme.nix
  ];

  nix = {
    settings = {
      # Enable the nix command and flakes.
      # nixos-rebuild switch will now first attempt to load /etc/nixos/flake.nix.
      experimental-features = ["nix-command" "flakes"];

      # Optimise store during each build
      # Can also be done manually: nix-store --optimise
      auto-optimise-store = true;
    };

    # Automatic garbage collect
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  # Whether to enable the RealtimeKit system service, which hands
  # out realtime scheduling priority to user processes on demand.
  # Used by PulseAudio and PipeWire to acquire realtime priority.
  # Might reduce audio latency.
  security.rtkit.enable = true;

  boot = {
    # Clean temporary files in /tmp on every boot.
    tmp.cleanOnBoot = true;

    # Select Linux kernel.
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_hardended;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages_xanmod;

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    # Define the hostname.
    hostName = "oskar-nixos";

    # Choose either wpa_supplicant or networkmanager for networking.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = false;

    # Easiest to use and most distros use this by default.
    # Conflicts with wireless
    networkmanager = {
      enable = true;
      #wifi.powersave = false;
      #wifi.scanRandMacAddress = false;
    };

    # Configure network proxy if necessary.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  hardware = {
    # Enable OpenGL
    graphics = {
      enable = true; # Formally known as driSupport
      enable32Bit = true; # For Wine/Steam
      extraPackages = [
        pkgs.intel-compute-runtime # or use intel-ocl
        pkgs.intel-media-driver # or intel-vaapi-driver if older than 2014
      ];
    };

    # Whether to enable non-root access to the firmware of QMK keyboards.
    keyboard.qmk.enable = true;
  };

  # Define a user account.
  # Set a password with ‘passwd <user>’.
  users.users.oskar = {
    isNormalUser = true;
    extraGroups = [
      "gamemode" # Allow gamemode to set CPU governor.
      "lp" # For printing, might not be necessary, just seen somewhere.
      "networkmanager" # Allow editing network connections.
      "plugdev"
      "storage" # Allow writing to external devices like usb drives.
      "wheel" # Enable ‘sudo’ for the user.
    ];
  };

  environment.sessionVariables = {
    XDG_BIN_HOME = "$HOME/.local/bin";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    EDITOR = "nvim";

    MOZ_WEBRENDER = "1";
    MOZ_ACCELERATED = "1";

    # Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
