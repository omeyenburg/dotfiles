#include QMK_KEYBOARD_H
#include "keymap_german.h"
#include "quantum.h"

#define LAYER_SWITCH_TAPPING_TERM 200

enum custom_keycodes {
    K_TILDE = SAFE_RANGE, // Starting point of enum
    K_GRAVE,
    K_CARET,
    K_ESC,
    K_OSM_LCTL,
    K_LAYER1,
    K_LAYER2,
    K_CTRL,
};

enum {
    TD_SHIFT_CAPS = 0,
    TD_ENTER_TAB,
};

void shift_dance_finished_fn(tap_dance_state_t* state, void* _) {
    if (state->count >= 2) {
        tap_code(KC_CAPS);
    } else if (state->pressed) {
        register_code(KC_LSFT);
    } else {
        add_oneshot_mods(MOD_BIT(KC_LSFT));
    }
}

void shift_dance_reset_fn(tap_dance_state_t* state, void* _) {
    unregister_code(KC_LSFT);
}

tap_dance_action_t tap_dance_actions[] = {
    [TD_SHIFT_CAPS] = ACTION_TAP_DANCE_FN_ADVANCED_WITH_RELEASE(NULL, NULL, shift_dance_finished_fn, shift_dance_reset_fn),
    [TD_ENTER_TAB] = ACTION_TAP_DANCE_DOUBLE(KC_ENTER, KC_TAB),
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
    }
    return true;
}

