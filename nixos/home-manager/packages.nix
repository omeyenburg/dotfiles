{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    anki
    discord
    gimp
    inkscape
    kitty
    libreoffice-qt
    obsidian
    prismlauncher
    spotify
    # logisim
    # logisim-evolution
    # mars-mips

    # Yubikey
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    pinentry-curses

    # Tools
    bash-completion
    btop
    cmake
    fastfetch
    figlet
    gitmux
    gnumake
    qmk
    tmux
    unzip
    wl-clipboard

    # Pdf tools
    poppler_utils
    texlab
    texliveFull
    zathura

    # Languages & Compilers
    gcc
    gdb
    graalvm-ce
    python312Full

    # Hyprland
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    mako
    pw-volume
    pywal
    waybar
    wofi
    yad

    # Dictionary
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US-large
  ];
}
