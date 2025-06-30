/*

Performance patches for my old intel gpu.

 TODO: Test the force-enabled options one by one for positive impact.

// Disable captive portals and proxies
// captive protal must be enabled to get network notice in train
user_pref("network.captive-portal-service.enabled", true);
user_pref("network.notify.checkForProxies", true);

*/

// Reduce number of processes
user_pref("dom.ipc.processCount", 2); // determine by number of CPU cores/processors
user_pref("dom.ipc.processCount.webIsolated", 1);

// Hardware decoding

// NOTE: Test this:
user_pref("gfx.webrender.dcomp-video-hw-overlay-win-force-enabled", true);
user_pref("dom.enable_web_task_scheduling", true);

user_pref("gfx.webgpu.ignore-blocklist", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.precache-shaders", true);
user_pref("gfx.webrender.program-binary-disk", true);
user_pref("gfx.webrender.software.opengl", false);
user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);
// user_pref("gfx.webrender.all", true);
// user_pref("gfx.webrender.compositor.force-enabled", true);
// user_pref("layers.acceleration.force-enabled", true);
// user_pref("layers.gpu-process.force-enabled", true);

user_pref("media.av1.enabled", false);
user_pref("media.ffvpx.enabled", false);
user_pref("media.rdd-vpx.enabled", true); // TODO: can help with VP8/VP9, but not always HW
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.gpu-process-decoder", true);
user_pref("media.gpu-process.enabled", true);
// user_pref("media.gpu-process.force-enabled", true);
// user_pref("media.hardware-video-decoding.force-enabled", true);

user_pref("media.navigator.mediadatadecoder_vpx_enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);

// Disable VP8/VP9 in WebM, might break sites
// trying to reenable this because of these cpu spikes
user_pref("media.webm.enabled", true);

// Tab Unloading (did not work well)
// // This is a very controversial topic, see:
// // https://github.com/zen-browser/desktop/issues/8822
// // Apparently Zen had this feature and removed it recently.

// // Sometimes tabs randomly get very active, even when not visited
// // This could fix it. Last time it happened with geogebra going wild.
// // Monitor with profile.firefox.com
// user_pref("dom.suspend_inactive_iframe", true);

// // Unload unused tabs
// user_pref("browser.tabs.unloadOnLowMemory", true);
// user_pref("browser.tabs.unloadOnLowMemory.force", true);

// // if the above 3 options dont help, consider installing "Auto Tab Discard" extension

// // default: 5 %. Pretty much makes it purely time based.
// // High percentage may cause breakage.
// user_pref("browser.low_commit_space_threshold_percent", 50);

// // Faster unloading (5 min)
// user_pref("browser.tabs.min_inactive_duration_before_unload", 300000);