// Define the keymap using LAYOUT_split_3x5_3
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x5_3(                                                                                                                            // Colemak letters
        KC_Q, KC_W, KC_F, KC_P, KC_G, KC_J, KC_L, KC_U, KC_Y, DE_COLN,                                                                                   // first row
        KC_A, KC_R, KC_S, KC_T, KC_D, KC_H, KC_N, KC_E, KC_I, KC_O,                                                                                      // second row
        KC_Z, KC_X, KC_C, KC_V, KC_B, KC_K, KC_M, MT(MOD_LGUI, KC_DOT), MT(MOD_RALT, KC_COMM), DE_SCLN,                                                  // third row
        TD(TD_SHIFT_CAPS), KC_BSPC, K_CTRL, TD(TD_ENTER_TAB), KC_SPC, K_LAYER1                                                                           // thumb keys
    ),                                                                                                                                                   //
    [1] = LAYOUT_split_3x5_3(                                                                                                                            // Numbers and brackets
        RALT(KC_L), RSA(KC_7), RALT(KC_7), DE_SLSH, RALT(KC_8), RALT(KC_9), KC_1, KC_2, KC_3, DE_DOT,                                                    // first row
        MT(MOD_LSFT, DE_ASTR), MT(MOD_RALT, DE_PLUS), MT(MOD_LGUI, DE_MINS), MT(MOD_LCTL, DE_UNDS), DE_LPRN, DE_RPRN, KC_4, KC_5, KC_6, KC_0,            // second row
        DE_HASH, K_GRAVE, DE_QUOT, DE_DQUO, RALT(KC_5), RALT(KC_6), KC_7, KC_8, KC_9, DE_COMM,                                                           // third row
        TO(0), KC_BSPC, KC_DEL, TD(TD_ENTER_TAB), KC_SPC, TO(2)                                                                                          // thumb keys
    ),                                                                                                                                                   //
    [2] = LAYOUT_split_3x5_3(                                                                                                                            // Symbols
        RALT(KC_L), RSA(KC_7), RALT(KC_7), DE_SLSH, DE_EQL, DE_PERC, K_CARET, DE_DLR, K_TILDE, RALT(KC_U),                                               // first row
        MT(MOD_LSFT, DE_ASTR), MT(MOD_RALT, DE_PLUS), MT(MOD_LGUI, DE_MINS), MT(MOD_LCTL, DE_UNDS), DE_LABK, DE_RABK, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, // second row
        DE_HASH, K_GRAVE, DE_QUOT, DE_DQUO, DE_EXLM, DE_QUES, DE_AMPR, DE_DOT, DE_COMM, DE_SS,                                                           // third row
        TO(0), KC_BSPC, KC_DEL, TD(TD_ENTER_TAB), KC_SPC, TO(3)                                                                                          // thumb keys
    ),                                                                                                                                                   //
    [3] = LAYOUT_split_3x5_3(                                                                                                                            // Mouse and Arrows
        KC_NO, KC_ACL0, KC_ACL1, KC_ACL2, KC_NO, KC_NO, KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R,                                                              // first row
        KC_BTN1, KC_BTN2, KC_BTN3, KC_BTN4, KC_BTN5, KC_NO, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R,                                                          // third row
        KC_HOME, KC_END, KC_PGUP, KC_PGDN, KC_NO, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT,                                                              // second row
        TO(0), KC_NO, KC_NO, KC_NO, KC_NO, TO(4)                                                                                                         // thumb keys
    ),                                                                                                                                                   //
    [4] = LAYOUT_split_3x5_3(                                                                                                                            // Function keys and media control
        KC_F1, KC_F2, KC_F3, KC_F4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,                                                                            // first row
        KC_F5, KC_F6, KC_F7, KC_F8, KC_NO, KC_PSCR, KC_MPLY, KC_MSTP, KC_NO, KC_NO,                                                                      // second row
        KC_F9, KC_F10, KC_F11, KC_F12, KC_NO, KC_NO, KC_VOLU, KC_VOLD, KC_NO, KC_NO,                                                                     // third row
        TO(0), KC_NO, KC_NO, KC_NO, KC_NO, TO(5)                                                                                                         // thumb keys
    ),                                                                                                                                                   //
    [5] = LAYOUT_split_3x5_3(                                                                                                                            // Settings
        QK_RBT, KC_NO, KC_BRIU, GU_OFF, CG_SWAP, RGB_VAI, RGB_SAI, RGB_HUI, RGB_MOD, KC_NO,                                                              // first row
        KC_NO, KC_NO, KC_BRID, GU_ON, CG_NORM, RGB_VAD, RGB_SAD, RGB_HUD, RGB_RMOD, RGB_TOG,                                                             // second row
        KC_NO, KC_NO, KC_WHOM, KC_WBAK, KC_WFWD, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,                                                                      // third row
        TO(0), TO(6), KC_NO, KC_NO, KC_NO, KC_NO                                                                                                         // thumb keys
    ),                                                                                                                                                   //
    [6] = LAYOUT_split_3x5_3(                                                                                                                            // QWERTY letters
        KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P,                                                                                      // first row
        KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, RALT(KC_U),                                                                                // second row
        KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, MT(MOD_LGUI, KC_DOT), MT(MOD_RALT, KC_COMM), DE_SS,                                                    // third row
        TD(TD_SHIFT_CAPS), KC_BSPC, K_CTRL, TD(TD_ENTER_TAB), KC_SPC, TO(7)                                                                              // thumb keys
    ),                                                                                                                                                   //
    [7] = LAYOUT_split_3x5_3(                                                                                                                            // Numbers and brackets
        RALT(KC_L), RSA(KC_7), RALT(KC_7), DE_SLSH, RALT(KC_8), RALT(KC_9), KC_1, KC_2, KC_3, DE_DOT,                                                    // first row
        MT(MOD_LSFT, DE_ASTR), MT(MOD_RALT, DE_PLUS), MT(MOD_LGUI, DE_MINS), MT(MOD_LCTL, DE_UNDS), DE_LPRN, DE_RPRN, KC_4, KC_5, KC_6, KC_0,            // second row
        DE_HASH, K_GRAVE, DE_QUOT, DE_DQUO, RALT(KC_5), RALT(KC_6), KC_7, KC_8, KC_9, DE_COMM,                                                           // third row
        TO(6), KC_BSPC, KC_DEL, TD(TD_ENTER_TAB), KC_SPC, TO(0)                                                                                          // thumb keys
    ),
};
