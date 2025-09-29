{
  programs.librewolf = {
    enable = true;
    languagePacks = ["en-GB" "de"];
    settings = {
      # Option reference
      # https://searchfox.org
      # https://developer.mozilla.org/en-US/
      # https://kb.mozillazine.org/About:config_entries

      ### General

      # Disable animations, e.g. fullscreen animation
      "ui.prefersReducedMotion" = 1;

      # Keep tabs open
      "browser.startup.page" = 3;

      # Disable middle click paste
      "middlemouse.paste" = false;

      # Disable accessibility options
      "accessibility.force_disabled" = 1;

      # Pdf options
      "pdfjs.sidebarViewOnLoad" = 0;
      "pdfjs.defaultZoomValue" = "page-fit";

      # Video playback performance : Hardware Acceleration
      "media.rdd-vpx.enabled" = false;
      "media.ffvpx-hw.enabled" = false;
      "media.av1.use-dav1d" = false;
      "media.av1.enabled" = false;

      # Minor optimisation
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

      # Force downloads to correct download directory
      "browser.download.start_downloads_in_tmp_dir" = true;

      # Searching
      "browser.search.defaultenginename" = "DuckDuckGo";
      "browser.search.suggest.enabled" = true;
      "browser.urlbar.suggest.searches" = true;
      "browser.search.region" = "UK";
      "doh-rollout.home-region" = "UK";

      # Preferred language
      "intl.locale.requested" = "en-US,de";

      # Enable dark mode
      "ui.systemUsesDarkTheme" = 1;
      "layout.css.prefers-color-scheme.content-override" = 0;
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

      # Disable Autoplay
      # "media.autoplay.default" = 5;

      # Disable spellcheck
      "layout.spellcheckDefault" = 0;

      # Disable quit warning
      "browser.warnOnQuit" = false;
      "browser.warnOnQuitShortcut" = false;

      # New tab page
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.newtabWallpapers.highlightDismissed" = true;
      "browser.newtabpage.activity-stream.showSearch" = false;
      "browser.newtabpage.activity-stream.topSitesRows" = 2;
      "browser.newtabpage.pinned" = "[{\"url\":\"https://github.com/omeyenburg\",\"label\":\"Github\",\"baseDomain\":\"github.com\"},{\"url\":\"https://stackoverflow.com/\",\"label\":\"StackOverflow\",\"baseDomain\":\"stackoverflow.com\"},{\"url\":\"https://www.youtube.com/\",\"label\":\"Youtube\"},{\"url\":\"https://www.netflix.com/\",\"label\":\"Netflix\"},{\"url\":\"https://web.whatsapp.com/\",\"label\":\"Whatsapp\"},{\"url\":\"https://mail.google.com/mail/u/0/#inbox\",\"label\":\"Gmail\"},{\"url\":\"https://drive.google.com/drive/my-drive\",\"label\":\"Drive\"},{\"url\":\"https://calendar.google.com/calendar/u/0/r?pli=1\",\"label\":\"Calendar\"},{\"url\":\"https://chatgpt.com/\",\"label\":\"ChatGPT\"},{\"url\":\"https://gemini.google.com/app\",\"label\":\"Gemini\"},{\"url\":\"https://claude.ai/new\",\"label\":\"Claude\"},{\"url\":\"https://www.deepl.com/de/translator\",\"label\":\"DeepL\"},{\"url\":\"https://docs.google.com/\",\"label\":\"Docs\"},{\"url\":\"https://moodle2.uni-potsdam.de/\",\"label\":\"Moodle\"},{\"url\":\"https://puls.uni-potsdam.de/qisserver/rds?state=user&type=4&re=last&category=auth.logout&breadCrumbSource=\",\"label\":\"PULS\"},{\"url\":\"https://monkeytype.com/\",\"label\":\"Monkeytype\"}]";
      "browser.theme.toolbar-theme" = 0;
      "browser.translations.automaticallyPopup" = false;
      "browser.translations.panelShown" = false;
      "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[\"home-button\",\"developer-button\",\"preferences-button\",\"open-file-button\",\"find-button\",\"print-button\",\"bookmarks-menu-button\",\"history-panelmenu\"],\"unified-extensions-area\":[\"jid1-om7ejgwa1u8akg_jetpack-browser-action\",\"firefoxcolor_mozilla_com-browser-action\",\"_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action\",\"addon_darkreader_org-browser-action\",\"canvasblocker_kkapsner_de-browser-action\",\"_96ef5869-e3ba-4d21-b86e-21b163096400_-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"jid1-om7ejgwa1u8akg_jetpack-browser-action\",\"firefoxcolor_mozilla_com-browser-action\",\"_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"canvasblocker_kkapsner_de-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"_96ef5869-e3ba-4d21-b86e-21b163096400_-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\",\"widget-overflow-fixed-list\"],\"currentVersion\":21,\"newElementCount\":3}";
      "browser.urlbar.shortcuts.actions" = false;
      "sidebar.visibility" = "hide-sidebar";

      ### Privacy and Security

      # Enable webgl, which is a fingerprint vektor, but needed for 3d graphics, e.g. desmos
      # Consider using the Canvas Blocker extension.
      "webgl.disabled" = false;

      # Prevent website tracking clicks
      "browser.send_pings" = false;

      # HTTPS and encryption
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_ever_enabled" = true;
      "dom.security.https_only_mode_ever_enabled_pbm" = true;

      # Keep first-party isolation to prevent cross-site tracking
      "privacy.firstparty.isolate" = true;
      "privacy.firstparty.isolate.block_post_message" = true;

      # Disable speculative connections and prefetching
      "network.predictor.enabled" = false;
      "network.prefetch-next" = false;
      "network.http.speculative-parallel-limit" = 0;

      # Disable sending cross-site referrer info
      "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true;

      # Strip tracking data from URLs
      "privacy.query_stripping.enabled" = true;
      "privacy.query_stripping.enabled.pbmode" = true;

      # Disable 0-RTT data for better security
      "security.tls.enable_0rtt_data" = false;

      # Disable telemetry
      "extensions.pocket.enabled" = false;
      "app.shield.optoutstudies.enabled" = false;
      "browser.search.serpEventTelemetryCategorization.regionEnabled" = false;

      # Disable form data saving
      "browser.formfill.enable" = false;

      # Tracking and Fingerprinting Protection
      "privacy.resistFingerprinting" = false;
      "privacy.resistFingerprinting.pbmode" = true;
      "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
      "privacy.bounceTrackingProtection.mode" = 1;
      "privacy.donottrackheader.enabled" = true;
      "privacy.globalprivacycontrol.was_ever_enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.pbmode" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;

      # Hide battery status
      "dom.battery.enabled" = false;

      # Safe browsing
      "browser.safebrowsing.downloads.enabled" = true;
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.malware.enabled" = true;
      "browser.safebrowsing.phishing.enabled" = true;

      # No separate default for private browsing
      "browser.search.separatePrivateDefault" = false;

      # Hide fonts
      "layout.css.font-visibility" = 0;

      # Disable dns-over-https
      "network.trr.mode" = 0;

      # Handle bounce tracking protection migration
      "privacy.bounceTrackingProtection.hasMigratedUserActivationData" = true;

      # Security error reporting for xfocsp
      "security.xfocsp.errorReporting.automatic" = true;

      # Don't require OSCP to allow network login pages
      "security.OCSP.enabled" = 2;
      "security.OCSP.require" = false;

      # Disable weak ciphersuites
      "security.ssl3.ecdhe_ecdsa_aes_128_sha" = false;
      "security.ssl3.ecdhe_ecdsa_aes_256_sha" = false;
      "security.ssl3.dhe_rsa_aes_128_sha" = false;
      "security.ssl3.dhe_rsa_aes_256_sha" = false;
      "security.ssl3.ecdhe_rsa_aes_128_sha" = false;
      "security.ssl3.ecdhe_rsa_aes_256_sha" = false;
      "security.ssl3.rsa_aes_128_gcm_sha256" = false;
      "security.ssl3.rsa_aes_128_sha" = false;
      "security.ssl3.rsa_aes_256_gcm_sha384" = false;
      "security.ssl3.rsa_aes_256_sha" = false;
      "security.ssl3.rsa_des_ede3_sha" = false;

      # Disable TLS 1.0 and TLS 1.1
      "security.tls.version.min" = 3;

      # Enable TLS Delegated Credentials
      "security.tls.enable_delegated_credentials" = true;

      # Enable Encrypted Client Hello (ECH/ESNI)
      "network.dns.echconfig.enabled" = true;
      "network.dns.http3_echconfig.enabled" = true;
      "network.dns.use_https_rr_as_altsvc" = true;
      "security.tls.ech.grease_http3" = true;

      # Enforce CRLite revocation checks
      "security.pki.crlite_mode" = 2;

      ### Cookies and Storage

      # 0 = All cookies are allowed. (Default)
      # 1 = Only cookies from the originating server are allowed. (block third party cookies)
      # 2 = No cookies are allowed
      # 3 = Third-party cookies are allowed only if that site has stored cookies already from a previous visit
      "network.cookie.cookieBehavior" = 1;
      "network.cookie.cookieBehavior.pbmode" = 2;

      # 0 = The cookie's lifetime is supplied by the server. (Default)
      # 1 = The user is prompted for the cookie's lifetime
      # 2 = The cookie expires at the end of the session (when the browser closes)
      # 3 = The cookie lasts for the number of days specified by network.cookie.lifetime.days
      "network.cookie.lifetimePolicy" = 0;

      "network.cookie.cookieBehavior.optInPartitioning" = true;
      "network.cookie.cookieBehavior.optInPartitioning.pbmode" = true;

      # Keep history
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.sanitize.sanitizeOnShutdown" = false;
      "privacy.clearOnShutdown.offlineApps" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.history.custom" = true;

      ### Performance

      # Enable VAAPI hardware acceleration
      "widget.wayland-dmabuf-vaapi.enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.gpu-process-decoder" = true;
      "media.hardware-video-decoding.force-enabled" = true;

      # Enable WebRender and force GPU acceleration
      "gfx.webrender.all" = true;
      "gfx.webrender.compositor" = true;
      "gfx.webrender.compositor.force-enabled" = true;
      "gfx.webrender.enabled" = true;
      "gfx.webrender.precache-shaders" = true;
      "gfx.webrender.program-binary-disk" = true;
      "gfx.webrender.software.opengl" = true;
      "gfx.canvas.accelerated" = true;
      "layers.acceleration.force-enabled" = false;

      # Enable webgpu
      "dom.webgpu.enabled" = true;

      # Enable GPU process
      "layers.gpu-process.enabled" = true;
      "layers.gpu-process.force-enabled" = true;

      # Disable opaque region to avoid weird rendering issues in Wayland
      "widget.wayland.opaque-region.enabled" = false;

      # Disable captive portals and proxies
      "network.captive-portal-service.enabled" = false;
      "network.notify.checkForProxies" = false;

      ## Reduce number of processes
      "dom.ipc.processCount" = 1;
      "dom.ipc.processCount.webIsolated" = 1;
    };
  };
}
