/*

Miscellaneous settings chosen by personal preference.

*/

// Accessibility
user_pref("middlemouse.paste", false);
user_pref("accessibility.force_disabled", 1);
user_pref("accessibility.typeaheadfind.flashBar", 0); // Disable find flash
user_pref("ui.key.menuAccessKeyFocuses", false); // Disable menu bar toggling with alt

// Locale
user_pref("doh-rollout.home-region", "DE");
user_pref("intl.locale.requested", "en-US,de");

// Theme
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.theme.content-theme", 2);
user_pref("browser.theme.toolbar-theme", 2);
user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
user_pref("layout.css.prefers-color-scheme.content-override", 0);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // enable Firefox to use userChome, userContent, etc.

// Disable picture-in-picture
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
user_pref("media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled", false);

// Disable fullscreen warning and transition
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.delay", -1);
user_pref("full-screen-api.warning.timeout", 0);

// Disable Autoplay
user_pref("media.autoplay.default", 5);

// Disable spellcheck
user_pref("layout.spellcheckDefault", 0);

// Disable first-run setup prompts
user_pref("app.normandy.first_run", false);
user_pref("doh-rollout.doneFirstRun", true);

// Web search
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.search.separatePrivateDefault", false); // Same search engine for private windows
user_pref("browser.urlbar.suggest.searches", true); // Enable history based suggestions
user_pref("browser.search.suggest.enabled", false); // Do not send search to search engine early

// Mozilla UI
user_pref("browser.tabs.inTitlebar", 1);
user_pref("browser.toolbars.bookmarks.visibility", "never");

// Session & Startup
user_pref("browser.startup.page", 3); // Continue last session
user_pref("browser.sessionstore.max_tabs_undo", 50);
user_pref("browser.startup.homepage", "about:blank");

// Url bar
user_pref("browser.urlbar.shortcuts.actions", false);
user_pref("dom.text_fragments.create_text_fragment.enabled", true);

// Disable unnecessary UI features
user_pref("browser.warnOnQuit", false);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.preferences.experimental.hidden", false);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("pref.general.disable_button.default_browser", true);
user_pref("pref.privacy.disable_button.cookie_exceptions", false);
user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
user_pref("pref.privacy.disable_button.tracking_protection_exceptions", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("extensions.getAddons.showPane", false); // Personalized Extension Recommendations
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// Translations
user_pref("browser.translations.enable", false);
user_pref("browser.translations.autoTranslate", false);
user_pref("browser.translations.panelShown", false);
user_pref("browser.translations.automaticallyPopup", false);

// New tab page
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightDismissed", true);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.topSitesRows", 2);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.pinned", "[{\"url\":\"https://github.com/omeyenburg\",\"label\":\"Github\",\"baseDomain\":\"github.com\"},{\"url\":\"https://stackoverflow.com/\",\"label\":\"StackOverflow\",\"baseDomain\":\"stackoverflow.com\"},{\"url\":\"https://www.youtube.com/\",\"label\":\"Youtube\"},{\"url\":\"https://www.netflix.com/\",\"label\":\"Netflix\"},{\"url\":\"https://web.whatsapp.com/\",\"label\":\"Whatsapp\"},{\"url\":\"https://mail.google.com/mail/u/0///inbox\",\"label\":\"Gmail\"},{\"url\":\"https://drive.google.com/drive/my-drive\",\"label\":\"Drive\"},{\"url\":\"https://calendar.google.com/calendar/u/0/r?pli=1\",\"label\":\"Calendar\"},{\"url\":\"https://chatgpt.com/\",\"label\":\"ChatGPT\"},{\"url\":\"https://gemini.google.com/app\",\"label\":\"Gemini\"},{\"url\":\"https://claude.ai/new\",\"label\":\"Claude\"},{\"url\":\"https://www.deepl.com/de/translator\",\"label\":\"DeepL\"},{\"url\":\"https://docs.google.com/\",\"label\":\"Docs\"},{\"url\":\"https://moodle2.uni-potsdam.de/\",\"label\":\"Moodle\"},{\"url\":\"https://puls.uni-potsdam.de/qisserver/rds?state=user&type=4&re=last&category=auth.logout&breadCrumbSource=\",\"label\":\"PULS\"},{\"url\":\"https://monkeytype.com/\",\"label\":\"Monkeytype\"}]");

// Pdf reader
user_pref("pdfjs.disabled", true);
user_pref("pdfjs.enableAltText", true);
user_pref("pdfjs.enableAltTextForEnglish", true);
user_pref("pdfjs.sidebarViewOnLoad", 0);
user_pref("pdfjs.defaultZoomValue", "page-fit");

// Extensions & Add-ons
user_pref("extensions.pictureinpicture.enable_picture_in_picture_overrides", true);
user_pref("extensions.ui.dictionary.hidden", true);
user_pref("extensions.ui.extension.hidden", false);
user_pref("extensions.ui.locale.hidden", true);
user_pref("extensions.ui.sitepermission.hidden", true);
user_pref("extensions.ui.theme.hidden", false);
user_pref("extensions.webcompat.enable_shims", true);
user_pref("extensions.webcompat.perform_injections", true);

// Security key support
user_pref("dom.webauthn.enable", true);
user_pref("dom.webauthn.enable_conditional_mediation", true);
user_pref("security.webauth.webauthn_enable_softtoken", true);

// Store downloads in tmp directory
// user_pref("browser.download.start_downloads_in_tmp_dir", true);

// Disable adding downloads to the system's "recent documents" list
// user_pref("browser.download.manager.addToRecentDocs", false);
