#include QMK_KEYBOARD_H
#include "keymap_german.h"
#include "quantum.h"

#define LAYER_SWITCH_TAPPING_TERM 200

enum custom_keycodes {
    K_TILDE = SAFE_RANGE, // Starting point of enum
    K_GRAVE,
    K_CARET,
    K_ESC,
    K_TAB,
    K_ENTER,
    K_OSM_LCTL,
    K_LAYER1,
    K_LAYER2,
    K_SHIFT,
    K_CTRL,
};

void altgr_modifier(uint16_t keycode) {
    register_code(KC_RALT);
    tap_code(keycode);
    unregister_code(KC_RALT);
}

// Custom keycode handler
bool process_record_user(uint16_t keycode, keyrecord_t* record) {
    // Switch to layer when tapped, momentarily switch to layer when held
    static uint16_t k_layer1_timer;
    if (keycode == K_LAYER1) {
        if (record->event.pressed) {
            k_layer1_timer = timer_read(); // Start the timer when key is pressed
            layer_on(1);
        } else {
            layer_clear();

            if (timer_elapsed(k_layer1_timer) < LAYER_SWITCH_TAPPING_TERM) {
                layer_move(1);
            }
        }
        return false;
    } else {
        k_layer1_timer -= LAYER_SWITCH_TAPPING_TERM;
    }

    // Switch to layer when tapped, momentarily switch to layer when held
    static uint16_t k_layer2_timer;
    if (keycode == K_LAYER2) {
        if (record->event.pressed) {
            k_layer2_timer = timer_read(); // Start the timer when key is pressed
            layer_on(2);
        } else {
            layer_clear();

            if (timer_elapsed(k_layer2_timer) < LAYER_SWITCH_TAPPING_TERM) {
                layer_move(2);
            }
        }
        return false;
    } else {
        k_layer2_timer -= LAYER_SWITCH_TAPPING_TERM;
    }

    // Shift when held, shift for next input when tapped
    static uint16_t k_shift_timer;
    if (keycode == K_SHIFT) {
        if (record->event.pressed) {
            k_shift_timer = timer_read(); // Start the timer when key is pressed
            register_code(KC_LSFT);
        } else {
            unregister_code(KC_LSFT);

            if (timer_elapsed(k_shift_timer) < LAYER_SWITCH_TAPPING_TERM) {
                add_oneshot_mods(MOD_BIT(KC_LSFT));
            }
        }
        return false;
    } else {
        k_shift_timer -= LAYER_SWITCH_TAPPING_TERM;
    }

    // Control when held, control for next input when tapped
    static uint16_t k_ctrl_timer;
    if (keycode == K_CTRL) {
        if (record->event.pressed) {
            k_ctrl_timer = timer_read(); // Start the timer when key is pressed
            register_code(KC_LCTL);
        } else {
            unregister_code(KC_LCTL);

            if (timer_elapsed(k_ctrl_timer) < LAYER_SWITCH_TAPPING_TERM) {
                add_oneshot_mods(MOD_BIT(KC_LCTL));
            }
        }
        return false;
    } else {
        k_ctrl_timer -= LAYER_SWITCH_TAPPING_TERM;
    }

    if (!record->event.pressed)
        return true;

    switch (keycode) {
        case K_TILDE: // "~" symbol
            altgr_modifier(KC_N);
            tap_code(KC_SPC);
            return false;
        case K_GRAVE: // "`" symbol
            register_code(KC_LSFT);
            tap_code(DE_ACUT);
            unregister_code(KC_LSFT);
            tap_code(KC_SPC);
            return false;
        case K_CARET: // "^" symbol
            tap_code(DE_CIRC);
            tap_code(KC_SPC);
            return false;
        case K_ESC: // ESC and return to base layer
            tap_code(KC_ESC);
            layer_clear();
            layer_on(0);
            return false;
        case K_TAB: // TAB and return to base layer
            tap_code(KC_TAB);
            layer_clear();
            return false;
        case K_ENTER: // ENTER and return to base layer
            tap_code(KC_ENTER);
            layer_clear();
            layer_on(0);
            return false;
    }
    return true;
}

