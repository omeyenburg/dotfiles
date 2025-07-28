{
  pkgs,
  inputs,
  ...
}: {
  # Import hardware specific options.
  # https://github.com/NixOS/nixos-hardware
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
      # Enable Kernel Mode Setting (KMS) for Intel, probably redundant.
      "i915"

      # Enable Framebuffer Compression.
      "i915.enable_fbc=1"

      # Enable GuC for better GPU scheduling, should be supported on Broadwell.
      "i915.enable_guc=3"

      # Use European keyboard layout. nixos-hardware defaults to US layout.
      "hid_apple.iso_layout=1"

      # Disable Advanced Error Reporting (AER) for PCIe to suppress resume-time errors.
      "pci=noaer"

      # Spoof Darwin support to enable full hardware feature set.
      "acpi_osi=Darwin"
    ];
  };

  hardware = {
    graphics.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl

      # For intel GPUs older than 2014: intel-vaapi-driver and intel-ocl
      # For newer GPUs:                 intel-media-driver and intel-compute-runtime
      # Officially, Broadwell GPUs do not support the newer drivers, but it works.
      intel-media-driver
      intel-compute-runtime

      # Quick Sync Video (https://nixos.wiki/wiki/Intel_Graphics)
      # See this table for GPU support:
      # https://github.com/intel/libvpl?tab=readme-ov-file#dispatcher-behavior-when-targeting-intel-gpus
      # vpl-gpu-rt            # for newer GPUs
      intel-media-sdk # for older GPUs
    ];

    # Improve bluetooth stability
    bluetooth.settings = {
      General = {
        Class = "0x200414";
        FastConnectable = "true";
      };
    };
  };

  # Video acceleration
  # Use iHD for newer and i965 for older Intel GPUs.
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  systemd.services = {
    reload-wifi-after-suspend = {
      description = "Reload Broadcom wifi after suspend";
      path = with pkgs; [
        kmod
        gawk
      ];
      script = ''
        broken=$(lsmod | awk '$1=="brcmfmac" { found=1; if ($3=="0") { print "true"; exit } } END { if (!found) print "true" }')
        if [ "$broken" ]; then
          echo 1 > /sys/bus/pci/devices/0000:03:00.0/remove
          sleep 1
          echo 1 > /sys/bus/pci/rescan
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
}
