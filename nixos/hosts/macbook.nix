{
  pkgs,
  inputs,
  ...
}: {
  # Import hardware specific options. Find your module in this list:
  # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
  imports = [
    inputs.nixos-hardware.nixosModules.apple-macbook-pro-12-1
  ];

  boot = {
    # Load btusb module, commonly used for Bluetooth adapters.
    kernelModules = [
      "btusb"
    ];

    kernelParams = [
      # Set to 1, if you experience Bluetooth issues like stuttering.
      # "bluetooth.disable_ertm=1" # Disable Enhanced Retransmission Mode

      # This hopefully prevents wifi/bluetooth from waking up from suspend.
      # "brcmfmac.disable_ap=1"
      # "pcie_aspm=off"

      # Set to 0, if you notice flickering or stuttering in video playback or UI rendering.
      # Disables Panel Self Refresh to prevent flickering/stuttering.
      #
      # but i just want to test if it has an impact...
      # "i915.enable_psr=1"

      # Benefits performance without significant downsides.
      # Enables Framebuffer Compression for better performance.
      # "i915.enable_fbc=1"

      # Can improve performance, especially with newer kernels.
      # Enables GuC for better GPU scheduling (Broadwell supports this).
      # "i915.enable_guc=3"

      # Set to 0 to prevent bluetooth from disconnecting.
      # "btusb.enable_autosuspend=0"

      # In nixos-hardware this is set to 0.
      # But it needs to be set to 1.
      "hid_apple.iso_layout=1"
    ];
  };

  services = {
    mbpfan.settings.general.polling_interval = 3;
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
  # hardware.firmware = with pkgs; [
    # b43FirmwareCutter
    # b43Firmware_6_30_163_46
    # broadcom-bt-firmware
    # firmwareLinuxNonfree
    # linux-firmware
  # ];

  # Video acceleration
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Or i965 for older Intel GPUs
    VDPAU_DRIVER = "va_gl";
  };
}
