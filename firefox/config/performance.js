/*

Performance patches for my old intel gpu.

Benchmarks:
- https://profiler.firefox.com
- https://browserbench.org/Speedometer3.1
- https://webglsamples.org/aquarium/aquarium.html

*/

// Reduce number of processes
// Determined by number of CPU cores/processors
user_pref("dom.ipc.processCount", 2);
user_pref("dom.ipc.processCount.webIsolated", 1);

// Reduce animations
user_pref("toolkit.cosmeticAnimations.enabled", false);
user_pref("ui.prefersReducedMotion", 1);

// WebGL and Graphics Acceleration
user_pref("gfx.webrender.enabled", true);
user_pref("layers.acceleration.force-enabled", true);
user_pref("layers.gpu-process.enabled", true);
user_pref("webgl.disabled", false); // required
user_pref("webgl.force-enabled", true);

// Hardware decoding
user_pref("media.av1.enabled", false);
user_pref("media.ffvpx.enabled", true); // fallback software decoder
user_pref("media.rdd-vpx.enabled", true); // TODO: can help with VP8/VP9, but not always HW
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.gpu-process-decoder", true);
user_pref("media.gpu-process.enabled", true);
// user_pref("media.gpu-process.force-enabled", true);
// user_pref("media.hardware-video-decoding.force-enabled", true);

user_pref("media.navigator.mediadatadecoder_vpx_enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);

// Disable VP8/VP9 in WebM, but might break sites
// user_pref("media.webm.enabled", false);

// No difference
// user_pref("dom.enable_web_task_scheduling", true);
// user_pref("dom.webgpu.enabled", true);
// user_pref("gfx.canvas.accelerated", true);
// user_pref("gfx.webgpu.ignore-blocklist", true);
// user_pref("gfx.webrender.all", true);
// user_pref("gfx.webrender.compositor", true);
// user_pref("gfx.webrender.compositor.force-enabled", true);
// user_pref("gfx.webrender.enabled", true);
// user_pref("gfx.webrender.precache-shaders", true); // Disable caching as it only increases RAM/IO usage
// user_pref("gfx.webrender.program-binary-disk", true);
// user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", false);
// user_pref("gfx.webrender.software.opengl", false);
// user_pref("javascript.options.asyncstack", false);
// user_pref("javascript.options.baselinejit", true);
// user_pref("javascript.options.ion", true);
// user_pref("layers.acceleration.force-enabled", true);
// user_pref("layers.gpu-process.enabled", true);
// user_pref("layers.gpu-process.force-enabled", true);
// user_pref("layers.offmainthreadcomposition.async-animations", true);
// user_pref("layout.frame_rate.precise", false);
// user_pref("media.hardware-video-decoding.enabled", true);
// user_pref("webgl.1.allow-core-profiles", true);
// user_pref("webgl.default-antialias", false);
// user_pref("webgl.enable-debug-renderer-info", false);
// user_pref("webgl.enable-draft-extensions", true);
// user_pref("webgl.msaa-samples", 0);
// user_pref("webgl.power-preference-override", 2);
// user_pref("webgl.prefer-16bpp", true);
