#include "wait.h"
#include "quantum.h"

#define LAYER0 1, 17, 8
#define LAYER1 21, 11, 0
#define LAYER2 14, 2, 19
#define LAYER3 9, 1, 13
#define LAYER4 1, 9, 10
#define LAYER5 15, 2, 5
#define DEFAULT 0, 0, 0


// This is to keep state between callbacks, when it is 0 the initial RGB flash is finished
uint8_t _hue_countdown = 30;
uint32_t flash_led(uint32_t next_trigger_time, void *cb_arg) {
    rgblight_sethsv(_hue_countdown * 5, 230, 70);
    _hue_countdown--;
    if (_hue_countdown == 0) {
        rgblight_setrgb(LAYER0);
        return 0;
    } else {
        return 50;
    }
}


void keyboard_post_init_user(void) {
    defer_exec(50, flash_led, NULL); // Flash a little on start using deferred execution
}


// Individual color for every layer
layer_state_t layer_state_set_user(layer_state_t state) {
    switch (get_highest_layer(state)) {
        case 0:
            rgblight_setrgb(LAYER0);
            break;
        case 1:
            rgblight_setrgb(LAYER1);
            break;
        case 2:
            rgblight_setrgb(LAYER2);
            break;
        case 3:
            rgblight_setrgb(LAYER3);
            break;
        case 4:
            rgblight_setrgb(LAYER4);
            break;
        case 5:
            rgblight_setrgb(LAYER5);
            break;
        default:
            rgblight_setrgb(DEFAULT); // Turn off if not in a known layer
            break;
    }
    return state;
}
