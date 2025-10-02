{pkgs, ...}: {
  # systemd.user.services.dropbox = {
  #   Unit = {
  #     Description = "Dropbox service";
  #   };
  #   Install = {
  #     WantedBy = ["default.target"];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.dropbox}/bin/dropbox";
  #     Restart = "on-failure";
  #   };
  # };

  # systemd.user.services.unison-notes = {
  #   Unit = {
  #     Description = "Sync notes with Unison";
  #   };
  #   Service = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.bash}/bin/bash /home/oskar/.local/bin/dot-unison-sync-notes";
  #     Environment = "DISPLAY=:0";
  #   };
  # };

  # systemd.user.timers.unison-notes = {
  #   Unit = {
  #     Description = "Run Unison notes sync every 10 minutes";
  #   };
  #   Install = {
  #     WantedBy = ["default.target"];
  #   };
  #   Timer = {
  #     OnBootSec = "10m";
  #     OnUnitActiveSec = "10m";
  #     Persistent = true;
  #   };
  # };
}
