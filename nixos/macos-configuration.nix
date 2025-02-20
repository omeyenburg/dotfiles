#  __  __            ____              _
# |  \/  | __ _  ___| __ )  ___   ___ | | __
# | |\/| |/ _` |/ __|  _ \ / _ \ / _ \| |/ /
# | |  | | (_| | (__| |_) | (_) | (_) |   <
# |_|  |_|\__,_|\___|____/ \___/ \___/|_|\_\
# 

{ pkgs, inputs, ... }:

{
  # Import hardware specific options. Find your module in this list:
  # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
  imports = [
    inputs.nixos-hardware.nixosModules.apple-macbook-pro-12-1
  ];

  boot = {
    # Load btusb module, commonly used for Bluetooth adapters.
    # Only used if the chip is supported by this module.
    kernelModules = [ "btusb" ];

    kernelParams = [
      # Set to 1, if you experience Bluetooth issues like stuttering.
      "bluetooth.disable_ertm=1"  # Disable Enhanced Retransmission Mode

      # Set to 0, if you notice flickering or stuttering in video playback or UI rendering.
      # Disables Panel Self Refresh to prevent flickering/stuttering.
      "i915.enable_psr=0"

      # Benefits performance without significant downsides.
      # Enables Framebuffer Compression for better performance.
      "i915.enable_fbc=1"

      # Can improve performance, especially with newer kernels.
      # Enables GuC for better GPU scheduling (Broadwell supports this).
      "i915.enable_guc=3"

      # Set to 0 to prevent bluetooth from disconnecting.
      "btusb.enable_autosuspend=0"

      # In nixos-hardware this is set to 0.
      # But it needs to be set to 1.
      "hid_apple.iso_layout=1"

      "pcie_aspm=off"
    ];
  };

  # Fix bluetooth.
  # Increase connection quality and range.
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          MaxConnections = "1";
          Experimental = "true";
          FastConnectable = "true";
          ReconnectAttempts = "7";
          ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
        };
      };
    };
  };

  # Fix wifi connection after suspend
  # services = {
  #   # Some udev stuff
  #   udev = {
  #     enable = true;
  #     #ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan*", RUN+="${pkgs.iw}/bin/iw dev %k set power_save off"
  #     extraRules = ''
  #       ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan*", RUN+="/bin/sh -c 'echo 1 > /sys/bus/pci/devices/0000:03:00.0/remove; sleep 1; echo 1 > /sys/bus/pci/rescan'"
  #     '';
  #   };
  # };

  # Bug fix specific to MacBook Pro 12,1.
  # See https://github.com/NixOS/nixos-hardware/tree/master/apple/macbook-pro/12-1
  # Replace NetworkManager with wpa_supplicant, if using wpa
  #powerManagement.powerUpCommands = ''
  #  ${pkgs.systemd}/bin/systemctl restart NetworkManager.service
  #  '';

  # Broadcom bluetooth firmware
  environment = {
    systemPackages = with pkgs; [
      b43FirmwareCutter
      b43Firmware_6_30_163_46
      broadcom-bt-firmware
    ];

    # Video acceleration
    sessionVariables = rec {
      LIBVA_DRIVER_NAME = "iHD"; # Or i965 for older Intel GPUs
      VDPAU_DRIVER = "va_gl";
    };
  };
}
