{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    anki
    gimp3
    kitty
    libreoffice-qt
    spotify
    ungoogled-chromium

    # discord
    # inkscape
    # prismlauncher
    # logisim
    # logisim-evolution
    # mars-mips
    # graalvm-ce

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
    fd
    fzf
    gitmux
    gnumake
    qmk
    ripgrep
    ripgrep-all
    tmux
    unzip
    wl-clipboard

    # Notes
    unison
    rclone
    obsidian

    # Man pages
    man-pages
    man-pages-posix

    # Pdf tools
    poppler_utils
    texlab
    texliveFull
    zathura

    # Language-specific tools
    gcc
    gdb
    lldb
    nodejs
    rustup
    (pkgs.python312.withPackages (p: [
      p.numpy
    ]))

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
