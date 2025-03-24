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
      "brcmfmac"
    ];

    kernelParams = [
      # Benefits performance without significant downsides.
      # Enables Framebuffer Compression for better performance.
      "i915.enable_fbc=1"

      # Can improve performance, especially with newer kernels.
      # Enables GuC for better GPU scheduling (Broadwell supports this).
      "i915.enable_guc=3"

      # Enable fastboot
      "i915.fastboot=1"

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

  # Something like this, but doesnt seem to be related...
  # From : https://superuser.com/questions/795879/how-to-configure-dual-boot-nixos-with-mac-os-x-on-an-uefi-macbook
  # Enable the backlight control on rMBP
  # Disable USB-based wakeup
  # see: https://wiki.archlinux.org/index.php/MacBookPro11,x
  # powerManagement.powerUpCommands = ''
  #   if [[ "$(cat /sys/class/dmi/id/product_name)" == "MacBookPro11,3" ]]; then
  #     ${pkgs.pciutils}/bin/setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
  #
  #     if cat /proc/acpi/wakeup | grep XHC1 | grep -q enabled; then
  #       echo XHC1 > /proc/acpi/wakeup
  #     fi
  #   fi
  # '';

  # Video acceleration
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Or i965 for older Intel GPUs
    VDPAU_DRIVER = "va_gl";
  };
}
