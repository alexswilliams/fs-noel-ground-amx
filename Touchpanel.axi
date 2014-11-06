PROGRAM_NAME='Touchpanel'

#if_not_defined __TOUCHPANEL__
#define __TOUCHPANEL__


DEFINE_DEVICE

    dvTP = 100:1:1
    
    
    
DEFINE_CONSTANT

    TP_POWER		= 1
    TP_SCREENBLANK	= 2
    TP_MUTE		= 3
    TP_VOLUME		= 4
    TP_SETTINGS		= 5
    TP_HELP		= 6
    TP_ENDCALL		= 7
    TP_CALLDUR		= 8
    TP_CALLVOL		= 9
    
    TP_CALL		= 10
    TP_ROOMPC		= 11
    TP_VIDYO		= 12
    TP_APPLETV		= 13
    TP_HDMI		= 14
    TP_VGA		= 15
    
    TP_ACCEPT_CALL	= 990
    TP_DECLINE_CALL	= 991

    TP_HELP1_TURNONTV	= 999
    TP_HELP1_TURNONAVR	= 998
    TP_HELP1_CALL	= 997
    TP_HELP1_FLIP	= 104
    
    TP_HELP2_FLIP	= 200
    TP_INFO_TV_POWER	= 201
    TP_INFO_TV_INPUT	= 202
    TP_INFO_TV_MUTE	= 203
    TP_INFO_TV_BLANK	= 204
    TP_INFO_TV_ASPECT	= 205
    TP_INFO_AMP_POWER	= 210
    TP_INFO_AMP_INPUT	= 211
    TP_INFO_AMP_AV_VOL	= 212
    TP_INFO_AMP_CALL_VOL = 213
    TP_INFO_AMP_AV_MUTE = 214
    TP_INFO_AMP_CALL_MUTE = 215
    TP_INFO_AMP_PREV_VOL = 216
    TP_INFO_AMP_LOUDNESS = 217
    TP_INFO_CO_OFFHOOK  = 220
    TP_INFO_CO_LASTNUM  = 221
    TP_INFO_CO_CALLDUR  = 222
    TP_INFO_CO_MUTE  	= 223
    TP_INFO_CO_PHONEBOOK = 224
    
    
    TP_CALL_DIAL_CALL		= 303
    TP_CALL_DIAL_END		= 304
    TP_CALL_DIAL_REDIAL		= 305
    TP_CALL_DIAL_MUTE		= 306
    TP_CALL_DIAL_NUMBER_BOX	= 307
    TP_CALL_DIAL_BACKSPACE	= 308
    TP_CALL_DIAL_CLEAR		= 309
    TP_CALL_DIAL_0		= 310
    TP_CALL_DIAL_1		= 311
    TP_CALL_DIAL_2		= 312
    TP_CALL_DIAL_3		= 313
    TP_CALL_DIAL_4		= 314
    TP_CALL_DIAL_5		= 315
    TP_CALL_DIAL_6		= 316
    TP_CALL_DIAL_7		= 317
    TP_CALL_DIAL_8		= 318
    TP_CALL_DIAL_9		= 319
    TP_CALL_DIAL_STAR		= 321
    TP_CALL_DIAL_HASH		= 322
    
    TP_CALL_PRESETS_CALL	= 333
    TP_CALL_PRESETS_END		= 334
    TP_CALL_PRESETS_REDIAL	= 335
    TP_CALL_PRESETS_MUTE	= 336
    TP_CALL_PRESETS_NUMBER_BOX	= 337
    TP_CALL_PRESET_0		= 340
    TP_CALL_PRESET_1		= 341
    TP_CALL_PRESET_2		= 342
    TP_CALL_PRESET_3		= 343
    TP_CALL_PRESET_4		= 344
    TP_CALL_PRESET_5		= 345
    TP_CALL_PRESET_6		= 346
    TP_CALL_PRESET_7		= 347
    TP_CALL_PRESET_PREVPAGE	= 348
    TP_CALL_PRESET_NEXTPAGE	= 349
    
    TP_CALL_SETTINGS_AUTOANSWER			= 353
    TP_CALL_SETTINGS_ECHOCANCELLATION		= 354
    TP_CALL_SETTINGS_AUTOMATICMICGAIN		= 355
    TP_CALL_SETTINGS_INPUTCOMPRESSION		= 356
    TP_CALL_SETTINGS_NOISECANCELLATION		= 357
    TP_CALL_SETTINGS_MICGATEDECAY		= 358
    TP_CALL_SETTINGS_RINGERENABLE		= 359
    TP_CALL_SETTINGS_TELCOCLEAREFFECT		= 360
    TP_CALL_SETTINGS_TELCOAUTOLEVELCONTROL	= 361
    TP_CALL_SETTINGS_TELCOECHOCANCELLATION	= 362
    TP_CALL_SETTINGS_MICGAIN			= 363
    
    TP_CALL_ROUTING_CALL_TO_SPEAKERS		= 383
    TP_CALL_ROUTING_ADD_VIDYO			= 384
    TP_CALL_ROUTING_ADD_ROOMPC			= 385
    TP_CALL_ROUTING_MIC_CALL			= 386
    TP_CALL_ROUTING_MIC_VIDYO			= 387
    TP_CALL_ROUTING_MIC_ROOMPC			= 388
    TP_CALL_ROUTING_RESET			= 390

    TP_VIDYO_CONNECT				= 401
    TP_VIDYO_DISCONNECT				= 402
    TP_VIDYO_TOGGLE				= 403
    TP_VIDYO_DEL				= 404
    TP_VIDYO_SHARE				= 405
    TP_VIDYO_SELFVIEW				= 406
    TP_VIDYO_HOME				= 407
    TP_VIDYO_PRIVACY				= 408
    TP_VIDYO_0					= 410
    TP_VIDYO_1					= 411
    TP_VIDYO_2					= 412
    TP_VIDYO_3					= 413
    TP_VIDYO_4					= 414
    TP_VIDYO_5					= 415
    TP_VIDYO_6					= 416
    TP_VIDYO_7					= 417
    TP_VIDYO_8					= 418
    TP_VIDYO_9					= 419
    TP_VIDYO_STAR				= 420
    TP_VIDYO_HASH				= 421
    TP_VIDYO_A_RED				= 422
    TP_VIDYO_B_GREEN				= 423
    TP_VIDYO_C_YELLOW				= 424
    TP_VIDYO_D_BLUE				= 425
    TP_VIDYO_UP					= 430
    TP_VIDYO_DOWN				= 431
    TP_VIDYO_LEFT				= 432
    TP_VIDYO_RIGHT				= 433
    TP_VIDYO_OK					= 434
    TP_VIDYO_VOL_UP				= 435
    TP_VIDYO_VOL_DOWN				= 436
    TP_VIDYO_ZOOM_UP				= 437
    TP_VIDYO_ZOOM_DOWN				= 438
    TP_VIDYO_MANAGE				= 439
    
    TP_ATV_UP		= 501
    TP_ATV_DOWN		= 502
    TP_ATV_LEFT		= 503
    TP_ATV_RIGHT	= 504
    TP_ATV_OK		= 505
    TP_ATV_MENU		= 506
    TP_ATV_PLAYPAUSE	= 507

    TP_CAM_POWERTOGGLE				= 801
    TP_CAM_MANFOCUS				= 802
    TP_CAM_AUTOFOCUS				= 803
    TP_CAM_UP					= 804
    TP_CAM_DOWN					= 805
    TP_CAM_LEFT					= 806
    TP_CAM_RIGHT				= 807
    TP_CAM_HOME					= 808
    TP_CAM_DATASCREEN				= 809
    TP_CAM_BACKLIGHT				= 810
    TP_CAM_PRESET_1				= 811
    TP_CAM_PRESET_2				= 812
    TP_CAM_PRESET_3				= 813
    TP_CAM_PRESET_4				= 814
    TP_CAM_PRESET_5				= 815
    TP_CAM_PRESET_6				= 816
    TP_CAM_SET_1				= 817
    TP_CAM_SET_2				= 818
    TP_CAM_SET_3				= 819
    TP_CAM_SET_4				= 820
    TP_CAM_SET_5				= 821
    TP_CAM_SET_6				= 822
    TP_CAM_RESET_1				= 823
    TP_CAM_RESET_2				= 824
    TP_CAM_RESET_3				= 825
    TP_CAM_RESET_4				= 826
    TP_CAM_RESET_5				= 827
    TP_CAM_RESET_6				= 828
    TP_CAM_FASTZOOM_TELE			= 829
    TP_CAM_FASTZOOM_WIDE			= 830
    TP_CAM_SLOWZOOM_TELE			= 831
    TP_CAM_SLOWZOOM_WIDE			= 832
    TP_CAM_FOCUS_FAR				= 833
    TP_CAM_FOCUS_NEAR				= 834
    TP_CAM_PANTILT_RESET			= 835
    

