{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--disable-background-networking"
      "--disable-features=WebRtcHideLocalIpsWithMdns,UseChromeOSDirectVideoDecoder,UseSkiaRenderer"
      "--disable-pdf"
      "--enable-accelerated-video-decode"
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiVideoDecodeLinuxGL,VaapiIgnoreDriverChecks"
      "--force-webrtc-ip-handling-policy=default_public_interface_only"
      "--ignore-gpu-blocklist"
      "--no-default-browser-check"
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      "--rewards=off"
      "--use-angle=gl"
      "--use-gl=egl"
    ];
  };
}
