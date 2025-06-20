{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    anki
    discord
    gimp3
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
    yubikey-personalization
    yubikey-personalization-gui
    pinentry-curses

    # Tools
    bash-completion
    bat
    btop
    du-dust
    dua
    eza
    figlet
    fzf
    gitmux
    gnumake
    qmk
    ripgrep-all
    tmux
    unzip
    wl-clipboard

    # Man pages
    man-pages
    man-pages-posix

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
    python312Packages.numpy

    # Desktop tools
    mako
    playerctl
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
