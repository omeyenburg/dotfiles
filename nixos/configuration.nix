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

  # Enable the nix command.
#  nix = {
#    package = pkgs.nixVersions.stable;
#    extraOptions = ''
#      experimental-features = nix-command
#    '';
#  };
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
    wireless.enable = false;      # Enables wireless support via wpa_supplicant.

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

  services = {
    # Enable blueman interface
    blueman.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "de";
      variant = "mac";
      options = "caps:escape";
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
  };

  # Define a user account.
  # Don't forget to set a password with ‘passwd’.
  users.users.oskar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # Apps
      anki
      gimp
      kitty
      spotify
      discord
      obsidian
      inkscape
      mars-mips
      libreoffice-qt 
      logisim logisim-evolution

      # Tools
      fzf yazi tmux emacs figlet unzip gnumake fastfetch

      # Languages & Compilers
      gcc clang
      python312Full

#
#      # Language Servers
#      pkgs.rust-analyzer
#      pkgs.lua-language-server
#      pkgs.python312Packages.jedi-language-server
#
#      # Linters and Formatters
#      pkgs.python312Packages.flake8
#      pkgs.python312Packages.black
#      pkgs.rustfmt
#
#      # Utility Tools
#      pkgs.fd
#      pkgs.fzf
#      pkgs.ripgrep
#      pkgs.tree-sitter
#      pkgs.wl-clipboard
      
      # Latex
      zathura texlab texliveFull

      # Hyprland
      yad wofi mako pywal waybar hyprland hypridle hyprlock hyprshot hyprpaper hyprpicker

      # Deps
      hunspell hunspellDicts.de_DE hunspellDicts.en_US-large
    ];
  };

  # Allow non-free software (e.g. spotify).
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile.
  
    environment.systemPackages = with pkgs; [
      inputs.neovim.packages."${pkgs.system}".neovim
      #inputs.neovim.packages.x86_64-linux.default
      #(myFlake.packages.${system}.default or (throw "Package 'default' not found in the flake"))
      #(import /home/oskar/.config/nixos/flakes/neovim) # { system = "x86_64-linux"; }).packages.x86_64-linux.neovimEnv
      # Tools
      # inputs.nvim.defaultPackage.x86_64-linux
      #inputs.neovimEnv

      git vim btop tree wget curl

      # Theme
      adwaita-qt adwaita-qt6

      # System
      acpi xorg.xrdb brightnessctl power-profiles-daemon intel-gpu-tools linux-firmware

      # Bluetooth
      bluez bluez-tools b43FirmwareCutter b43Firmware_6_30_163_46 broadcom-bt-firmware
    ];
  

  environment = {
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
      # LIBVA_DRIVER_NAME = "i965";  # or "iHD" for newer Intel GPUs
      # VDPAU_DRIVER = "va_gl";
  
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
  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs = {
    firefox.enable = true;
    hyprland.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
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
