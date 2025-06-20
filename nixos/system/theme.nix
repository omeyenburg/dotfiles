{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # Enable catppuccin globally.
  catppuccin.enable = true;

  environment.sessionVariables = {
    # QT
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # nmtui colors
    # Elements: root, border, window, shadow, title, button, actbutton, checkbox, actcheckbox, entry, label, listbox, actlistbox, textbox, acttextbox, helpline, roottext, emptyscale, fullscale, disentry, compactbutton, actsellistbox, sellistbox
    # Syntax: <element>=<fg>,<bg>
    NEWT_COLORS = ''
      root=default,default
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

  # Manage installed and default fonts.
  # List all available fonts using:
  # fc-list | sed 's/.*: \(.*\):.*/\1/' | sort | uniq
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dejavu_fonts
      unstable.nerd-fonts.fira-mono
      unstable.nerd-fonts.jetbrains-mono
      unstable.nerd-fonts.ubuntu-mono
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font"];
        # monospace = ["UbuntuMono Nerd Font"];
        sansSerif = ["DejaVu Sans"];
        serif = ["DejaVu Serif"];
      };
    };
  };
}
