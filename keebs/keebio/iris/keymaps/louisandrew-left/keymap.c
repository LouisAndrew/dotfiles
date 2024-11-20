// clang-LSP related workaround: https://github.com/qmk/qmk_firmware/issues/23967#issuecomment-2198914598

#include "keycodes.h"
#include QMK_KEYBOARD_H

enum custom_layer {
    _MAIN,
    _LOWER,
    _RAISE,
    _ADJUST
};

#define LOWER MO(_LOWER)
#define RAISE MO(_RAISE)
#define ADJUST MO(_ADJUST)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
//    ┌──────┬───┬───┬───┬──────┬───────┐               ┌───────┬──────┬───┬───┬───┬──────┐
//    │ esc  │ 1 │ 2 │ 3 │  4   │   5   │               │   6   │  7   │ 8 │ 9 │ 0 │ bspc │
//    ├──────┼───┼───┼───┼──────┼───────┤               ├───────┼──────┼───┼───┼───┼──────┤
//    │ tab  │ q │ w │ e │  r   │   t   │               │   y   │  u   │ i │ o │ p │ del  │
//    ├──────┼───┼───┼───┼──────┼───────┤               ├───────┼──────┼───┼───┼───┼──────┤
//    │ lsft │ a │ s │ d │  f   │   g   │               │   h   │  j   │ k │ l │ ; │  '   │
//    ├──────┼───┼───┼───┼──────┼───────┼─────┐   ┌─────┼───────┼──────┼───┼───┼───┼──────┤
//    │ lctl │ z │ x │ c │  v   │   b   │ spc │   │ ent │   n   │  m   │ , │ . │ / │ rsft │
//    └──────┴───┴───┴───┼──────┼───────┼─────┤   ├─────┼───────┼──────┼───┴───┴───┴──────┘
//                       │ ralt │ LOWER │ spc │   │ ent │ RAISE │ lgui │
//                       └──────┴───────┴─────┘   └─────┴───────┴──────┘
[_MAIN] = LAYOUT(
  KC_ESC  , KC_1 , KC_2 , KC_3 , KC_4    , KC_5  ,                       KC_6  , KC_7    , KC_8    , KC_9   , KC_0    , KC_BSPC,
  KC_TAB  , KC_Q , KC_W , KC_E , KC_R    , KC_T  ,                       KC_Y  , KC_U    , KC_I    , KC_O   , KC_P    , KC_DEL ,
  KC_LSFT , KC_A , KC_S , KC_D , KC_F    , KC_G  ,                       KC_H  , KC_J    , KC_K    , KC_L   , KC_SCLN , KC_QUOT,
  KC_LCTL , KC_Z , KC_X , KC_C , KC_V    , KC_B  , KC_SPC ,     KC_ENT , KC_N  , KC_M    , KC_COMM , KC_DOT , KC_SLSH , KC_RSFT,
                                 KC_LALT , LOWER , KC_SPC ,     KC_ENT , RAISE , KC_LGUI
),

//    ┌─────────┬─────┬──────┬─────┬──────┬────────┐                ┌────────┬──────┬──────┬──────┬──────┬──────┐
//    │ QK_BOOT │ f1  │  f2  │ f3  │  f4  │   f5   │                │   f6   │  f7  │  f8  │  f9  │ f10  │ caps │
//    ├─────────┼─────┼──────┼─────┼──────┼────────┤                ├────────┼──────┼──────┼──────┼──────┼──────┤
//    │    `    │  1  │  2   │  3  │  4   │   5    │                │   6    │  7   │  8   │  9   │  0   │  \   │
//    ├─────────┼─────┼──────┼─────┼──────┼────────┤                ├────────┼──────┼──────┼──────┼──────┼──────┤
//    │  lsft   │  [  │ left │  ]  │  up  │   [    │                │  left  │ down │  up  │ rght │  -   │  =   │
//    ├─────────┼─────┼──────┼─────┼──────┼────────┼──────┐   ┌─────┼────────┼──────┼──────┼──────┼──────┼──────┤
//    │  lctl   │     │      │     │ down │  lalt  │ S(]) │   │ spc │  kp_1  │ kp_2 │ kp_3 │  -   │ rsft │ rsft │
//    └─────────┴─────┴──────┴─────┼──────┼────────┼──────┤   ├─────┼────────┼──────┼──────┴──────┴──────┴──────┘
//                                 │ lgui │ ADJUST │ S(0) │   │ spc │ ADJUST │ kp_0 │
//                                 └──────┴────────┴──────┘   └─────┴────────┴──────┘
[_LOWER] = LAYOUT(
  QK_BOOT , KC_F1   , KC_F2   , KC_F3   , KC_F4   , KC_F5   ,                           KC_F6   , KC_F7   , KC_F8 , KC_F9   , KC_F10  , KC_CAPS,
  KC_GRV  , KC_1    , KC_2    , KC_3    , KC_4    , KC_5    ,                           KC_6    , KC_7    , KC_8  , KC_9    , KC_0    , KC_BSLS,
  KC_LSFT , KC_LBRC , KC_LEFT , KC_RBRC , KC_UP   , KC_LBRC ,                           KC_LEFT , KC_DOWN , KC_UP , KC_RGHT , KC_MINS , KC_EQL ,
  KC_LCTL , KC_TRNS , KC_TRNS , KC_TRNS , KC_DOWN , KC_LALT , S(KC_RBRC) ,     KC_SPC , KC_P1   , KC_P2   , KC_P3 , KC_MINS , KC_MINS , KC_RSFT,
                                          KC_LGUI , ADJUST  , S(KC_0)    ,     KC_SPC , ADJUST  , KC_P0
),

