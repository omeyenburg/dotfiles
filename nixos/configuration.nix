#  _   _ _       ___  ____
# | \ | (_)_  __/ _ \/ ___|
# |  \| | \ \/ / | | \___ \
# | |\  | |>  <| |_| |___) |
# |_| \_|_/_/\_\\___/|____/
#

{ config, lib, pkgs, inputs, ... }:

{
  # Include the results of the hardware scan.
  imports = [
    ./hardware-configuration.nix
  ];

  # Bug fix specific to MacBook Pro 12,1.
  # See https://github.com/NixOS/nixos-hardware/tree/master/apple/macbook-pro/12-1
  powerManagement.powerUpCommands = ''
    ${pkgs.systemd}/bin/systemctl restart wpa_supplicant.service
  '';

  # Enable the nix command and flakes.
  # nixos-rebuild switch will now first attempt to load /etc/nixos/flake.nix.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    # Clean temporary files in /tmp on every boot.
    tmp.cleanOnBoot = true;

    # Use latest stable Linux kernel available in NixOS.
    kernelPackages = pkgs.linuxPackages_latest;

    # Load btusb module, commonly used for Bluetooth adapters.
    # Only used if the chip is supported by this module.
    kernelModules = [ "btusb" ];

    # kernelParams = [
      # Recommendation: Yes, if you experience Bluetooth issues like stuttering. Otherwise, it’s not essential.
      # "bluetooth.disable_ertm=1"  # Disable Enhanced Retransmission Mode

      # Recommendation: Yes, especially if you notice flickering or stuttering in video playback or UI rendering.
      # "i915.enable_psr=0"         # Disables Panel Self Refresh to prevent flickering/stuttering.

      # Recommendation: Yes, as it benefits performance without significant downsides.
      # "i915.enable_fbc=1"         # Enables Framebuffer Compression for better performance.

      # Recommendation: Yes, as it can improve performance, especially with newer kernels.
      # "i915.enable_guc=3"         # Enables GuC for better GPU scheduling (Broadwell supports this).
     # ];

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    # Define the hostname.
    hostName = "oskar-nixos";

    # Pick only one of the below networking options.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    wireless.enable = false;       # Enables wireless support via wpa_supplicant.

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
    # Enable bluetooth.
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          # Increase connection quality and range.
          MaxConnections = "1";
          Experimental = "true";
          FastConnectable = "true";
          ReconnectAttempts = "7";
          ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
        };
      };
    };

    # Enable OpenGL
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services = {
    # Enable the blueman interface.
    blueman.enable = true;

    # Contrary to the name, also affects wayland
    # Configure keymaps in X11 and console.
    xserver.xkb = {
        layout = "de";
        variant = "mac";
        options = "caps:escape";
      # videoDrivers = [ "intel" ];
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound (pulseaudio or pipewire).
    # hardware.pulseaudio.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable power profiles daemon.
    power-profiles-daemon.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;

    # Enable the OpenSSH daemon.
    # openssh.enable = true;
    
    # Enable automatic disk mounting
    devmon.enable = true;

    # Handles disk mounting operations
    udisks2.enable = true;

    gvfs.enable = true;

    upower.enable = true;
  };

  # Define a user account.
  # Don't forget to set a password with ‘passwd’.
  users.users.oskar = {
    isNormalUser = true;
    extraGroups = [ # Enable ‘sudo’ for the user.
      "wheel"
      "networkmanager" # Allow editing network connections
      "storage" # Allow writing to external devices like usb drives
      "plugdev"
    ];
    packages = with pkgs; [
      # Apps
      qmk
      anki
      gimp
      spotify
      discord
      foliate
      obsidian
      inkscape
      mars-mips
      prismlauncher
      libreoffice-qt
      logisim logisim-evolution

      # Terminal
      kitty starship

      # Tools
      fzf tmux figlet unzip gnumake fastfetch
      bash-completion

      # Languages & Compilers
      gcc python312Full

      # Latex
      zathura texlab texliveFull

      # Hyprland
      yad wofi mako pywal waybar pw-volume
      hyprland hypridle hyprlock hyprshot hyprpaper hyprpicker

      # Deps
      hunspell hunspellDicts.de_DE hunspellDicts.en_US-large
    ];
  };

  # Allow non-free software (e.g. spotify).
  nixpkgs.config.allowUnfree = true;

  environment = {
    # Packages installed in system profile.
    systemPackages = with pkgs; [
      # Tools
      git vim btop tree wget curl

      # System
      acpi xorg.xrdb brightnessctl power-profiles-daemon intel-gpu-tools linux-firmware

      # Bluetooth
      bluez bluez-tools b43FirmwareCutter b43Firmware_6_30_163_46 broadcom-bt-firmware
    ];

    # Define environment variables for session processes.
    sessionVariables = rec {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
      XDG_BIN_HOME    = "$HOME/.local/bin";
      XDG_CURRENT_DESKTOP = "Hyprland";
      PATH = [ "${XDG_BIN_HOME}" ];

      NIXOS_OZONE_WL = "1";

      # Video acceleration
      LIBVA_DRIVER_NAME = "i965";  # or "iHD" for newer Intel GPUs
      VDPAU_DRIVER = "va_gl";

      # Configure nmtui colors
      # Elements: root, border, window, shadow, title, button, actbutton, checkbox, actcheckbox, entry, label, listbox, actlistbox, textbox, acttextbox, helpline, roottext, emptyscale, fullscale, disentry, compactbutton, actsellistbox, sellistbox
      # Syntax: <element>=<fg>,<bg>
      NEWT_COLORS = ''
        root=black,black
        border=black,lightgray
        window=white,lightgray
        shadow=white,black
        title=black,lightgray
        label=black,lightgray
        listbox=black,lightgray
        actlistbox=black,lightgray
        helpline=black,lightgray
        button=black,blue
        actbutton=black,blue
        checkbox=black,blue
        actcheckbox=black,blue
        entry=black,blue
        textbox=black,blue
        acttextbox=black,blue
        roottext=black,blue
        disentry=black,blue
        actsellistbox=black,blue
        sellistbox=black,blue
      '';
    };
  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs = {
    thunar.enable = true;
    firefox.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    starship.enable = true;
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

  # Configure qt theme.
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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