DEFINE_VARIABLE

    CHAR CURRENT_PHONE_NUMBER[32] = {''}
    CHAR CURRENT_PHONE_NUMBER_SPACED[32] = {''}
    INTEGER CURRENT_PHONE_NUMBER_INDEX = 1
    
    INTEGER CURRENTLY_IN_CALL = 0
    INTEGER CURRENTLY_RINGING = 0
    

DEFINE_FUNCTION SET_NUMBER_BOXES_TO_NUMBER(CHAR Number[]) {
    stack_var integer i
    stack_var integer j
    stack_var integer sep1
    stack_var integer sep2
    stack_var integer sep3
    
    
    if ((LENGTH_STRING(Number) >= 2) and (Number[1] == '9')) {
	sep1 = 0;	sep2 = 0;	sep3 = 0;
	switch (Number[2]) {
	    // UK NATIONAL
	    case '0': {
		if (LENGTH_STRING(Number) >= 4) {
		    if (COMPARE_STRING(MID_STRING(Number,2,3), '02?')) { sep1 = 5; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,3), '055')) { sep1 = 5; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,3), '056')) { sep1 = 5; sep2 = 9 }
		}
		if ((LENGTH_STRING(Number) >= 6) and (sep1 == 0)) {
		    if (COMPARE_STRING(MID_STRING(Number,2,4), '011?')) { sep1 = 6; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,4), '01?1')) { sep1 = 6; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,4), '03??')) { sep1 = 6; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,4), '08??')) { sep1 = 6; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,4), '09??')) { sep1 = 6; sep2 = 9 }
		}
		if ((LENGTH_STRING(Number) >= 6) and (sep1 == 0)) {
		    if (COMPARE_STRING(MID_STRING(Number,2,5), '01???')) { sep1 = 7; sep2 = 10 }
		    else if (COMPARE_STRING(MID_STRING(Number,2,5), '07???')) { sep1 = 7; sep2 = 10 }
		}
		sep3 = 2
		for (i = 1, j = 1; i <= LENGTH_STRING(Number); i++, j++) {
		    if (i == sep1) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
		    if (i == sep2) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
		    if (i == sep3) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
		    CURRENT_PHONE_NUMBER_SPACED[j] = Number[i]
		}
		SET_LENGTH_STRING(CURRENT_PHONE_NUMBER_SPACED, j-1)
	    }
	    // AMERICA
	    case '1': {
		if (COMPARE_STRING(Number, '91?1') == 1) {
		    CURRENT_PHONE_NUMBER_SPACED = Number
		} else {
		    sep1 = 3
		    sep2 = 6
		    sep3 = 9
		    for (i = 1, j = 1; i <= LENGTH_STRING(Number); i++, j++) {
			if (i == 2) { CURRENT_PHONE_NUMBER_SPACED[j] = '+'; j++ }
			if (i == sep1) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
			if (i == sep2) { CURRENT_PHONE_NUMBER_SPACED[j] = '-'; j++ }
			if (i == sep3) { CURRENT_PHONE_NUMBER_SPACED[j] = '-'; j++ }
			CURRENT_PHONE_NUMBER_SPACED[j] = Number[i]
		    }
		    SET_LENGTH_STRING(CURRENT_PHONE_NUMBER_SPACED, j-1)
		}
	    }
	    default: { CURRENT_PHONE_NUMBER_SPACED = Number }
	}
    } else if ((LENGTH_STRING(Number) >= 1) and (Number[1] != '9')) {
	sep1 = 0;	sep2 = 0;	sep3 = 0;
	switch (Number[1]) {
	    // UK NATIONAL
	    case '0': {
		if (LENGTH_STRING(Number) >= 3) {
		    if (COMPARE_STRING(MID_STRING(Number,1,3), '02?')) { sep1 = 4; sep2 = 8 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,3), '055')) { sep1 = 4; sep2 = 8 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,3), '056')) { sep1 = 4; sep2 = 8 }
		}
		if ((LENGTH_STRING(Number) >= 5) and (sep1 == 0)) {
		    if (COMPARE_STRING(MID_STRING(Number,1,4), '011?')) { sep1 = 5; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,4), '01?1')) { sep1 = 5; sep2 = 8 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,4), '03??')) { sep1 = 5; sep2 = 8 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,4), '08??')) { sep1 = 5; sep2 = 8 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,4), '09??')) { sep1 = 5; sep2 = 8 }
		}
		if ((LENGTH_STRING(Number) >= 5) and (sep1 == 0)) {
		    if (COMPARE_STRING(MID_STRING(Number,1,5), '01???')) { sep1 = 6; sep2 = 9 }
		    else if (COMPARE_STRING(MID_STRING(Number,1,5), '07???')) { sep1 = 6; sep2 = 9 }
		}
		
		for (i = 1, j = 1; i <= LENGTH_STRING(Number); i++, j++) {
		    if (i == sep1) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
		    if (i == sep2) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
		    CURRENT_PHONE_NUMBER_SPACED[j] = Number[i]
		}
		SET_LENGTH_STRING(CURRENT_PHONE_NUMBER_SPACED, j-1)
	    }
	    // AMERICA
	    case '1': {
		if (COMPARE_STRING(Number, '1?1') == 1) {
		    CURRENT_PHONE_NUMBER_SPACED = Number
		} else {
		    sep1 = 2
		    sep2 = 5
		    sep3 = 8
		    for (i = 1, j = 1; i <= LENGTH_STRING(Number); i++, j++) {
			if (i == 1) { CURRENT_PHONE_NUMBER_SPACED[j] = '+'; j++ }
			if (i == sep1) { CURRENT_PHONE_NUMBER_SPACED[j] = ' '; j++ }
			if (i == sep2) { CURRENT_PHONE_NUMBER_SPACED[j] = '-'; j++ }
			if (i == sep3) { CURRENT_PHONE_NUMBER_SPACED[j] = '-'; j++ }
			CURRENT_PHONE_NUMBER_SPACED[j] = Number[i]
		    }
		    SET_LENGTH_STRING(CURRENT_PHONE_NUMBER_SPACED, j-1)
		}
	    }
	    default: { CURRENT_PHONE_NUMBER_SPACED = Number }
	}
    } else {
	CURRENT_PHONE_NUMBER_SPACED = Number
    }
    
    TP_BUTTON_TEXT(TP_CALL_DIAL_NUMBER_BOX, CURRENT_PHONE_NUMBER_SPACED)
    TP_BUTTON_TEXT(TP_CALL_PRESETS_NUMBER_BOX, CURRENT_PHONE_NUMBER_SPACED)
}

