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
    # Tools
    bc
    git
    git-crypt
    git-remote-gcrypt
    intel-gpu-tools
    jq
    libva-utils
    subversion
    tree
    vdpauinfo
    vim

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
    socat

    # Conflicts with tlp
    # powerprofilesctl

    # Bluetooth
    bluez
    bluez-tools

    # Scanner
    sane-airscan
    sane-backends
    simple-scan

    # Hyprland
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    hyprsunset
  ];
}
