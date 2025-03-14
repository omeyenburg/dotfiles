{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # Enable catppuccin globally.
  catppuccin.enable = true;

  # Configure qt theme.
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.sessionVariables = {
    # GTK_THEME = "Adwaita-dark";

    # Configure nmtui colors
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
}
