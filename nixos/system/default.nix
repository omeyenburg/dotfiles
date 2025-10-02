{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./theme.nix
  ];

  system.activationScripts.postRebuild = {
    deps = ["users"];
    text = ''
      if [ "$NIXOS_ACTION" = "switch" ]; then
        generation=$(readlink /nix/var/nix/profiles/system | ${pkgs.gnused}/bin/sed 's/^system-\([0-9]\+\)-link$/\1/')
        mkdir -p /var/nixos-backup
        cp -rf /etc/nixos /var/nixos-backup/system-$generation-config
      fi
    '';
  };

  nix = {
    settings = {
      # Enable the nix command and flakes.
      # nixos-rebuild switch will now first attempt to load /etc/nixos/flake.nix.
      experimental-features = ["nix-command" "flakes"];

      # Optimise store during each build.
      # Can also be done manually: nix-store --optimise
      # auto-optimise-store = true;
    };

    # Automatic garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
    };

    # Optimise only after garbage collection.
    optimise = {
      automatic = true;
    };
  };

  # Enable zram. Try to disable for now, maybe this causes problems?
  # zramSwap.enable = true;

  security = {
    # Whether to enable the RealtimeKit system service, which hands
    # out realtime scheduling priority to user processes on demand.
    # Used by PulseAudio and PipeWire to acquire realtime priority.
    # Might reduce audio latency.
    rtkit.enable = true;

    wrappers.btop = {
      source = "${pkgs.btop}/bin/btop";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
    };
  };

  boot = {
    # Select Linux kernel.
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_hardended;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages_xanmod;

    kernelModules = [
      "binder_linux"
      "ashmem_linux"
    ];

    # Location to save core crash files. Placeholders:
    kernel.sysctl = {
      "kernel.core_pattern" = "/var/crash/core.%e";
    };

    # Use the systemd-boot EFI boot loader.
    # Fixing spinning boot icon and sound on macos:
    # Reset nvram with alt+cmd+r+p while reboot.
    # Run `sudo nvram StartupMute=%01` on macos.
    # Run `sudo nixos-rebuild switch --install-bootloader` to reinstall bootloader.
    # Or better:
    # sudo efibootmgr --create --disk /dev/sda --part 1 --label "NixOS" --loader /EFI/systemd/systemd-bootx64.efi
    # or:
    # sudo mount /dev/sda1 /mnt/efi
    # sudo bootctl --path=/mnt/efi install
    # sudo bootctl --path=/mnt/efi status
    # Remove unnecessary boot entries with `sudo efibootmgr -b XXXX -B` (replace XXXX).
    loader = {
      efi.canTouchEfiVariables = true;
      grub.enable = false;
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
      };
      timeout = 5;
    };

    # Clean temporary files in /tmp on every boot.
    tmp.cleanOnBoot = true;
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
      wifi.powersave = false;
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

  # Select internationalisation properties.
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  # Inherit console keymap from XServer. See services.
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  hardware = {
    # Enable all firmware. Alternative: enableRedistributableFirmware
    enableAllFirmware = true;

    # Enable OpenGL.
    graphics = {
      enable = true; # Formally known as driSupport.
      enable32Bit = true; # For 32-bit applications e.g. from Wine/Steam.
    };

    # Enable bluetooth.
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    # Whether to enable non-root access to the firmware of QMK keyboards.
    keyboard.qmk.enable = true;

    # Enable printer airscanning.
    sane.extraBackends = [pkgs.sane-airscan];

    # Enable intel gpu tools
    intel-gpu-tools.enable = true;
  };

  # Define a user account.
  # Set a password with ‘passwd <user>’.
  users.users.oskar = {
    isNormalUser = true;
    linger = true;
    extraGroups = [
      "gamemode" # Allow gamemode to set CPU governor.
      "lp" # For printing, might not be necessary, just seen somewhere.
      "scanner" # For Scanning
      "networkmanager" # Allow editing network connections.
      "plugdev"
      "storage" # Allow writing to external devices like usb drives.
      "wheel" # Enable ‘sudo’ for the user.
      "video" # Enable intel-gpu-tools without root
      "docker"
      "adbusers" # Android debug bridge
      "kvm"
      "waydroid"
    ];
  };

  environment.sessionVariables = {
    XDG_BIN_HOME = "$HOME/.local/bin";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    EDITOR = "nvim";

    # Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Mozilla
    MOZ_WEBRENDER = "1";
    MOZ_ACCELERATED = "1";
    MOZ_LOG = "PlatformDecoderModule:5";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
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
