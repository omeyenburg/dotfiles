/*

When configuring Zen-Browser you might want to reset your prefs.js,
which contains all options set in about:config.
This file can be used to re-apply the most essential options.
The first option is required and must match with your installed extensions.

Make sure to include wayland.js and zen.js as well.

*/

user_pref("extensions.webextensions.uuids", "{\"formautofill@mozilla.org\":\"2f9fbe56-3ca6-48f7-8d98-dd9ff689a19d\",\"pictureinpicture@mozilla.org\":\"b8802bce-da0c-43f0-b6e9-1b19075f9046\",\"addons-search-detection@mozilla.com\":\"063828b6-0776-4c93-8cd1-01370cc1f7f7\",\"webcompat@mozilla.org\":\"79ffc373-9474-487a-a664-1a236339f1c6\",\"default-theme@mozilla.org\":\"700badfa-7670-4f01-b69b-f2c032f44412\",\"{446900e4-71c2-419f-a6a7-df9c091e268b}\":\"687be909-ef54-42eb-9c6b-9f2f11f31799\",\"uBlock0@raymondhill.net\":\"9ba0ce64-c667-4a4e-a34b-186da6b08686\",\"firefox-compact-dark@mozilla.org\":\"9b6145f4-59f3-4b0e-a890-7edde80bbc54\",\"myallychou@gmail.com\":\"a7514079-f544-422b-b5e2-3d767b1acc47\",\"{9a41dee2-b924-4161-a971-7fb35c053a4a}\":\"b5a8453a-7eed-40fd-b7d1-d09f33eeedbe\",\"CanvasBlocker@kkapsner.de\":\"defe14ac-d1e3-4e21-88e3-50331b0aed8c\",\"{0c8fbd76-bdeb-4c52-9b24-d587ce7b9dc3}\":\"73bd8a32-20d8-49ca-9d13-3f5c14a53cc0\"}");

user_pref("app.normandy.first_run", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.startup.homepage_override.mstone", "139.0.4");
user_pref("browser.startup.lastColdStartupCheck", 1750951115);
user_pref("browser.warnOnQuit", false);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("doh-rollout.doneFirstRun", true);
user_pref("doh-rollout.home-region", "DE");
