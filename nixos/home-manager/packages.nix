{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    anki
    discord
    ghostty
    gimp
    inkscape
    kitty
    libreoffice-qt
    obsidian
    prismlauncher
    spotify

    # foliate
    # logisim
    # logisim-evolution
    # mars-mips
    # gtk3
    # gtk4

    # Tools
    bash-completion
    btop
    fastfetch
    figlet
    gitmux
    gnumake
    qmk
    tmux
    unzip

    # Languages & Compilers
    gcc
    graalvm-ce
    python312Full

    # Latex
    texlab
    texliveFull
    zathura

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
