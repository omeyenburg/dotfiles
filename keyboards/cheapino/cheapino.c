#include "quantum.h"
#include "wait.h"

#define LAYER0 0, 20, 0
#define LAYER1 20, 0, 0
#define LAYER2 0, 0, 20
#define LAYER3 20, 20, 0
#define LAYER4 0, 20, 20
#define LAYER5 20, 0, 20
#define LAYER6 5, 15, 5
#define LAYER7 15, 5, 5
#define DEFAULT 0, 0, 0
#define SHIFT_ONESHOT 30, 10, 0

// This is to keep state between callbacks, when it is 0 the initial RGB flash is finished
uint8_t _hue_countdown = 30;
uint32_t flash_led(uint32_t next_trigger_time, void* cb_arg) {
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

bool shift_oneshot = false;
void oneshot_mods_changed_user(uint8_t mods) {
    if (mods & MOD_MASK_SHIFT) {
        if (!shift_oneshot) {
            shift_oneshot = true;
        }
    } else if (shift_oneshot) {
        shift_oneshot = false;
    }
    layer_state_set_user(layer_state);
}

// Individual color for every layer
layer_state_t layer_state_set_user(layer_state_t state) {
    if (shift_oneshot) {
        rgblight_setrgb(SHIFT_ONESHOT);
        return state;
    }

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
        case 6:
            rgblight_setrgb(LAYER6);
            break;
        case 7:
            rgblight_setrgb(LAYER7);
            break;
        default:
            rgblight_setrgb(DEFAULT);
            break;
    }
    return state;
}