// Define the keymap using LAYOUT_split_3x5_3
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x5_3(                                                                                               // Letters
        KC_Q, KC_W, KC_F, KC_P, KC_G, KC_J, KC_L, KC_U, KC_Y, RALT(KC_U),                                                   // first row
        KC_A, KC_R, MT(MOD_RALT, KC_S), MT(MOD_LGUI, KC_T), KC_D, KC_H, MT(MOD_RGUI, KC_N), MT(MOD_RALT, KC_E), KC_I, KC_O, // second row
        KC_Z, KC_X, KC_C, KC_V, KC_B, KC_K, KC_M, KC_DOT, KC_COMM, DE_SS,                                                   // third row
        K_SHIFT, KC_BSPC, K_LAYER1, K_LAYER2, KC_SPC, K_CTRL                                                                // thumb keys
    ),
    [1] = LAYOUT_split_3x5_3(                                                                             // Numbers and brackets
        KC_NO, RALT(KC_5), DE_LPRN, RALT(KC_8), DE_DQUO, DE_QUOT, RALT(KC_9), DE_RPRN, RALT(KC_6), KC_NO, // first row
        KC_0, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9,                                       // second row
        KC_NO, DE_MINS, DE_UNDS, LSFT(KC_TAB), KC_BSPC, KC_DEL, KC_TAB, DE_DOT, DE_COMM, KC_NO,           // third row
        TO(0), KC_BSPC, K_ESC, K_ENTER, KC_SPC, TO(3)                                                     // thumb keys
    ),
    [2] = LAYOUT_split_3x5_3(                                                                     // Symbols
        KC_NO, DE_HASH, DE_DLR, DE_PERC, DE_AMPR, RALT(KC_N), K_TILDE, K_GRAVE, K_CARET, KC_NO,   // first row
        KC_NO, DE_PLUS, DE_ASTR, DE_EQL, DE_EXLM, DE_QUES, DE_SLSH, RALT(KC_7), RSA(KC_7), KC_NO, // second row
        KC_NO, DE_MINS, DE_UNDS, DE_LABK, DE_COLN, DE_SCLN, DE_RABK, DE_DOT, DE_COMM, KC_NO,      // third row
        TO(0), KC_BSPC, K_ESC, K_TAB, KC_SPC, TO(4)                                               // thumb keys
    ),
    [3] = LAYOUT_split_3x5_3(                                                                   // Mouse and Arrows
        KC_NO, KC_ACL0, KC_ACL1, KC_ACL2, KC_NO, KC_NO, KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R,     // first row
        KC_BTN1, KC_BTN2, KC_BTN3, KC_BTN4, KC_BTN5, KC_NO, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, // third row
        KC_HOME, KC_END, KC_PGUP, KC_PGDN, KC_NO, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT,     // second row
        TO(0), KC_BSPC, K_ESC, TO(5), KC_SPC, TO(4)                                             // thumb keys
    ),
    [4] = LAYOUT_split_3x5_3(                                                 // Function keys and media control
        KC_F1, KC_F2, KC_F3, KC_F4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, // first row
        KC_F5, KC_F6, KC_F7, KC_F8, KC_NO, KC_PSCR, KC_MPLY, KC_MSTP, KC_NO,  // second row
        KC_NO, KC_F9, KC_F10, KC_F11, KC_F12, KC_NO, KC_NO, KC_VOLU, KC_VOLD, // third row
        KC_NO, KC_NO, TO(0), KC_BSPC, K_ESC, TO(5), KC_SPC, KC_NO             // thumb keys
    ),
    [5] = LAYOUT_split_3x5_3(                                                                  // Settings
        QK_RBT, KC_NO, KC_BRIU, GU_OFF, CG_SWAP, RGB_VAI, RGB_SAI, RGB_HUI, RGB_MOD, KC_NO,    // first row
        KC_NO, KC_NO, KC_BRID, GU_ON, CG_NORM, RGB_VAD, RGB_SAD, RGB_HUD, RGB_RMOD, RGB_TOG,   // second row
        KC_NO, KC_NO, KC_WHOM, KC_WBAK, KC_WFWD, RGB_M_P, RGB_M_B, RGB_M_R, RGB_M_SW, RGB_M_G, // third row
        TO(0), KC_BSPC, K_ESC, KC_NO, KC_SPC, TO(4)                                            // thumb keys
    )
};
