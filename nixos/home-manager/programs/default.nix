{
  imports = [
    ./librewolf.nix
    ./neovim.nix
  ];

  programs = {
    home-manager.enable = true;

    zoxide = {
      enable = true;
    };

    btop = {
      enable = true;
    };

    yazi = {
      enable = true;
    };
  };
}
