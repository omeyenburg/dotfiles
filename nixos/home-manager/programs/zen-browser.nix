{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      AppAutoUpdate = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableCrashReporter = true;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = true;
      ExtensionUpdate = true;
      HardwareAcceleration = true;
      ManualAppUpdateOnly = true;
      NetworkPrediction = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      SearchSuggestEnabled = false;
      SkipTermsOfUse = true;
      StartDownloadsInTempDirectory = false;
      TranslateEnabled = false;

      # To disable background probing
      # Might interfere with automatic network login
      # CaptivePortal = false;
      # Proxy = { Mode = "none"; };

      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
