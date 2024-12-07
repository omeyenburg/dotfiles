#  _   _ _       ___  ____
# | \ | (_)_  __/ _ \/ ___|
# |  \| | \ \/ / | | \___ \
# | |\  | |>  <| |_| |___) |
# |_| \_|_/_/\_\\___/|____/
#

{ config, lib, pkgs, ... }:

{
  # System {{{

  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];
  
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "btusb" ];  # If your chip is supported by this module
    kernelParams = [ 
      "bluetooth.disable_ertm=1"  # Disable Enhanced Retransmission Mode
      "i915.enable_psr=0"         # Disables Panel Self Refresh to prevent flickering/stuttering.
      "i915.enable_fbc=1"         # Enables Framebuffer Compression for better performance.
      "i915.enable_guc=3"         # Enables GuC for better GPU scheduling (Broadwell supports this).
      "apm=power_off"
      "acpi=force"
     ];

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # }}}
  # Networking & Bluetooth {{{  

  # Define your hostname.
  networking.hostName = "oskar-nixos";

  # Networking options (use only one)
  # networking.wireless.enable = true;      # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Increase connection quality and range
        MaxConnections = "1";
        Experimental = "true";
        FastConnectable = "true";
        ReconnectAttempts = "7";
        ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
      };
    };
  };

  services.blueman.enable = true;

  # }}}
  # Localization & Internationalization {{{  

  # Set your time zone
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "mac";
    options = "eurosign:e,caps:escape";
  };

  # }}}
  # Graphics & Display {{{

  # Graphics
  services.xserver.videoDrivers = [ "intel" ];
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [
    pkgs.intel-vaapi-driver 
    # pkgs.intel-ocl # good for opencl
    # pkgs.intel-compute-runtime # good for opencl
    # pkgs.intel-media-driver # probably not needed or used; for newer cpu

    # VA-API
    pkgs.libva
    pkgs.libvdpau
    pkgs.vaapiIntel
    # pkgs.vaapiVdpau # Optional, unless you need VDPAU-to-VAAPI translation (for older or specific apps).

    pkgs.ffmpeg
    pkgs.ustreamer
  ];

  services.udisks2.enable = true;
  services.upower.enable = true;

  # Enable sound (pipewire or pulseaudio)
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  # };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Enable power profiles daemon
  services.power-profiles-daemon.enable = true;

  # }}}
  # Environment Variables {{{
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    XDG_BIN_HOME    = "$HOME/.local/bin";
    XDG_CURRENT_DESKTOP = "Hyprland";

    PATH = [ 
      "${XDG_BIN_HOME}"
    ];

    # Cursor                                                                           
    # XCURSOR_SIZE = "24";
    # XCURSOR_THEME = "Adwaita";
 
    # Toolkit backend
    # GTK_THEME = "Adwaita-dark";
    # GDK_BACKEND = "wayland,x11,*";
    # CLUTTER_BACKEND = "wayland";

    # QT config
    # QT_QPA_PLATFORM = "wayland;xcb";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Electron config
    # ELECTRON_ENABLE_SYSTEM_THEME = "true";
    # ELECTRON_FORCE_SYSTEM_THEME = "1";

    # Firefox
    # MOZ_ENABLE_WAYLAND = "1";
    # MOZ_WEBRENDER = "1";
    # MOZ_ACCELERATED = "1";
    # MOZ_DISABLE_RDD_SANDBOX = "1";

    # General config
    # EDITOR = "nvim";
    # TERMINAL = "kitty";
    # FONT = "FiraCode Nerd Font";
  
    # Video acceleration
    LIBVA_DRIVER_NAME = "i965";  # or "iHD" for newer Intel GPUs
    VDPAU_DRIVER = "va_gl";

    # Remove if running into compatibility issues
    # SDL_VIDEODRIVER = "wayland";

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

  # }}}
  # Users {{{

  # Define a user account. Don't forget to set a password with passwd.
  users.users.oskar = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable sudo for the user
    packages = with pkgs; [
      pkgs.yazi
      pkgs.tmux
      pkgs.kitty
      pkgs.emacs
      pkgs.neovim
      pkgs.ripgrep
      pkgs.fastfetch

      unzip
      libgcc
      gnumake
      python313

      pkgs.gimp
      pkgs.spotify
      pkgs.discord
      pkgs.obsidian
      pkgs.inkscape
      pkgs.mars-mips
      pkgs.logisim
      pkgs.logisim-evolution

      pkgs.hunspell
      pkgs.hunspellDicts.de_DE
      pkgs.hunspellDicts.en_US-large
      pkgs.libreoffice-qt

      pkgs.zathura
      pkgs.texliveBasic

      pkgs.yad
      pkgs.wofi
      pkgs.mako
      pkgs.pywal
      pkgs.waybar
      pkgs.figlet

      pkgs.hyprland
      pkgs.hypridle
      pkgs.hyprlock
      pkgs.hyprshot
      pkgs.hyprpaper
      pkgs.hyprpicker
    ];
  };

  # }}}
  # Packages {{{

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    pkgs.git
    pkgs.vim
    pkgs.btop
    pkgs.tree
    pkgs.wget
    pkgs.curl
    pkgs.libgcc

    pkgs.acpi
    pkgs.xorg.xrdb
    pkgs.wl-clipboard
    pkgs.brightnessctl
    pkgs.power-profiles-daemon

    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    # pkgs.xsettingsd
    # pkgs.libsForQt5.qt5ct

    pkgs.intel-gpu-tools

    # Bluetooth
    pkgs.bluez
    pkgs.bluez-tools
    pkgs.linux-firmware
    pkgs.b43FirmwareCutter
    pkgs.b43Firmware_6_30_163_46
    pkgs.broadcom-bt-firmware
  ];

  # Allow non-free software (e.g. spotify)
  nixpkgs.config.allowUnfree = true;

  # }}}

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
