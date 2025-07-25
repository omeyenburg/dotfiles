// Cookies & History
user_pref("privacy.bounceTrackingProtection.hasMigratedUserActivationData", true);
user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false);
user_pref("privacy.clearOnShutdown_v2.cache", false);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);
user_pref("privacy.clearOnShutdown_v2.formdata", true);
user_pref("privacy.history.custom", true);
user_pref("privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3", true);
user_pref("privacy.sanitize.cpd.hasMigratedToNewPrefs3", true);

// Keep first-party isolation to prevent cross-site tracking
user_pref("privacy.firstparty.isolate", true);

// maybe we should disable this bc of the frequent high cpu usage
user_pref("privacy.firstparty.isolate.block_post_message", false);

// HTTPS-only mode
// user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_pbm", true);

// Autofill
user_pref("dom.forms.autocomplete.formautofill", true);
user_pref("signon.autofillForms", false);
user_pref("signon.firefoxRelay.feature", "disabled");
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);

// Optional: Don't show insecure login warnings (if Bitwarden handles this for you)
user_pref("security.insecure_password.ui.enabled", false);

// Disable firefox telemetry
user_pref("browser.ml.enable", false);
user_pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false);
user_pref("extensions.pocket.enabled", false);

// Hide battery status
user_pref("dom.battery.enabled", false);

// Fingerprinting
user_pref("privacy.resistFingerprinting.pbmode", true);
user_pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC");

// Hide fonts
user_pref("layout.css.font-visibility", 0);

// Safe browsing
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);

// Disable weak ciphersuites
user_pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false);
user_pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", false);
user_pref("security.ssl3.dhe_rsa_aes_128_sha", false);
user_pref("security.ssl3.dhe_rsa_aes_256_sha", false);
user_pref("security.ssl3.ecdhe_rsa_aes_128_sha", false);
user_pref("security.ssl3.ecdhe_rsa_aes_256_sha", false);
user_pref("security.ssl3.rsa_aes_128_gcm_sha256", false);
user_pref("security.ssl3.rsa_aes_128_sha", false);
user_pref("security.ssl3.rsa_aes_256_gcm_sha384", false);
user_pref("security.ssl3.rsa_aes_256_sha", false);
user_pref("security.ssl3.rsa_des_ede3_sha", false);

// Disable TLS 1.0 and TLS 1.1
user_pref("security.tls.version.min", 3);

// Enable TLS Delegated Credentials
user_pref("security.tls.enable_delegated_credentials", true);

// Enable Encrypted Client Hello (ECH/ESNI)
// user_pref("network.dns.echconfig.enabled", true);
// user_pref("network.dns.http3_echconfig.enabled", true);
// user_pref("network.dns.use_https_rr_as_altsvc", true);
// user_pref("security.tls.ech.grease_http3", true);

// Disable captive portals and proxies
// captive protal must be enabled to get network notice in train
// user_pref("network.captive-portal-service.enabled", true);
// user_pref("network.notify.checkForProxies", true);
