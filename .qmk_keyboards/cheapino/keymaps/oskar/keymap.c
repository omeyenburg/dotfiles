#include QMK_KEYBOARD_H
#include "keymap_german.h"
#include "quantum.h"

#define LAYER_SWITCH_TAPPING_TERM 200

enum custom_keycodes {
    K_SQBO = SAFE_RANGE, // Starting point of enum
    K_SQBC,
    K_CUBO,
    K_CUBC,
    K_DIAERESIS,
    K_PIPE,
    K_AT,
    K_TILDE,
    K_GRAVE,
    K_CARET,
    K_STAB,
    K_BSLSH,
    K_ESC,
    K_TAB,
    K_ENTER,
    K_OSM_LCTL,
    K_LAYER1,
    K_LAYER2,
};

void altgr_modifier(uint16_t keycode) {
    register_code(KC_RALT);
    tap_code(keycode);
    unregister_code(KC_RALT);
}

// Custom keycode handler
bool process_record_user(uint16_t keycode, keyrecord_t* record) {
    static uint16_t layer1_tap_timer;
    static uint16_t layer2_tap_timer;

    if (keycode == K_LAYER1) {
        if (record->event.pressed) {
            layer1_tap_timer = timer_read(); // Start the timer when key is pressed
            layer_on(1);                     // Momentarily activate layer 1 when key is held
        } else {
            layer_clear(); // Deactivate the layer when the key is released

            if (timer_elapsed(layer1_tap_timer) < LAYER_SWITCH_TAPPING_TERM) {
                layer_move(1); // Permanently switch when tapped
            }
        }
        return false;
    } else {
        layer1_tap_timer -= LAYER_SWITCH_TAPPING_TERM;
    }

    if (keycode == K_LAYER2) {
        if (record->event.pressed) {
            layer2_tap_timer = timer_read(); // Start the timer when key is pressed
            layer_on(2);                     // Momentarily activate layer 2 when key is held
        } else {
            layer_clear(); // Deactivate the layer when the key is released

            if (timer_elapsed(layer2_tap_timer) < LAYER_SWITCH_TAPPING_TERM) {
                layer_move(2); // Permanently switch when tapped
            }
        }
        return false;
    } else {
        layer2_tap_timer -= LAYER_SWITCH_TAPPING_TERM;
    }

    if (!record->event.pressed) {
        return true;
    }

    switch (keycode) {
        case K_SQBO: // "[" symbol
            altgr_modifier(KC_5);
            return false;
        case K_SQBC: // "]" symbol
            altgr_modifier(KC_6);
            return false;
        case K_CUBO: // "{" symbol
            altgr_modifier(KC_8);
            return false;
        case K_CUBC: // "}" symbol
            altgr_modifier(KC_9);
            return false;
        case K_DIAERESIS: // "¨" symbol
            altgr_modifier(KC_U);
            return false;
        case K_PIPE: // "|" symbol
            altgr_modifier(KC_7);
            return false;
        case K_AT: // "@" symbol
            altgr_modifier(KC_L);
            return false;
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
        case K_STAB: // Shift and Tab
            register_code(KC_LSFT);
            tap_code(KC_TAB);
            unregister_code(KC_LSFT);
            return false;
        case K_BSLSH: // "\" symbol
            register_code(KC_LSFT);
            altgr_modifier(KC_7);
            unregister_code(KC_LSFT);
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
        case LSFT_T(KC_NO): // Enable shift for next key press
            add_oneshot_mods(MOD_BIT(KC_LSFT));
            return false;
        case LCTL_T(KC_NO): // Enable control for next key press
            add_oneshot_mods(MOD_BIT(KC_LCTL));
            return false;
    }
    return true;
}