DEFINE_FUNCTION CURRENT_PHONE_NUMBER_APPEND(INTEGER digit) {
    if (CURRENT_PHONE_NUMBER_INDEX < 32) {
	
	if (digit == 11) { CURRENT_PHONE_NUMBER[CURRENT_PHONE_NUMBER_INDEX] = '*' }
	else if (digit == 12) { CURRENT_PHONE_NUMBER[CURRENT_PHONE_NUMBER_INDEX] = '#' }
	else { CURRENT_PHONE_NUMBER[CURRENT_PHONE_NUMBER_INDEX] = TYPE_CAST($30 + digit) }
	
	CURRENT_PHONE_NUMBER_INDEX = CURRENT_PHONE_NUMBER_INDEX + 1
	SET_LENGTH_STRING(CURRENT_PHONE_NUMBER, CURRENT_PHONE_NUMBER_INDEX - 1)
	SET_NUMBER_BOXES_TO_NUMBER(CURRENT_PHONE_NUMBER)
    }
}
DEFINE_FUNCTION CURRENT_PHONE_NUMBER_BACKSPACE() {
    if (CURRENT_PHONE_NUMBER_INDEX == 1) { return }
    CURRENT_PHONE_NUMBER_INDEX = CURRENT_PHONE_NUMBER_INDEX - 1
    SET_LENGTH_STRING(CURRENT_PHONE_NUMBER, CURRENT_PHONE_NUMBER_INDEX - 1)
    SET_NUMBER_BOXES_TO_NUMBER(CURRENT_PHONE_NUMBER)
}
DEFINE_FUNCTION CURRENT_PHONE_NUMBER_CLEAR() {
    CURRENT_PHONE_NUMBER_INDEX = 1
    SET_LENGTH_STRING(CURRENT_PHONE_NUMBER, 0)
    SET_NUMBER_BOXES_TO_NUMBER(CURRENT_PHONE_NUMBER)
}
DEFINE_FUNCTION CURRENT_PHONE_NUMBER_SET(CHAR Number[]) {
    CURRENT_PHONE_NUMBER = Number
    CURRENT_PHONE_NUMBER_INDEX = LENGTH_STRING(CURRENT_PHONE_NUMBER) + 1
    SET_NUMBER_BOXES_TO_NUMBER(CURRENT_PHONE_NUMBER)
}


