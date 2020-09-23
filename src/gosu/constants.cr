module Gosu
  enum ButtonName : UInt32
    KB_RANGE_BEGIN
    KB_ESCAPE          =   41
    KB_F1              =   58
    KB_F2              =   59
    KB_F3              =   60
    KB_F4              =   61
    KB_F5              =   62
    KB_F6              =   63
    KB_F7              =   64
    KB_F8              =   65
    KB_F9              =   66
    KB_F10             =   67
    KB_F11             =   68
    KB_F12             =   69
    KB_0               =   39
    KB_1               =   30
    KB_2               =   31
    KB_3               =   32
    KB_4               =   33
    KB_5               =   34
    KB_6               =   35
    KB_7               =   36
    KB_8               =   37
    KB_9               =   38
    KB_TAB             =   43
    KB_RETURN          =   40
    KB_SPACE           =   44
    KB_LEFT_SHIFT      =  225
    KB_RIGHT_SHIFT     =  229
    KB_LEFT_CONTROL    =  224
    KB_RIGHT_CONTROL   =  228
    KB_LEFT_ALT        =  226
    KB_RIGHT_ALT       =  230
    KB_LEFT_META       =  227
    KB_RIGHT_META      =  231
    KB_BACKSPACE       =   42
    KB_LEFT            =   80
    KB_RIGHT           =   79
    KB_UP              =   82
    KB_DOWN            =   81
    KB_HOME            =   74
    KB_END             =   77
    KB_INSERT          =   73
    KB_DELETE          =   76
    KB_PAGE_UP         =   75
    KB_PAGE_DOWN       =   78
    KB_ENTER           =   88
    KB_BACKTICK        =   53
    KB_MINUS           =   45
    KB_EQUALS          =   46
    KB_LEFT_BRACKET    =   47
    KB_RIGHT_BRACKET   =   48
    KB_BACKSLASH       =   49
    KB_SEMICOLON       =   51
    KB_APOSTROPHE      =   52
    KB_COMMA           =   54
    KB_PERIOD          =   55
    KB_SLASH           =   56
    KB_A               =    4
    KB_B               =    5
    KB_C               =    6
    KB_D               =    7
    KB_E               =    8
    KB_F               =    9
    KB_G               =   10
    KB_H               =   11
    KB_I               =   12
    KB_J               =   13
    KB_K               =   14
    KB_L               =   15
    KB_M               =   16
    KB_N               =   17
    KB_O               =   18
    KB_P               =   19
    KB_Q               =   20
    KB_R               =   21
    KB_S               =   22
    KB_T               =   23
    KB_U               =   24
    KB_V               =   25
    KB_W               =   26
    KB_X               =   27
    KB_Y               =   28
    KB_Z               =   29
    KB_ISO             =  100 # ` on US/UK macOS < on EU macOS \ on US/UK Windows
    KB_NUMPAD_0        =   98
    KB_NUMPAD_1        =   89
    KB_NUMPAD_2        =   90
    KB_NUMPAD_3        =   91
    KB_NUMPAD_4        =   92
    KB_NUMPAD_5        =   93
    KB_NUMPAD_6        =   94
    KB_NUMPAD_7        =   95
    KB_NUMPAD_8        =   96
    KB_NUMPAD_9        =   97
    KB_NUMPAD_DELETE   =   99
    KB_NUMPAD_PLUS     =   87
    KB_NUMPAD_MINUS    =   86
    KB_NUMPAD_MULTIPLY =   85
    KB_NUMPAD_DIVIDE   =   84
    KB_RANGE_END       = 0xff

    MS_RANGE_BEGIN
    MS_LEFT        = MS_RANGE_BEGIN
    MS_MIDDLE
    MS_RIGHT
    MS_WHEEL_UP
    MS_WHEEL_DOWN
    MS_OTHER_0
    MS_OTHER_1
    MS_OTHER_2
    MS_OTHER_3
    MS_OTHER_4
    MS_OTHER_5
    MS_OTHER_6
    MS_OTHER_7
    MS_RANGE_END   = 0x110

    GP_RANGE_BEGIN
    GP_DPAD_LEFT   = GP_RANGE_BEGIN
    GP_DPAD_RIGHT
    GP_DPAD_UP
    GP_DPAD_DOWN
    GP_BUTTON_0
    GP_BUTTON_1
    GP_BUTTON_2
    GP_BUTTON_3
    GP_BUTTON_4
    GP_BUTTON_5
    GP_BUTTON_6
    GP_BUTTON_7
    GP_BUTTON_8
    GP_BUTTON_9
    GP_BUTTON_10
    GP_BUTTON_11
    GP_BUTTON_12
    GP_BUTTON_13
    GP_BUTTON_14
    GP_BUTTON_15

    GP_0_DPAD_LEFT
    GP_0_DPAD_RIGHT
    GP_0_DPAD_UP
    GP_0_DPAD_DOWN
    GP_0_BUTTON_0
    GP_0_BUTTON_1
    GP_0_BUTTON_2
    GP_0_BUTTON_3
    GP_0_BUTTON_4
    GP_0_BUTTON_5
    GP_0_BUTTON_6
    GP_0_BUTTON_7
    GP_0_BUTTON_8
    GP_0_BUTTON_9
    GP_0_BUTTON_10
    GP_0_BUTTON_11
    GP_0_BUTTON_12
    GP_0_BUTTON_13
    GP_0_BUTTON_14
    GP_0_BUTTON_15

    GP_1_DPAD_LEFT
    GP_1_DPAD_RIGHT
    GP_1_DPAD_UP
    GP_1_DPAD_DOWN
    GP_1_BUTTON_0
    GP_1_BUTTON_1
    GP_1_BUTTON_2
    GP_1_BUTTON_3
    GP_1_BUTTON_4
    GP_1_BUTTON_5
    GP_1_BUTTON_6
    GP_1_BUTTON_7
    GP_1_BUTTON_8
    GP_1_BUTTON_9
    GP_1_BUTTON_10
    GP_1_BUTTON_11
    GP_1_BUTTON_12
    GP_1_BUTTON_13
    GP_1_BUTTON_14
    GP_1_BUTTON_15

    GP_2_DPAD_LEFT
    GP_2_DPAD_RIGHT
    GP_2_DPAD_UP
    GP_2_DPAD_DOWN
    GP_2_BUTTON_0
    GP_2_BUTTON_1
    GP_2_BUTTON_2
    GP_2_BUTTON_3
    GP_2_BUTTON_4
    GP_2_BUTTON_5
    GP_2_BUTTON_6
    GP_2_BUTTON_7
    GP_2_BUTTON_8
    GP_2_BUTTON_9
    GP_2_BUTTON_10
    GP_2_BUTTON_11
    GP_2_BUTTON_12
    GP_2_BUTTON_13
    GP_2_BUTTON_14
    GP_2_BUTTON_15

    GP_3_DPAD_LEFT
    GP_3_DPAD_RIGHT
    GP_3_DPAD_UP
    GP_3_DPAD_DOWN
    GP_3_BUTTON_0
    GP_3_BUTTON_1
    GP_3_BUTTON_2
    GP_3_BUTTON_3
    GP_3_BUTTON_4
    GP_3_BUTTON_5
    GP_3_BUTTON_6
    GP_3_BUTTON_7
    GP_3_BUTTON_8
    GP_3_BUTTON_9
    GP_3_BUTTON_10
    GP_3_BUTTON_11
    GP_3_BUTTON_12
    GP_3_BUTTON_13
    GP_3_BUTTON_14
    GP_3_BUTTON_15

    GP_LEFT
    GP_RIGHT
    GP_UP
    GP_DOWN

    GP_0_LEFT
    GP_0_RIGHT
    GP_0_UP
    GP_0_DOWN

    GP_1_LEFT
    GP_1_RIGHT
    GP_1_UP
    GP_1_DOWN

    GP_2_LEFT
    GP_2_RIGHT
    GP_2_UP
    GP_2_DOWN

    GP_3_LEFT
    GP_3_RIGHT
    GP_3_UP
    GP_3_DOWN
    GP_RANGE_END = GP_3_DOWN

    GP_AXES_RANGE_BEGIN
    GP_LEFT_STICK_X_AXIS  = GP_AXES_RANGE_BEGIN
    GP_LEFT_STICK_Y_AXIS
    GP_RIGHT_STICK_X_AXIS
    GP_RIGHT_STICK_Y_AXIS
    GP_LEFT_TRIGGER_AXIS
    GP_RIGHT_TRIGGER_AXIS

    GP_0_LEFT_STICK_X_AXIS
    GP_0_LEFT_STICK_Y_AXIS
    GP_0_RIGHT_STICK_X_AXIS
    GP_0_RIGHT_STICK_Y_AXIS
    GP_0_LEFT_TRIGGER_AXIS
    GP_0_RIGHT_TRIGGER_AXIS

    GP_1_LEFT_STICK_X_AXIS
    GP_1_LEFT_STICK_Y_AXIS
    GP_1_RIGHT_STICK_X_AXIS
    GP_1_RIGHT_STICK_Y_AXIS
    GP_1_LEFT_TRIGGER_AXIS
    GP_1_RIGHT_TRIGGER_AXIS

    GP_2_LEFT_STICK_X_AXIS
    GP_2_LEFT_STICK_Y_AXIS
    GP_2_RIGHT_STICK_X_AXIS
    GP_2_RIGHT_STICK_Y_AXIS
    GP_2_LEFT_TRIGGER_AXIS
    GP_2_RIGHT_TRIGGER_AXIS

    GP_3_LEFT_STICK_X_AXIS
    GP_3_LEFT_STICK_Y_AXIS
    GP_3_RIGHT_STICK_X_AXIS
    GP_3_RIGHT_STICK_Y_AXIS
    GP_3_LEFT_TRIGGER_AXIS
    GP_3_RIGHT_TRIGGER_AXIS
    GP_AXES_RANGE_END       = GP_3_RIGHT_TRIGGER_AXIS
  end
