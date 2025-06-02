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

      # In nixos-hardware this is set to 0.
      # But it needs to be set to 1.
      "hid_apple.iso_layout=1"

      # Helps with PCI errors on resume
      "pci=noaer"

      # Explicitly tell ACPI we support Darwin
      "acpi_osi=Darwin"
    ];
  };

  # Increase fan polling interval
  services = {
    mbpfan = {
      enable = true;
      settings.general.polling_interval = 3;
    };
  };

  hardware = {
    graphics.extraPackages = with pkgs; [
      # For gpus older than 2014
      # intel-vaapi-driver and intel-ocl
      # For newer gpus
      # intel-media-driver and intel-compute-runtime
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
      # intel-vaapi-driver

      # OpenCL or something
      intel-compute-runtime
      # intel-ocl

      # Quick Sync Video
      # https://nixos.wiki/wiki/Intel_Graphics
      # vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      intel-media-sdk   # for older GPUs
    ];

    # Improve bluetooth stability
    bluetooth.settings = {
      General = {
        MaxConnections = "1";
        Experimental = "true";
        FastConnectable = "true";
        ReconnectAttempts = "7";
        ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
      };
    };

    firmware = with pkgs; [
      firmwareLinuxNonfree
      linux-firmware
    ];
  };

  systemd.services = {
    reload-wifi-after-suspend = {
      description = "Reload Broadcom WiFi after suspend";
      path = with pkgs; [
        kmod
        gawk
      ];
      script = ''
        broken=$(lsmod | awk '$1=="brcmfmac" { found=1; if ($3=="0") { print "true"; exit } } END { if (!found) print "true" }')
        if [ "$broken" ]; then
          echo "Wifi appears to be broken..."
          echo 1 > /sys/bus/pci/devices/0000:03:00.0/remove || echo "Failed to delete"
          sleep 1
          echo 1 > /sys/bus/pci/rescan || echo "Failed to rescan"
        else
          echo "Its fine..."
        fi
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = false;
      };
    };

    "systemd-suspend".serviceConfig.ExecStartPost = [
      "+${pkgs.systemd}/bin/systemctl start reload-wifi-after-suspend.service"
    ];
  };

  # Video acceleration
  environment.sessionVariables = {
    # iHD for newer and i965 for older Intel GPUs
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
    ANV_VIDEO_DECODE = 1;
  };
}