DEFINE_FUNCTION TP_BUTTON_SHOW(INTEGER buttonid) {
    SEND_COMMAND dvTP, "'^SHO-',itoa(buttonid),',1'"
}
DEFINE_FUNCTION TP_BUTTON_HIDE(INTEGER buttonid) {
    SEND_COMMAND dvTP, "'^SHO-',itoa(buttonid),',0'"
}
DEFINE_FUNCTION TP_BUTTON_SETSTATE(INTEGER buttonid, INTEGER state) {
    SEND_COMMAND dvTP, "'^ANI-',itoa(buttonid),',0,',itoa(state),',1'"
}
DEFINE_FUNCTION TP_BUTTON_ON(INTEGER buttonid) {
    SEND_COMMAND dvTP, "'^ANI-',itoa(buttonid),',0,2,1'"
}
DEFINE_FUNCTION TP_BUTTON_OFF(INTEGER buttonid) {
    SEND_COMMAND dvTP, "'^ANI-',itoa(buttonid),',0,1,1'"
}
DEFINE_FUNCTION TP_BUTTON_TEXT(INTEGER buttonid, CHAR textval[]) {
    SEND_COMMAND dvTP, "'^TXT-',itoa(buttonid),',0,',textval"
}

DEFINE_FUNCTION TP_SELECT_INPUT(INTEGER buttonid) {
    if (buttonid == TP_CALL) { TP_BUTTON_ON(TP_CALL) } else { TP_BUTTON_OFF(TP_CALL) }
    if (buttonid == TP_ROOMPC) { TP_BUTTON_ON(TP_ROOMPC) } else { TP_BUTTON_OFF(TP_ROOMPC) }
    if (buttonid == TP_VIDYO) { TP_BUTTON_ON(TP_VIDYO) } else { TP_BUTTON_OFF(TP_VIDYO) }
    if (buttonid == TP_APPLETV) { TP_BUTTON_ON(TP_APPLETV) } else { TP_BUTTON_OFF(TP_APPLETV) }
    if (buttonid == TP_HDMI) { TP_BUTTON_ON(TP_HDMI) } else { TP_BUTTON_OFF(TP_HDMI) }
    if (buttonid == TP_VGA) { TP_BUTTON_ON(TP_VGA) } else { TP_BUTTON_OFF(TP_VGA) }
}
DEFINE_FUNCTION TP_SELECT_INPUT_NONE() {
    SEND_COMMAND dvTP, '^ANI-10.15,0,1,1'
}




#end_if