//    ┌─────────┬─────┬──────┬─────┬──────┬────────┐                ┌────────┬──────┬──────┬──────┬──────┬──────┐
//    │ QK_BOOT │ f1  │  f2  │ f3  │  f4  │   f5   │                │   f6   │  f7  │  f8  │  f9  │ f10  │ caps │
//    ├─────────┼─────┼──────┼─────┼──────┼────────┤                ├────────┼──────┼──────┼──────┼──────┼──────┤
//    │    `    │  1  │  2   │  3  │  4   │   5    │                │   6    │  7   │  8   │  9   │  0   │  \   │
//    ├─────────┼─────┼──────┼─────┼──────┼────────┤                ├────────┼──────┼──────┼──────┼──────┼──────┤
//    │  lsft   │  [  │ left │  ]  │  up  │   [    │                │  left  │ down │  up  │ rght │  -   │  =   │
//    ├─────────┼─────┼──────┼─────┼──────┼────────┼──────┐   ┌─────┼────────┼──────┼──────┼──────┼──────┼──────┤
//    │  lctl   │     │      │     │ down │  lalt  │ S(]) │   │ spc │  kp_1  │ kp_2 │ kp_3 │  -   │ rsft │ rsft │
//    └─────────┴─────┴──────┴─────┼──────┼────────┼──────┤   ├─────┼────────┼──────┼──────┴──────┴──────┴──────┘
//                                 │ lgui │ ADJUST │ S(0) │   │ spc │ ADJUST │ kp_0 │
//                                 └──────┴────────┴──────┘   └─────┴────────┴──────┘
[_RAISE] = LAYOUT(
  QK_BOOT , KC_F1   , KC_F2   , KC_F3   , KC_F4   , KC_F5   ,                           KC_F6   , KC_F7   , KC_F8 , KC_F9   , KC_F10  , KC_CAPS,
  KC_GRV  , KC_1    , KC_2    , KC_3    , KC_4    , KC_5    ,                           KC_6    , KC_7    , KC_8  , KC_9    , KC_0    , KC_BSLS,
  KC_LSFT , KC_LBRC , KC_LEFT , KC_RBRC , KC_UP   , KC_LBRC ,                           KC_LEFT , KC_DOWN , KC_UP , KC_RGHT , KC_MINS , KC_EQL ,
  KC_LCTL , KC_TRNS , KC_TRNS , KC_TRNS , KC_DOWN , KC_LALT , S(KC_RBRC) ,     KC_SPC , KC_P1   , KC_P2   , KC_P3 , KC_MINS , KC_RSFT , KC_RSFT,
                                          KC_LGUI , ADJUST  , S(KC_0)    ,     KC_SPC , ADJUST  , KC_P0
),

//    ┌─────────┬──────┬──────┬──────┬──────┬─────┐               ┌─────┬──────┬─────────┬─────────┬─────────┬─────┐
//    │   f12   │  f1  │  f2  │  f3  │  f4  │ f5  │               │ f6  │  f7  │   f8    │   f9    │   f10   │ f11 │
//    ├─────────┼──────┼──────┼──────┼──────┼─────┤               ├─────┼──────┼─────────┼─────────┼─────────┼─────┤
//    │ RGB_TOG │  !   │  @   │  #   │  $   │  %  │               │  ^  │  &   │    *    │    (    │    )    │     │
//    ├─────────┼──────┼──────┼──────┼──────┼─────┤               ├─────┼──────┼─────────┼─────────┼─────────┼─────┤
//    │ RGB_MOD │ mprv │ mnxt │ volu │ pgup │  _  │               │  =  │ home │ RGB_HUI │ RGB_SAI │ RGB_VAI │  \  │
//    ├─────────┼──────┼──────┼──────┼──────┼─────┼─────┐   ┌─────┼─────┼──────┼─────────┼─────────┼─────────┼─────┤
//    │  mute   │ mstp │ mply │ vold │ pgdn │  -  │  (  │   │     │  +  │ end  │ RGB_HUD │ RGB_SAD │ RGB_VAD │     │
//    └─────────┴──────┴──────┴──────┼──────┼─────┼─────┤   ├─────┼─────┼──────┼─────────┴─────────┴─────────┴─────┘
//                                   │      │     │     │   │     │     │      │
//                                   └──────┴─────┴─────┘   └─────┴─────┴──────┘
[_ADJUST] = LAYOUT(
  KC_F12  , KC_F1   , KC_F2   , KC_F3   , KC_F4   , KC_F5   ,                         KC_F6   , KC_F7   , KC_F8   , KC_F9   , KC_F10  , KC_F11 ,
  RGB_TOG , KC_EXLM , KC_AT   , KC_HASH , KC_DLR  , KC_PERC ,                         KC_CIRC , KC_AMPR , KC_ASTR , KC_LPRN , KC_RPRN , _______,
  RGB_MOD , KC_MPRV , KC_MNXT , KC_VOLU , KC_PGUP , KC_UNDS ,                         KC_EQL  , KC_HOME , RGB_HUI , RGB_SAI , RGB_VAI , KC_BSLS,
  KC_MUTE , KC_MSTP , KC_MPLY , KC_VOLD , KC_PGDN , KC_MINS , KC_LPRN ,     _______ , KC_PLUS , KC_END  , RGB_HUD , RGB_SAD , RGB_VAD , _______,
                                          _______ , _______ , _______ ,     _______ , _______ , _______
)
};

