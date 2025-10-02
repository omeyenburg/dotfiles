{
  imports = [
    ./neovim.nix
    ./zen-browser.nix
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
