{
  imports = [
    ./librewolf.nix
    ./neovim.nix
  ];

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };

    btop = {
      enable = true;
    };

    yazi = {
      enable = true;
    };
  };
}
