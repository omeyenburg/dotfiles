{
  pkgs,
  overlay-unstable,
  ...
}: {
  nixpkgs = {
    # Allow non-free software
    config.allowUnfree = true;

    # Enable unstable packages
    # Accessable through pkgs.unstable.<package>
    overlays = [
      overlay-unstable
    ];

    # Compile glfw with wayland patches
    config.packageOverrides = pkgs: {
      glfw = pkgs.glfw.overrideAttrs (oldAttrs: {
        cmakeFlags =
          oldAttrs.cmakeFlags
          or []
          ++ [
            "-DGLFW_BUILD_WAYLAND=ON"
            "-DGLFW_BUILD_X11=OFF"
            "-DCMAKE_BUILD_TYPE=Release"
            "-DBUILD_SHARED_LIBS=ON"
            "-DCMAKE_C_FLAGS=-O3 -march=native -pipe"
            "-DCMAKE_CXX_FLAGS=-O3 -march=native -pipe"
          ];
      });
    };
  };

  environment.systemPackages = with pkgs; [
    # Tools
    fzf
    git
    vim
    tree
    wget
    curl
    cryptsetup
    efibootmgr

    # System
    acpi
    brightnessctl
    glfw

    # Don't know if i even use this anymore...
    # This is something related to .Xresources
    # xorg.xrdb

    # Conflicts with tlp
    # powerprofilesctl

    # Bluetooth
    bluez
    bluez-tools
  ];
}