end

# TODO: See if there is a way to dynamically generate constants in crystal
module Gosu
  KB_RANGE_BEGIN          = Gosu::ButtonName::KB_RANGE_BEGIN.to_u32
  KB_ESCAPE               = Gosu::ButtonName::KB_ESCAPE.to_u32
  KB_F1                   = Gosu::ButtonName::KB_F1.to_u32
  KB_F2                   = Gosu::ButtonName::KB_F2.to_u32
  KB_F3                   = Gosu::ButtonName::KB_F3.to_u32
  KB_F4                   = Gosu::ButtonName::KB_F4.to_u32
  KB_F5                   = Gosu::ButtonName::KB_F5.to_u32
  KB_F6                   = Gosu::ButtonName::KB_F6.to_u32
  KB_F7                   = Gosu::ButtonName::KB_F7.to_u32
  KB_F8                   = Gosu::ButtonName::KB_F8.to_u32
  KB_F9                   = Gosu::ButtonName::KB_F9.to_u32
  KB_F10                  = Gosu::ButtonName::KB_F10.to_u32
  KB_F11                  = Gosu::ButtonName::KB_F11.to_u32
  KB_F12                  = Gosu::ButtonName::KB_F12.to_u32
  KB_0                    = Gosu::ButtonName::KB_0.to_u32
  KB_1                    = Gosu::ButtonName::KB_1.to_u32
  KB_2                    = Gosu::ButtonName::KB_2.to_u32
  KB_3                    = Gosu::ButtonName::KB_3.to_u32
  KB_4                    = Gosu::ButtonName::KB_4.to_u32
  KB_5                    = Gosu::ButtonName::KB_5.to_u32
  KB_6                    = Gosu::ButtonName::KB_6.to_u32
  KB_7                    = Gosu::ButtonName::KB_7.to_u32
  KB_8                    = Gosu::ButtonName::KB_8.to_u32
  KB_9                    = Gosu::ButtonName::KB_9.to_u32
  KB_TAB                  = Gosu::ButtonName::KB_TAB.to_u32
  KB_RETURN               = Gosu::ButtonName::KB_RETURN.to_u32
  KB_SPACE                = Gosu::ButtonName::KB_SPACE.to_u32
  KB_LEFT_SHIFT           = Gosu::ButtonName::KB_LEFT_SHIFT.to_u32
  KB_RIGHT_SHIFT          = Gosu::ButtonName::KB_RIGHT_SHIFT.to_u32
  KB_LEFT_CONTROL         = Gosu::ButtonName::KB_LEFT_CONTROL.to_u32
  KB_RIGHT_CONTROL        = Gosu::ButtonName::KB_RIGHT_CONTROL.to_u32
  KB_LEFT_ALT             = Gosu::ButtonName::KB_LEFT_ALT.to_u32
  KB_RIGHT_ALT            = Gosu::ButtonName::KB_RIGHT_ALT.to_u32
  KB_LEFT_META            = Gosu::ButtonName::KB_LEFT_META.to_u32
  KB_RIGHT_META           = Gosu::ButtonName::KB_RIGHT_META.to_u32
  KB_BACKSPACE            = Gosu::ButtonName::KB_BACKSPACE.to_u32
  KB_LEFT                 = Gosu::ButtonName::KB_LEFT.to_u32
  KB_RIGHT                = Gosu::ButtonName::KB_RIGHT.to_u32
  KB_UP                   = Gosu::ButtonName::KB_UP.to_u32
  KB_DOWN                 = Gosu::ButtonName::KB_DOWN.to_u32
  KB_HOME                 = Gosu::ButtonName::KB_HOME.to_u32
  KB_END                  = Gosu::ButtonName::KB_END.to_u32
  KB_INSERT               = Gosu::ButtonName::KB_INSERT.to_u32
  KB_DELETE               = Gosu::ButtonName::KB_DELETE.to_u32
  KB_PAGE_UP              = Gosu::ButtonName::KB_PAGE_UP.to_u32
  KB_PAGE_DOWN            = Gosu::ButtonName::KB_PAGE_DOWN.to_u32
  KB_ENTER                = Gosu::ButtonName::KB_ENTER.to_u32
  KB_BACKTICK             = Gosu::ButtonName::KB_BACKTICK.to_u32
  KB_MINUS                = Gosu::ButtonName::KB_MINUS.to_u32
  KB_EQUALS               = Gosu::ButtonName::KB_EQUALS.to_u32
  KB_LEFT_BRACKET         = Gosu::ButtonName::KB_LEFT_BRACKET.to_u32
  KB_RIGHT_BRACKET        = Gosu::ButtonName::KB_RIGHT_BRACKET.to_u32
  KB_BACKSLASH            = Gosu::ButtonName::KB_BACKSLASH.to_u32
  KB_SEMICOLON            = Gosu::ButtonName::KB_SEMICOLON.to_u32
  KB_APOSTROPHE           = Gosu::ButtonName::KB_APOSTROPHE.to_u32
  KB_COMMA                = Gosu::ButtonName::KB_COMMA.to_u32
  KB_PERIOD               = Gosu::ButtonName::KB_PERIOD.to_u32
  KB_SLASH                = Gosu::ButtonName::KB_SLASH.to_u32
  KB_A                    = Gosu::ButtonName::KB_A.to_u32
  KB_B                    = Gosu::ButtonName::KB_B.to_u32
  KB_C                    = Gosu::ButtonName::KB_C.to_u32
  KB_D                    = Gosu::ButtonName::KB_D.to_u32
  KB_E                    = Gosu::ButtonName::KB_E.to_u32
  KB_F                    = Gosu::ButtonName::KB_F.to_u32
  KB_G                    = Gosu::ButtonName::KB_G.to_u32
  KB_H                    = Gosu::ButtonName::KB_H.to_u32
  KB_I                    = Gosu::ButtonName::KB_I.to_u32
  KB_J                    = Gosu::ButtonName::KB_J.to_u32
  KB_K                    = Gosu::ButtonName::KB_K.to_u32
  KB_L                    = Gosu::ButtonName::KB_L.to_u32
  KB_M                    = Gosu::ButtonName::KB_M.to_u32
  KB_N                    = Gosu::ButtonName::KB_N.to_u32
  KB_O                    = Gosu::ButtonName::KB_O.to_u32
  KB_P                    = Gosu::ButtonName::KB_P.to_u32
  KB_Q                    = Gosu::ButtonName::KB_Q.to_u32
  KB_R                    = Gosu::ButtonName::KB_R.to_u32
  KB_S                    = Gosu::ButtonName::KB_S.to_u32
  KB_T                    = Gosu::ButtonName::KB_T.to_u32
  KB_U                    = Gosu::ButtonName::KB_U.to_u32
  KB_V                    = Gosu::ButtonName::KB_V.to_u32
  KB_W                    = Gosu::ButtonName::KB_W.to_u32
  KB_X                    = Gosu::ButtonName::KB_X.to_u32
  KB_Y                    = Gosu::ButtonName::KB_Y.to_u32
  KB_Z                    = Gosu::ButtonName::KB_Z.to_u32
  KB_ISO                  = Gosu::ButtonName::KB_ISO.to_u32
  KB_NUMPAD_0             = Gosu::ButtonName::KB_NUMPAD_0.to_u32
  KB_NUMPAD_1             = Gosu::ButtonName::KB_NUMPAD_1.to_u32
  KB_NUMPAD_2             = Gosu::ButtonName::KB_NUMPAD_2.to_u32
  KB_NUMPAD_3             = Gosu::ButtonName::KB_NUMPAD_3.to_u32
  KB_NUMPAD_4             = Gosu::ButtonName::KB_NUMPAD_4.to_u32
  KB_NUMPAD_5             = Gosu::ButtonName::KB_NUMPAD_5.to_u32
  KB_NUMPAD_6             = Gosu::ButtonName::KB_NUMPAD_6.to_u32
  KB_NUMPAD_7             = Gosu::ButtonName::KB_NUMPAD_7.to_u32
  KB_NUMPAD_8             = Gosu::ButtonName::KB_NUMPAD_8.to_u32
  KB_NUMPAD_9             = Gosu::ButtonName::KB_NUMPAD_9.to_u32
  KB_NUMPAD_DELETE        = Gosu::ButtonName::KB_NUMPAD_DELETE.to_u32
  KB_NUMPAD_PLUS          = Gosu::ButtonName::KB_NUMPAD_PLUS.to_u32
  KB_NUMPAD_MINUS         = Gosu::ButtonName::KB_NUMPAD_MINUS.to_u32
  KB_NUMPAD_MULTIPLY      = Gosu::ButtonName::KB_NUMPAD_MULTIPLY.to_u32
  KB_NUMPAD_DIVIDE        = Gosu::ButtonName::KB_NUMPAD_DIVIDE.to_u32
  KB_RANGE_END            = Gosu::ButtonName::KB_RANGE_END.to_u32
  MS_RANGE_BEGIN          = Gosu::ButtonName::MS_RANGE_BEGIN.to_u32
  MS_LEFT                 = Gosu::ButtonName::MS_LEFT.to_u32
  MS_MIDDLE               = Gosu::ButtonName::MS_MIDDLE.to_u32
  MS_RIGHT                = Gosu::ButtonName::MS_RIGHT.to_u32
  MS_WHEEL_UP             = Gosu::ButtonName::MS_WHEEL_UP.to_u32
  MS_WHEEL_DOWN           = Gosu::ButtonName::MS_WHEEL_DOWN.to_u32
  MS_OTHER_0              = Gosu::ButtonName::MS_OTHER_0.to_u32
  MS_OTHER_1              = Gosu::ButtonName::MS_OTHER_1.to_u32
  MS_OTHER_2              = Gosu::ButtonName::MS_OTHER_2.to_u32
  MS_OTHER_3              = Gosu::ButtonName::MS_OTHER_3.to_u32
  MS_OTHER_4              = Gosu::ButtonName::MS_OTHER_4.to_u32
  MS_OTHER_5              = Gosu::ButtonName::MS_OTHER_5.to_u32
  MS_OTHER_6              = Gosu::ButtonName::MS_OTHER_6.to_u32
  MS_OTHER_7              = Gosu::ButtonName::MS_OTHER_7.to_u32
  MS_RANGE_END            = Gosu::ButtonName::MS_RANGE_END.to_u32
  GP_RANGE_BEGIN          = Gosu::ButtonName::GP_RANGE_BEGIN.to_u32
  GP_DPAD_LEFT            = Gosu::ButtonName::GP_DPAD_LEFT.to_u32
  GP_DPAD_RIGHT           = Gosu::ButtonName::GP_DPAD_RIGHT.to_u32
  GP_DPAD_UP              = Gosu::ButtonName::GP_DPAD_UP.to_u32
  GP_DPAD_DOWN            = Gosu::ButtonName::GP_DPAD_DOWN.to_u32
  GP_BUTTON_0             = Gosu::ButtonName::GP_BUTTON_0.to_u32
  GP_BUTTON_1             = Gosu::ButtonName::GP_BUTTON_1.to_u32
  GP_BUTTON_2             = Gosu::ButtonName::GP_BUTTON_2.to_u32
  GP_BUTTON_3             = Gosu::ButtonName::GP_BUTTON_3.to_u32
  GP_BUTTON_4             = Gosu::ButtonName::GP_BUTTON_4.to_u32
  GP_BUTTON_5             = Gosu::ButtonName::GP_BUTTON_5.to_u32
  GP_BUTTON_6             = Gosu::ButtonName::GP_BUTTON_6.to_u32
  GP_BUTTON_7             = Gosu::ButtonName::GP_BUTTON_7.to_u32
  GP_BUTTON_8             = Gosu::ButtonName::GP_BUTTON_8.to_u32
  GP_BUTTON_9             = Gosu::ButtonName::GP_BUTTON_9.to_u32
  GP_BUTTON_10            = Gosu::ButtonName::GP_BUTTON_10.to_u32
  GP_BUTTON_11            = Gosu::ButtonName::GP_BUTTON_11.to_u32
  GP_BUTTON_12            = Gosu::ButtonName::GP_BUTTON_12.to_u32
  GP_BUTTON_13            = Gosu::ButtonName::GP_BUTTON_13.to_u32
  GP_BUTTON_14            = Gosu::ButtonName::GP_BUTTON_14.to_u32
  GP_BUTTON_15            = Gosu::ButtonName::GP_BUTTON_15.to_u32
  GP_LEFT                 = Gosu::ButtonName::GP_LEFT.to_u32
  GP_RIGHT                = Gosu::ButtonName::GP_RIGHT.to_u32
  GP_UP                   = Gosu::ButtonName::GP_UP.to_u32
  GP_DOWN                 = Gosu::ButtonName::GP_DOWN.to_u32
  GP_LEFT_STICK_X_AXIS    = Gosu::ButtonName::GP_LEFT_STICK_X_AXIS.to_u32
  GP_LEFT_STICK_Y_AXIS    = Gosu::ButtonName::GP_LEFT_STICK_Y_AXIS.to_u32
  GP_RIGHT_STICK_X_AXIS   = Gosu::ButtonName::GP_RIGHT_STICK_X_AXIS.to_u32
  GP_RIGHT_STICK_Y_AXIS   = Gosu::ButtonName::GP_RIGHT_STICK_Y_AXIS.to_u32
  GP_LEFT_TRIGGER_AXIS    = Gosu::ButtonName::GP_LEFT_TRIGGER_AXIS.to_u32
  GP_RIGHT_TRIGGER_AXIS   = Gosu::ButtonName::GP_RIGHT_TRIGGER_AXIS.to_u32
  GP_0_DPAD_LEFT          = Gosu::ButtonName::GP_0_DPAD_LEFT.to_u32
  GP_0_DPAD_RIGHT         = Gosu::ButtonName::GP_0_DPAD_RIGHT.to_u32
  GP_0_DPAD_UP            = Gosu::ButtonName::GP_0_DPAD_UP.to_u32
  GP_0_DPAD_DOWN          = Gosu::ButtonName::GP_0_DPAD_DOWN.to_u32
  GP_0_BUTTON_0           = Gosu::ButtonName::GP_0_BUTTON_0.to_u32
  GP_0_BUTTON_1           = Gosu::ButtonName::GP_0_BUTTON_1.to_u32
  GP_0_BUTTON_2           = Gosu::ButtonName::GP_0_BUTTON_2.to_u32
  GP_0_BUTTON_3           = Gosu::ButtonName::GP_0_BUTTON_3.to_u32
  GP_0_BUTTON_4           = Gosu::ButtonName::GP_0_BUTTON_4.to_u32
  GP_0_BUTTON_5           = Gosu::ButtonName::GP_0_BUTTON_5.to_u32
  GP_0_BUTTON_6           = Gosu::ButtonName::GP_0_BUTTON_6.to_u32
  GP_0_BUTTON_7           = Gosu::ButtonName::GP_0_BUTTON_7.to_u32
  GP_0_BUTTON_8           = Gosu::ButtonName::GP_0_BUTTON_8.to_u32
  GP_0_BUTTON_9           = Gosu::ButtonName::GP_0_BUTTON_9.to_u32
  GP_0_BUTTON_10          = Gosu::ButtonName::GP_0_BUTTON_10.to_u32
  GP_0_BUTTON_11          = Gosu::ButtonName::GP_0_BUTTON_11.to_u32
  GP_0_BUTTON_12          = Gosu::ButtonName::GP_0_BUTTON_12.to_u32
  GP_0_BUTTON_13          = Gosu::ButtonName::GP_0_BUTTON_13.to_u32
  GP_0_BUTTON_14          = Gosu::ButtonName::GP_0_BUTTON_14.to_u32
  GP_0_BUTTON_15          = Gosu::ButtonName::GP_0_BUTTON_15.to_u32
  GP_0_LEFT               = Gosu::ButtonName::GP_0_LEFT.to_u32
  GP_0_RIGHT              = Gosu::ButtonName::GP_0_RIGHT.to_u32
  GP_0_UP                 = Gosu::ButtonName::GP_0_UP.to_u32
  GP_0_DOWN               = Gosu::ButtonName::GP_0_DOWN.to_u32
  GP_0_LEFT_STICK_X_AXIS  = Gosu::ButtonName::GP_0_LEFT_STICK_X_AXIS.to_u32
  GP_0_LEFT_STICK_Y_AXIS  = Gosu::ButtonName::GP_0_LEFT_STICK_Y_AXIS.to_u32
  GP_0_RIGHT_STICK_X_AXIS = Gosu::ButtonName::GP_0_RIGHT_STICK_X_AXIS.to_u32
  GP_0_RIGHT_STICK_Y_AXIS = Gosu::ButtonName::GP_0_RIGHT_STICK_Y_AXIS.to_u32
  GP_0_LEFT_TRIGGER_AXIS  = Gosu::ButtonName::GP_0_LEFT_TRIGGER_AXIS.to_u32
  GP_0_RIGHT_TRIGGER_AXIS = Gosu::ButtonName::GP_0_RIGHT_TRIGGER_AXIS.to_u32
  GP_1_DPAD_LEFT          = Gosu::ButtonName::GP_1_DPAD_LEFT.to_u32
  GP_1_DPAD_RIGHT         = Gosu::ButtonName::GP_1_DPAD_RIGHT.to_u32
  GP_1_DPAD_UP            = Gosu::ButtonName::GP_1_DPAD_UP.to_u32
  GP_1_DPAD_DOWN          = Gosu::ButtonName::GP_1_DPAD_DOWN.to_u32
  GP_1_BUTTON_0           = Gosu::ButtonName::GP_1_BUTTON_0.to_u32
  GP_1_BUTTON_1           = Gosu::ButtonName::GP_1_BUTTON_1.to_u32
  GP_1_BUTTON_2           = Gosu::ButtonName::GP_1_BUTTON_2.to_u32
  GP_1_BUTTON_3           = Gosu::ButtonName::GP_1_BUTTON_3.to_u32
  GP_1_BUTTON_4           = Gosu::ButtonName::GP_1_BUTTON_4.to_u32
  GP_1_BUTTON_5           = Gosu::ButtonName::GP_1_BUTTON_5.to_u32
  GP_1_BUTTON_6           = Gosu::ButtonName::GP_1_BUTTON_6.to_u32
  GP_1_BUTTON_7           = Gosu::ButtonName::GP_1_BUTTON_7.to_u32
  GP_1_BUTTON_8           = Gosu::ButtonName::GP_1_BUTTON_8.to_u32
  GP_1_BUTTON_9           = Gosu::ButtonName::GP_1_BUTTON_9.to_u32
  GP_1_BUTTON_10          = Gosu::ButtonName::GP_1_BUTTON_10.to_u32
  GP_1_BUTTON_11          = Gosu::ButtonName::GP_1_BUTTON_11.to_u32
  GP_1_BUTTON_12          = Gosu::ButtonName::GP_1_BUTTON_12.to_u32
  GP_1_BUTTON_13          = Gosu::ButtonName::GP_1_BUTTON_13.to_u32
  GP_1_BUTTON_14          = Gosu::ButtonName::GP_1_BUTTON_14.to_u32
  GP_1_BUTTON_15          = Gosu::ButtonName::GP_1_BUTTON_15.to_u32
  GP_1_LEFT               = Gosu::ButtonName::GP_1_LEFT.to_u32
  GP_1_RIGHT              = Gosu::ButtonName::GP_1_RIGHT.to_u32
  GP_1_UP                 = Gosu::ButtonName::GP_1_UP.to_u32
  GP_1_DOWN               = Gosu::ButtonName::GP_1_DOWN.to_u32
  GP_1_LEFT_STICK_X_AXIS  = Gosu::ButtonName::GP_1_LEFT_STICK_X_AXIS.to_u32
  GP_1_LEFT_STICK_Y_AXIS  = Gosu::ButtonName::GP_1_LEFT_STICK_Y_AXIS.to_u32
  GP_1_RIGHT_STICK_X_AXIS = Gosu::ButtonName::GP_1_RIGHT_STICK_X_AXIS.to_u32
  GP_1_RIGHT_STICK_Y_AXIS = Gosu::ButtonName::GP_1_RIGHT_STICK_Y_AXIS.to_u32
  GP_1_LEFT_TRIGGER_AXIS  = Gosu::ButtonName::GP_1_LEFT_TRIGGER_AXIS.to_u32
  GP_1_RIGHT_TRIGGER_AXIS = Gosu::ButtonName::GP_1_RIGHT_TRIGGER_AXIS.to_u32
  GP_2_DPAD_LEFT          = Gosu::ButtonName::GP_2_DPAD_LEFT.to_u32
  GP_2_DPAD_RIGHT         = Gosu::ButtonName::GP_2_DPAD_RIGHT.to_u32
  GP_2_DPAD_UP            = Gosu::ButtonName::GP_2_DPAD_UP.to_u32
  GP_2_DPAD_DOWN          = Gosu::ButtonName::GP_2_DPAD_DOWN.to_u32
  GP_2_BUTTON_0           = Gosu::ButtonName::GP_2_BUTTON_0.to_u32
  GP_2_BUTTON_1           = Gosu::ButtonName::GP_2_BUTTON_1.to_u32
  GP_2_BUTTON_2           = Gosu::ButtonName::GP_2_BUTTON_2.to_u32
  GP_2_BUTTON_3           = Gosu::ButtonName::GP_2_BUTTON_3.to_u32
  GP_2_BUTTON_4           = Gosu::ButtonName::GP_2_BUTTON_4.to_u32
  GP_2_BUTTON_5           = Gosu::ButtonName::GP_2_BUTTON_5.to_u32
  GP_2_BUTTON_6           = Gosu::ButtonName::GP_2_BUTTON_6.to_u32
  GP_2_BUTTON_7           = Gosu::ButtonName::GP_2_BUTTON_7.to_u32
  GP_2_BUTTON_8           = Gosu::ButtonName::GP_2_BUTTON_8.to_u32
  GP_2_BUTTON_9           = Gosu::ButtonName::GP_2_BUTTON_9.to_u32
  GP_2_BUTTON_10          = Gosu::ButtonName::GP_2_BUTTON_10.to_u32
  GP_2_BUTTON_11          = Gosu::ButtonName::GP_2_BUTTON_11.to_u32
  GP_2_BUTTON_12          = Gosu::ButtonName::GP_2_BUTTON_12.to_u32
  GP_2_BUTTON_13          = Gosu::ButtonName::GP_2_BUTTON_13.to_u32
  GP_2_BUTTON_14          = Gosu::ButtonName::GP_2_BUTTON_14.to_u32
  GP_2_BUTTON_15          = Gosu::ButtonName::GP_2_BUTTON_15.to_u32
  GP_2_LEFT               = Gosu::ButtonName::GP_2_LEFT.to_u32
  GP_2_RIGHT              = Gosu::ButtonName::GP_2_RIGHT.to_u32
  GP_2_UP                 = Gosu::ButtonName::GP_2_UP.to_u32
  GP_2_DOWN               = Gosu::ButtonName::GP_2_DOWN.to_u32
  GP_2_LEFT_STICK_X_AXIS  = Gosu::ButtonName::GP_2_LEFT_STICK_X_AXIS.to_u32
  GP_2_LEFT_STICK_Y_AXIS  = Gosu::ButtonName::GP_2_LEFT_STICK_Y_AXIS.to_u32
  GP_2_RIGHT_STICK_X_AXIS = Gosu::ButtonName::GP_2_RIGHT_STICK_X_AXIS.to_u32
  GP_2_RIGHT_STICK_Y_AXIS = Gosu::ButtonName::GP_2_RIGHT_STICK_Y_AXIS.to_u32
  GP_2_LEFT_TRIGGER_AXIS  = Gosu::ButtonName::GP_2_LEFT_TRIGGER_AXIS.to_u32
  GP_2_RIGHT_TRIGGER_AXIS = Gosu::ButtonName::GP_2_RIGHT_TRIGGER_AXIS.to_u32
  GP_3_DPAD_LEFT          = Gosu::ButtonName::GP_3_DPAD_LEFT.to_u32
  GP_3_DPAD_RIGHT         = Gosu::ButtonName::GP_3_DPAD_RIGHT.to_u32
  GP_3_DPAD_UP            = Gosu::ButtonName::GP_3_DPAD_UP.to_u32
  GP_3_DPAD_DOWN          = Gosu::ButtonName::GP_3_DPAD_DOWN.to_u32
  GP_3_BUTTON_0           = Gosu::ButtonName::GP_3_BUTTON_0.to_u32
  GP_3_BUTTON_1           = Gosu::ButtonName::GP_3_BUTTON_1.to_u32
  GP_3_BUTTON_2           = Gosu::ButtonName::GP_3_BUTTON_2.to_u32
  GP_3_BUTTON_3           = Gosu::ButtonName::GP_3_BUTTON_3.to_u32
  GP_3_BUTTON_4           = Gosu::ButtonName::GP_3_BUTTON_4.to_u32
  GP_3_BUTTON_5           = Gosu::ButtonName::GP_3_BUTTON_5.to_u32
  GP_3_BUTTON_6           = Gosu::ButtonName::GP_3_BUTTON_6.to_u32
  GP_3_BUTTON_7           = Gosu::ButtonName::GP_3_BUTTON_7.to_u32
  GP_3_BUTTON_8           = Gosu::ButtonName::GP_3_BUTTON_8.to_u32
  GP_3_BUTTON_9           = Gosu::ButtonName::GP_3_BUTTON_9.to_u32
  GP_3_BUTTON_10          = Gosu::ButtonName::GP_3_BUTTON_10.to_u32
  GP_3_BUTTON_11          = Gosu::ButtonName::GP_3_BUTTON_11.to_u32
  GP_3_BUTTON_12          = Gosu::ButtonName::GP_3_BUTTON_12.to_u32
  GP_3_BUTTON_13          = Gosu::ButtonName::GP_3_BUTTON_13.to_u32
  GP_3_BUTTON_14          = Gosu::ButtonName::GP_3_BUTTON_14.to_u32
  GP_3_BUTTON_15          = Gosu::ButtonName::GP_3_BUTTON_15.to_u32
  GP_3_LEFT               = Gosu::ButtonName::GP_3_LEFT.to_u32
  GP_3_RIGHT              = Gosu::ButtonName::GP_3_RIGHT.to_u32
  GP_3_UP                 = Gosu::ButtonName::GP_3_UP.to_u32
  GP_3_DOWN               = Gosu::ButtonName::GP_3_DOWN.to_u32
  GP_3_LEFT_STICK_X_AXIS  = Gosu::ButtonName::GP_3_LEFT_STICK_X_AXIS.to_u32
  GP_3_LEFT_STICK_Y_AXIS  = Gosu::ButtonName::GP_3_LEFT_STICK_Y_AXIS.to_u32
  GP_3_RIGHT_STICK_X_AXIS = Gosu::ButtonName::GP_3_RIGHT_STICK_X_AXIS.to_u32
  GP_3_RIGHT_STICK_Y_AXIS = Gosu::ButtonName::GP_3_RIGHT_STICK_Y_AXIS.to_u32
  GP_3_LEFT_TRIGGER_AXIS  = Gosu::ButtonName::GP_3_LEFT_TRIGGER_AXIS.to_u32
  GP_3_RIGHT_TRIGGER_AXIS = Gosu::ButtonName::GP_3_RIGHT_TRIGGER_AXIS.to_u32
  GP_RANGE_END            = Gosu::ButtonName::GP_RANGE_END.to_u32
  NUM_BUTTONS             = Gosu::ButtonName::NUM_BUTTONS.to_u32
  NUM_GAMEPADS            = Gosu::ButtonName::NUM_GAMEPADS.to_u32
  NO_BUTTON               = Gosu::ButtonName::NO_BUTTON.to_u32
  KB_NUM                  = Gosu::ButtonName::KB_NUM.to_u32
  MS_NUM                  = Gosu::ButtonName::MS_NUM.to_u32
  GP_NUM                  = Gosu::ButtonName::GP_NUM.to_u32
  GP_NUM_PER_GAMEPAD      = Gosu::ButtonName::GP_NUM_PER_GAMEPAD.to_u32
end
