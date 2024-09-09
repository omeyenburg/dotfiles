#include "matrix.h"
#include "quantum.h"

#define COL_SHIFTER ((uint16_t)1)

#define ENC_ROW 3
#define ENC_A_COL 2
#define ENC_B_COL 4
#define ENC_BUTTON_COL 0

static bool colABPressed   = false;
static bool encoderPressed = false;

void clicked(int layer) {
    switch (layer) {
        case 4:
            tap_code(KC_MUTE);
            break;
        default:
            tap_code(KC_MPLY);
    }
}

void turned(int layer, bool clockwise) {
    switch (layer) {
        case 1:
            tap_code16(clockwise ? LCTL(KC_TAB) : LCTL(LSFT(KC_TAB)));
            break;
        case 3:
            tap_code16(clockwise ? KC_WH_U : KC_WH_D);
            break;
        case 4:
            tap_code(clockwise ? KC_VOLU : KC_VOLD);
            break;
        case 5:
            tap_code(clockwise ? KC_BRIU : KC_BRID);
            break;
        default:
            tap_code16(clockwise ? KC_PGDN : KC_PGUP);
    }
}

void fix_encoder_action(matrix_row_t current_matrix[]) {
    matrix_row_t encoder_row = current_matrix[ENC_ROW];

    int layer;
    if (IS_LAYER_ON(0)) {
        layer = 0;
    } else if (IS_LAYER_ON(1)) {
        layer = 1;
    } else if (IS_LAYER_ON(2)) {
        layer = 2;
    } else if (IS_LAYER_ON(3)) {
        layer = 3;
    } else if (IS_LAYER_ON(4)) {
        layer = 4;
    } else if (IS_LAYER_ON(5)) {
        layer = 5;
    } else if (IS_LAYER_ON(6)) {
        layer = 6;
    } else if (IS_LAYER_ON(7)) {
        layer = 7;
    } else if (IS_LAYER_ON(8)) {
        layer = 8;
    } else {
        layer = 0;
    }

    if (encoder_row & (COL_SHIFTER << ENC_BUTTON_COL)) {
        encoderPressed = true;
    } else if (encoderPressed) {
        encoderPressed = false;
        clicked(layer);
    }

    // Check which way the encoder is turned:
    bool colA = encoder_row & (COL_SHIFTER << ENC_A_COL);
    bool colB = encoder_row & (COL_SHIFTER << ENC_B_COL);

    if (colA && colB) {
        colABPressed = true;
    } else if (colA) {
        if (colABPressed) { // A+B followed by A means clockwise
            colABPressed = false;
            turned(layer, true);
        }
    } else if (colB) {
        if (colABPressed) { // A+B followed by B means counter-clockwise
            colABPressed = false;
            turned(layer, false);
        }
    }
    current_matrix[ENC_ROW] = 0;
}