// Define the keymap using LAYOUT_split_3x5_3
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x5_3( // Letters
        KC_Q, KC_W, KC_F, KC_P, KC_G, KC_J, KC_L, KC_U, KC_Y,
        K_DIAERESIS, // a
        KC_A, KC_R, MT(MOD_LALT, KC_S), MT(MOD_LGUI, KC_T), KC_D, KC_H, MT(MOD_RGUI, KC_N), MT(MOD_RALT, KC_E), KC_I,
        KC_O, // b
        KC_Z, KC_X, KC_C, KC_V, KC_B, KC_K, KC_M, KC_DOT, KC_COMM,
        DE_SS, // c
        LSFT_T(KC_NO), KC_BSPC, K_LAYER1, K_LAYER2, KC_SPC,
        LCTL_T(KC_NO) // d
    ),
    [1] = LAYOUT_split_3x5_3( // Numbers and brackets
        KC_NO, K_SQBO, DE_LPRN, K_CUBO, DE_DQUO, DE_QUOT, K_CUBC, DE_RPRN, K_SQBC,
        KC_NO, // a
        KC_0, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8,
        KC_9, // b
        KC_NO, DE_MINS, DE_UNDS, K_STAB, KC_BSPC, KC_DEL, KC_TAB, DE_DOT, DE_COMM,
        KC_NO, // c
        TO(0), KC_BSPC, K_ESC, K_ENTER, KC_SPC,
        TO(3) // d
    ),
    [2] = LAYOUT_split_3x5_3( // Symbols
        KC_NO, DE_HASH, DE_DLR, DE_PERC, DE_AMPR, K_AT, K_TILDE, K_GRAVE, K_CARET,
        KC_NO, // a
        KC_NO, DE_PLUS, DE_ASTR, DE_EQL, DE_EXLM, DE_QUES, DE_SLSH, K_PIPE, K_BSLSH,
        KC_NO, // b
        KC_NO, DE_MINS, DE_UNDS, DE_LABK, DE_COLN, DE_SCLN, DE_RABK, DE_DOT, DE_COMM,
        KC_NO, // c
        TO(0), KC_BSPC, K_ESC, K_TAB, KC_SPC,
        TO(4) // d
    ),
    [3] = LAYOUT_split_3x5_3( // Mouse and Arrows
        KC_NO, KC_ACL0, KC_ACL1, KC_ACL2, KC_NO, KC_NO, KC_WH_L, KC_WH_D, KC_WH_U,
        KC_WH_R, // a
        KC_BTN1, KC_BTN2, KC_BTN3, KC_BTN4, KC_BTN5, KC_NO, KC_MS_L, KC_MS_D, KC_MS_U,
        KC_MS_R, // c
        KC_HOME, KC_END, KC_PGUP, KC_PGDN, KC_NO, KC_NO, KC_LEFT, KC_DOWN, KC_UP,
        KC_RIGHT, // b
        TO(0), KC_BSPC, K_ESC, TO(5), KC_SPC,
        TO(4) // d
    ),
    [4] = LAYOUT_split_3x5_3( // Function keys and media control
        KC_F1, KC_F2, KC_F3, KC_F4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO, // a
        KC_F5, KC_F6, KC_F7, KC_F8, KC_NO, KC_PSCR, KC_MPLY, KC_MSTP,
        KC_NO, // b
        KC_NO, KC_F9, KC_F10, KC_F11, KC_F12, KC_NO, KC_NO, KC_VOLU,
        KC_VOLD, // c
        KC_NO, KC_NO, TO(0), KC_BSPC, K_ESC, TO(5), KC_SPC,
        KC_NO // d
    ),
    [5] = LAYOUT_split_3x5_3( // Settings
        QK_RBT, KC_NO, KC_BRIU, GU_OFF, CG_SWAP, RGB_VAI, RGB_SAI, RGB_HUI, RGB_MOD,
        KC_NO, // a
        KC_NO, KC_NO, KC_BRID, GU_ON, CG_NORM, RGB_VAD, RGB_SAD, RGB_HUD, RGB_RMOD,
        RGB_TOG, // b
        KC_NO, KC_NO, KC_WHOM, KC_WBAK, KC_WFWD, RGB_M_P, RGB_M_B, RGB_M_R, RGB_M_SW,
        RGB_M_G, // c
        TO(0), KC_BSPC, K_ESC, KC_NO, KC_SPC,
        TO(4) // d
    )
};
