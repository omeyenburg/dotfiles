{pkgs, ...}: {
  services = {
    # Enable the blueman interface.
    blueman.enable = true;

    # Configure keymaps in X11 and console.
    xserver = {
      autorun = false;
      videoDrivers = ["intel"];
      xkb = {
        layout = "de";
        variant = "mac";
        options = "caps:escape";
      };
    };

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      browsing = true;
      drivers = [
        pkgs.gutenprint
        pkgs.brlaser
      ];
    };

    # Enable SANE to scan documents.
    saned = {
      enable = true;
    };

    # Enable printer discovery.
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Enable sound (pulseaudio or pipewire).
    # hardware.pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
    };

    # Enable power profiles daemon (conflicts with tlp).
    # Also include powerprofilesctl package.
    # power-profiles-daemon.enable = true;

    # Enable tlp power management (conflicts with power profiles daemon).
    tlp = {
      enable = true;
      settings = {
        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 90;

        # WIFI_PWR_ON_BAT = "off";
        # WIFI_PWR_ON_AC = "off";
      };
    };

    # Enable automatic disk mounting.
    devmon.enable = true;

    # Handles disk mounting operations.
    udisks2.enable = true;

    # Smart card daemon
    pcscd.enable = true;

    # Login options
    logind = {
      killUserProcesses = true;
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "suspend";
      powerKey = "ignore";
      powerKeyLongPress = "poweroff";
    };
  };

  # Define notification service.
  systemd.user.services.notifier = {
    description = "Notifier Service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "%h/.config/hypr/scripts/notifier-service.sh";
    };
    wantedBy = ["default.target"];
    path = with pkgs; [
      curl
      gawk
      networkmanager
      python3
      wireplumber
    ];
  };

  systemd.user.timers.notifier = {
    description = "Notifier Service Timer";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Persistent = true;
      Unit = "notifier.service";
    };
    wantedBy = ["timers.target"];
  };
}
