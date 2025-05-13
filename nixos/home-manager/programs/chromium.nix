{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--disable-background-networking"
      "--disable-features=WebRtcHideLocalIpsWithMdns"
      "--disable-pdf"
      "--enable-accelerated-video-decode"
      "--enable-features=VaapiVideoDecoder,UseOzonePlatform"
      "--force-webrtc-ip-handling-policy=default_public_interface_only"
      "--ignore-gpu-blocklist"
      "--no-default-browser-check"
      "--ozone-platform=wayland"
      "--rewards=off"
      "--use-gl=egl"
    ];
  };
}
