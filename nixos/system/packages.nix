{
  pkgs,
  overlay-unstable,
  ...
}: {
  nixpkgs = {
    # Allow non-free software
    config.allowUnfree = true;

    # Enable unstable packages
    # Accessible through pkgs.unstable.<package>
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
    # General Tools
    fzf
    git
    vim
    tree

    # Disk
    cryptsetup
    efibootmgr

    # Networking
    curl
    dig
    wget

    # System
    acpi
    brightnessctl
    glfw

    # Conflicts with tlp
    # powerprofilesctl

    # Man pages
    man-pages
    man-pages-posix

    # Bluetooth
    bluez
    bluez-tools

    # Scanner
    sane-airscan
    sane-backends
    simple-scan
  ];
}
