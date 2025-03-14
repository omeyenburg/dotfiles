{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs;
    };
    users.oskar = {
      imports = [
        ./programs
        ./packages.nix
        ./theme.nix
      ];

      home = {
        username = "oskar";
        homeDirectory = "/home/oskar";
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "application/javascript" = "nvim.desktop";
          "application/json" = "nvim.desktop";
          "application/x-sh" = "nvim.desktop";
          "application/x-shellscript" = "nvim.desktop";
          "application/x-yaml" = "nvim.desktop";
          "application/xhtml+xml" = "nvim.desktop";
          "application/xml" = "nvim.desktop";
          "application/pdf" = "librefox.desktop";
          "image/*" = "gimp.desktop";
          "inode/*" = "yazi.desktop";
          "text/*" = "nvim.desktop";
          "x-scheme-handler/ssh" = "com.mitchellh.ghostty.desktop";
        };
      };

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "24.11";
    };
  };
}
