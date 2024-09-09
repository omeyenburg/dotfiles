#include QMK_KEYBOARD_H
#include "quantum.h"
#include "keymap_german.h"

enum custom_keycodes {
    KEY_SQUARE_OPEN = SAFE_RANGE, // Starting point of enum
    KEY_SQUARE_CLOSE,
    KEY_CURLY_OPEN,
    KEY_CURLY_CLOSE,
    KEY_DIAERESIS,
    KEY_PIPE,
    KEY_AT,
    KEY_TILDE,
    KEY_GRAVE,
    KEY_CARET,
    KEY_SHIFT_TAB,
    KEY_BACK_SLASH,
};

void altgr_modifier(uint16_t keycode) {
    register_code(KC_RALT);
    tap_code(keycode);
    unregister_code(KC_RALT);
}

// Custom keycode handler
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (!record->event.pressed) {
        return true;
    }

    switch (keycode) {
        case KEY_SQUARE_OPEN: // "[" symbol
            altgr_modifier(KC_5);
            return false;
        case KEY_SQUARE_CLOSE: // "]" symbol
            altgr_modifier(KC_6);
            return false;
        case KEY_CURLY_OPEN: // "{" symbol
            altgr_modifier(KC_8);
            return false;
        case KEY_CURLY_CLOSE: // "}" symbol
            altgr_modifier(KC_9);
            return false;
        case KEY_DIAERESIS: // "¨" symbol
            altgr_modifier(KC_U);
            return false;
        case KEY_PIPE: // "|" symbol
            altgr_modifier(KC_7);
            return false;
        case KEY_AT: // "@" symbol
            altgr_modifier(KC_L);
            return false;
        case KEY_TILDE: // "~" symbol
            altgr_modifier(KC_N);
            tap_code(KC_ESC);
            return false;
        case KEY_GRAVE: // "`" symbol
            tap_code(DE_ACUT);
            tap_code(KC_ESC);
            return false;
        case KEY_CARET: // "^" symbol
            tap_code(DE_CIRC);
            tap_code(KC_ESC);
            return false;
        case KEY_SHIFT_TAB: // Shift and Tab
            register_code(KC_LSFT);
            tap_code(KC_TAB);
            unregister_code(KC_LSFT);
        case KEY_BACK_SLASH: // "\" symbol
            register_code(KC_LSFT);
            altgr_modifier(KC_7);
            unregister_code(KC_LSFT);
    }
    return true;
}


// Define the keymap using LAYOUT_split_3x5_3
    const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x5_3( // Letters
        KC_Q, KC_W, KC_F, KC_P, KC_G, KC_J, KC_L, KC_U, KC_Y, KEY_DIAERESIS,
        KC_A, KC_R, MT(MOD_LALT, KC_S), MT(MOD_LGUI, KC_T), KC_D, KC_H, MT(MOD_RGUI, KC_N), MT(MOD_RALT, KC_E), KC_I, KC_O,
        KC_Z, KC_X, KC_C, KC_V, KC_B, KC_K, KC_M, KC_DOT, KC_COMM, DE_SS,
        KC_LSFT, KC_BSPC, TO(1), TO(2), KC_SPC, LCTL_T(OSM(MOD_LCTL))
    ),
    [1] = LAYOUT_split_3x5_3( // Numbers and brackets
        KC_NO, KEY_SQUARE_OPEN, DE_LPRN, KEY_CURLY_OPEN, DE_DQUO, DE_QUOT, KEY_CURLY_CLOSE, DE_RPRN, KEY_SQUARE_CLOSE, KC_NO,
        KC_0, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9,
        KC_NO, DE_MINS, DE_UNDS, KEY_SHIFT_TAB, KC_BSPC, KC_DEL, KC_TAB, DE_DOT, DE_COMM, KC_NO,
        TO(0), KC_BSPC, KC_ESC, KC_ENTER, KC_SPC, TO(3)
    ),
    [2] = LAYOUT_split_3x5_3( // Symbols
        KC_NO, DE_HASH, DE_DLR, DE_PERC, DE_AMPR, KEY_AT, KEY_CARET, KEY_GRAVE, KEY_TILDE, KC_NO,
        KC_NO, DE_PLUS, DE_ASTR, DE_EQL, DE_EXLM, DE_QUES, DE_SLSH, KEY_PIPE, KEY_BACK_SLASH, KC_NO,
        KC_NO, DE_MINS, DE_UNDS, DE_LABK, DE_COLN, DE_SCLN, DE_RABK, DE_DOT, DE_COMM, KC_NO,
        TO(0), KC_BSPC, KC_ESC, KC_TAB, KC_SPC, TO(4)
    ),
    [3] = LAYOUT_split_3x5_3( // Mouse and Arrows
        KC_NO, KC_ACL0, KC_ACL1, KC_ACL2, KC_NO, KC_NO, KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R,
        KC_BTN1, KC_BTN2, KC_BTN3, KC_BTN4, KC_BTN5, KC_NO, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R,
        KC_HOME, KC_END, KC_PGUP, KC_PGDN, KC_NO, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT,
        TO(0), KC_BSPC, KC_ESC, TO(5), KC_SPC, TO(4)
    ),
    [4] = LAYOUT_split_3x5_3( // Function keys and media control
        KC_F1, KC_F2, KC_F3, KC_F4, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_F5, KC_F6, KC_F7, KC_F8, KC_NO, KC_PSCR, KC_MPLY, KC_MSTP, KC_NO, KC_NO,
        KC_F9, KC_F10, KC_F11, KC_F12, KC_NO, KC_NO, KC_VOLU, KC_VOLD, KC_NO, KC_NO,
        TO(0), KC_BSPC, KC_ESC, TO(5), KC_SPC, KC_NO
    ),
    [5] = LAYOUT_split_3x5_3( // Settings
        QK_RBT, KC_NO, KC_BRIU, GU_OFF, CG_SWAP, RGB_VAI, RGB_SAI, RGB_HUI, RGB_MOD, KC_NO,
        KC_NO, KC_NO, KC_BRID, GU_ON, CG_NORM, RGB_VAD, RGB_SAD, RGB_HUD, RGB_RMOD, RGB_TOG,
        KC_NO, KC_NO, KC_WHOM, KC_WBAK, KC_WFWD, RGB_M_P, RGB_M_B, RGB_M_R, RGB_M_SW, RGB_M_G,
        TO(0), KC_BSPC, KC_ESC, KC_NO, KC_SPC, TO(4)
    )
};
