PROGRAM_NAME='Framestore-Master'

#include 'Touchpanel.axi'
#include 'APartConcept1.axi'
#include 'AtlonaATLINE.axi'
#include 'LG_RS232.axi'
#include 'ClearOneInteractPro.axi'
#include 'AppleTV.axi'
#include 'Vidyo.axi'
#include 'SonyCam.axi'


DEFINE_VARIABLE
    INTEGER PHONEBOOK_PAGE = 0
    INTEGER USER_IS_CONTROLLING_VOLUME_SLIDER = 0
    INTEGER USER_IS_CONTROLLING_CALLVOL_SLIDER = 0
    INTEGER USER_IS_CONTROLLING_MICGAIN_SLIDER = 0
    SINTEGER PrevVol = -40


DEFINE_FUNCTION REDRAW_PHONEBOOK() {
    stack_var integer page
    stack_var integer btn
    stack_var integer i
    stack_var integer result
    page = PHONEBOOK_PAGE * 8
    
    for (btn = 0; btn < 8; btn = btn + 1) {
	if (btn + page < CLEARONE_PHONEBOOK_LENGTH) {
	    for (i = 1; i <= CLEARONE_PHONEBOOK_LENGTH; i++) {
		if (CLEARONE_PHONEBOOK[i].PRESET == btn+page+1) {
		    TP_BUTTON_TEXT(btn + TP_CALL_PRESET_0, CLEARONE_PHONEBOOK[i].NAME)
		    break
		}
	    }
	} else {
	    TP_BUTTON_TEXT(btn + TP_CALL_PRESET_0, '--')
	}
    }
}

DEFINE_FUNCTION REDRAW_MATRIX() {
    
    if (CLEARONE_MATRIX_CALLAUDIO == 0) {
	TP_BUTTON_SETSTATE(TP_CALL_ROUTING_CALL_TO_SPEAKERS, 1)
	TP_BUTTON_HIDE(TP_CALL_ROUTING_MIC_CALL)
    } else {
	TP_BUTTON_SETSTATE(TP_CALL_ROUTING_CALL_TO_SPEAKERS, 2)
	TP_BUTTON_SHOW(TP_CALL_ROUTING_MIC_CALL)
    }
    if (CLEARONE_MATRIX_ADDVIDYO == 0) {
	TP_BUTTON_SETSTATE(TP_CALL_ROUTING_ADD_VIDYO, 1)
	TP_BUTTON_HIDE(TP_CALL_ROUTING_MIC_VIDYO)
    } else {
	TP_BUTTON_SETSTATE(TP_CALL_ROUTING_ADD_VIDYO, 2)
	TP_BUTTON_SHOW(TP_CALL_ROUTING_MIC_VIDYO)
    }
    if (CLEARONE_MATRIX_ADDROOMPC == 0) {
	TP_BUTTON_SETSTATE(TP_CALL_ROUTING_ADD_ROOMPC, 1)
	TP_BUTTON_HIDE(TP_CALL_ROUTING_MIC_ROOMPC)
    } else {
	TP_BUTTON_SETSTATE(TP_CALL_ROUTING_ADD_ROOMPC, 2)
	TP_BUTTON_SHOW(TP_CALL_ROUTING_MIC_ROOMPC)
    }
    
    TP_BUTTON_SETSTATE(TP_CALL_ROUTING_MIC_CALL, CLEARONE_MATRIX_MICS_TO_CALL + 1)
    TP_BUTTON_SETSTATE(TP_CALL_ROUTING_MIC_VIDYO, CLEARONE_MATRIX_MICS_TO_VIDYO + 1)
    TP_BUTTON_SETSTATE(TP_CALL_ROUTING_MIC_ROOMPC, CLEARONE_MATRIX_MICS_TO_PC + 1)
}

DEFINE_FUNCTION CALLBACK_TV(CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    if (COMPARE_STRING(event, 'POWER') == 1) {
	TP_BUTTON_TEXT(TP_INFO_TV_POWER, paramStr)
	if (paramInt == 1) {
	    TP_BUTTON_SHOW(TP_POWER)
	    TP_BUTTON_OFF(TP_POWER)
	    TP_BUTTON_SHOW(TP_SCREENBLANK)
	} else {
	    if (AMP_STATE_POWER == AMP_STATE_POWER_OFF) { TP_BUTTON_HIDE(TP_POWER) }
	    TP_BUTTON_HIDE(TP_SCREENBLANK)
	}
	return
    }
    if (COMPARE_STRING(event, 'BLANK') == 1) {
	TP_BUTTON_TEXT(TP_INFO_TV_BLANK, paramStr)
	if (paramInt == 1) { TP_BUTTON_ON(TP_SCREENBLANK) } else { TP_BUTTON_OFF(TP_SCREENBLANK) }
	return
    }
    if (COMPARE_STRING(event, 'INPUT') == 1) {
	TP_BUTTON_TEXT(TP_INFO_TV_INPUT, paramStr)
	return
    }
    if (COMPARE_STRING(event, 'MUTE') == 1) {
	TP_BUTTON_TEXT(TP_INFO_TV_MUTE, paramStr)
	return
    }
    if (COMPARE_STRING(event, 'ASPECT') == 1) {
	TP_BUTTON_TEXT(TP_INFO_TV_ASPECT, paramStr)
	return
    }
}

DEFINE_FUNCTION CALLBACK_AMP(CHAR event[], CHAR paramStr[], SINTEGER paramInt) {
    if (COMPARE_STRING(event, 'MUTE') == 1) {
	TP_BUTTON_TEXT(TP_INFO_AMP_AV_MUTE, paramStr)
	TP_BUTTON_TEXT(TP_INFO_AMP_PREV_VOL, itoa(PrevVol))
	if (paramInt == 1) { TP_BUTTON_ON(TP_MUTE) } else { TP_BUTTON_OFF(TP_MUTE) }
	return
    }
    if (COMPARE_STRING(event, 'VOLUME') == 1) {
	TP_BUTTON_TEXT(TP_INFO_AMP_AV_VOL, paramStr)
	if (USER_IS_CONTROLLING_VOLUME_SLIDER == 0) {
	    SEND_STRING 0:0:0, "'Setting TP Volume to ',itohex(paramInt),'+80'"
	    SEND_LEVEL dvTP, TP_VOLUME, paramInt+80
	}
	return
    }
    if (COMPARE_STRING(event, 'MICVOLUME') == 1) {
	TP_BUTTON_TEXT(TP_INFO_AMP_CALL_VOL, paramStr)
	if (USER_IS_CONTROLLING_CALLVOL_SLIDER == 0) {
	    SEND_STRING 0:0:0, "'Setting TP Call Volume to ',itohex(paramInt),'+80'"
	    SEND_LEVEL dvTP, TP_CALLVOL, paramInt+80
	}
	return
    }
    if (COMPARE_STRING(event, 'MICMUTE') == 1) {
	TP_BUTTON_TEXT(TP_INFO_AMP_CALL_MUTE, paramStr)
	if (USER_IS_CONTROLLING_CALLVOL_SLIDER == 0) {
	    SEND_LEVEL dvTP, TP_CALLVOL, paramInt
	}
	return
    }
    if (COMPARE_STRING(event, 'INPUT') == 1) {
	TP_BUTTON_TEXT(TP_INFO_AMP_INPUT, paramStr)
	return
    }
    if (COMPARE_STRING(event, 'POWER') == 1) {
	if (paramInt == 1) {
	    TP_BUTTON_TEXT(TP_INFO_AMP_POWER, 'On')
	    TP_BUTTON_SHOW(TP_POWER)
	    TP_BUTTON_SHOW(TP_MUTE)
	    TP_BUTTON_SHOW(TP_VOLUME)
	} else {
	    TP_BUTTON_TEXT(TP_INFO_AMP_POWER, 'Off')
	    if (TV_STATE_POWER == TV_STATE_POWER_OFF) { TP_BUTTON_HIDE(TP_POWER) }
	    TP_BUTTON_HIDE(TP_MUTE)
	    TP_BUTTON_HIDE(TP_VOLUME)
	    TP_SELECT_INPUT_NONE()
	}
	return
    }
}

DEFINE_FUNCTION CALLBACK_CLEARONE(CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    if (COMPARE_STRING(event, 'PHONEBOOK') == 1) {
	REDRAW_PHONEBOOK()
    }
    if (COMPARE_STRING(event, 'PHONE_HOOK') == 1) {
	CURRENTLY_IN_CALL = paramInt
	TP_BUTTON_TEXT(TP_INFO_CO_OFFHOOK, paramStr)
	if (CURRENTLY_IN_CALL == 1) {
	    TP_BUTTON_SHOW(TP_CALLDUR)
	    TP_BUTTON_SHOW(TP_ENDCALL)
	    //TP_BUTTON_SHOW(TP_CALLVOL)
	    TP_BUTTON_OFF(TP_CALL_DIAL_CALL)
	    TP_BUTTON_OFF(TP_CALL_PRESETS_CALL)
	    TP_BUTTON_ON(TP_CALL_DIAL_END)
	    TP_BUTTON_ON(TP_CALL_PRESETS_END)
	} else {
	    TP_BUTTON_HIDE(TP_CALLDUR)
	    TP_BUTTON_HIDE(TP_ENDCALL)
	    //TP_BUTTON_HIDE(TP_CALLVOL)
	    TP_BUTTON_ON(TP_CALL_DIAL_CALL)
	    TP_BUTTON_ON(TP_CALL_PRESETS_CALL)
	    TP_BUTTON_OFF(TP_CALL_DIAL_END)
	    TP_BUTTON_OFF(TP_CALL_PRESETS_END)
	}
    }
    if (COMPARE_STRING(event, 'DIALOUT') == 1) {
	TP_BUTTON_TEXT(TP_INFO_CO_LASTNUM, paramStr)
    }
    if (COMPARE_STRING(event, 'CALLDUR') == 1) {
	stack_var char h[2]
	stack_var char m[2]
	stack_var char s[2]
	if (CLEARONE_TimeConnected.Hours < 10) { h = "'0',CLEARONE_TimeConnected.Hours+'0'" } else { h = itoa(CLEARONE_TimeConnected.Hours) }
	if (CLEARONE_TimeConnected.Minutes < 10) { m = "'0',CLEARONE_TimeConnected.Minutes+'0'" } else { m = itoa(CLEARONE_TimeConnected.Minutes) }
	if (CLEARONE_TimeConnected.Seconds < 10) { s = "'0',CLEARONE_TimeConnected.Seconds+'0'" } else { s = itoa(CLEARONE_TimeConnected.Seconds) }
	TP_BUTTON_TEXT(TP_CALLDUR, "h,':',m,':',s")
	TP_BUTTON_TEXT(TP_INFO_CO_CALLDUR, "h,':',m,':',s")
    }
    if (COMPARE_STRING(event, 'MUTE') == 1) {
	
    }
    if (COMPARE_STRING(event, 'MICMUTE') == 1) {
	TP_BUTTON_TEXT(TP_INFO_CO_MUTE, itoa(paramInt))
	TP_BUTTON_SETSTATE(TP_CALL_DIAL_MUTE, paramInt+1)
	TP_BUTTON_SETSTATE(TP_CALL_PRESETS_MUTE, paramInt+1)
    }
    if (COMPARE_STRING(event, 'PHONEBOOK_COUNT') == 1) {
	TP_BUTTON_TEXT(TP_INFO_CO_PHONEBOOK, paramStr)
    }
    if (COMPARE_STRING(event, 'AUTO_ANSWER') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_AUTOANSWER, paramInt+1)
    }
    if (COMPARE_STRING(event, 'ACCOUSTIC_ECHO_CANCELLATION') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_ECHOCANCELLATION, paramInt+1)
    }
    if (COMPARE_STRING(event, 'AUTOMATIC_GAIN_CONTROL') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_AUTOMATICMICGAIN, paramInt+1)
    }
    if (COMPARE_STRING(event, 'COMPRESSION') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_INPUTCOMPRESSION, paramInt+1)
    }
    if (COMPARE_STRING(event, 'NOISE_CANCELLATION') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_NOISECANCELLATION, paramInt+1)
    }
    if (COMPARE_STRING(event, 'DECAY') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_MICGATEDECAY, paramInt)
    }
    if (COMPARE_STRING(event, 'RINGER_ENABLED') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_RINGERENABLE, paramInt+1)
    }
    if (COMPARE_STRING(event, 'CLEAR_EFFECT') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_TELCOCLEAREFFECT, paramInt+1)
    }
    if (COMPARE_STRING(event, 'TELCO_LEVEL_CONTROL') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_TELCOAUTOLEVELCONTROL, paramInt+1)
    }
    if (COMPARE_STRING(event, 'TELCO_LOOPBACK_ECHO_CANCELLATION') == 1) {
	TP_BUTTON_SETSTATE(TP_CALL_SETTINGS_TELCOECHOCANCELLATION, paramInt+1)
    }
    if (COMPARE_STRING(event, 'VOLUME') == 1) {
	if (USER_IS_CONTROLLING_MICGAIN_SLIDER == 0) {
	    SEND_LEVEL dvTP, TP_CALL_SETTINGS_MICGAIN, paramInt
	}
    }
    if (COMPARE_STRING(event, 'MATRIX_UPDATE') == 1) {
	REDRAW_MATRIX()
    }
    if (COMPARE_STRING(event, 'MATRIX') == 1) {
	REDRAW_MATRIX()
    }
    if (COMPARE_STRING(event, 'RING') == 1) {
	if (paramInt == 0) { return }
	SEND_COMMAND dvTP, '@PPN-Ringing'
	SEND_COMMAND dvTP, 'WAKE'
	SEND_COMMAND dvTP, '@SOU-phonecall.wav'
	if (AMP_STATE_POWER == AMP_STATE_POWER_OFF) {
	    AMP_SET_STANDBY(0)
	    WAIT 20 {
		AMP_SET_INPUT('A')
		AMP_SET_MICVOL(-40)
	    }
	}
    }
}




DEFINE_FUNCTION CALLBACK_SIGNED (DEV device, CHAR event[], CHAR paramStr[], SINTEGER paramInt) {
    if (device == dvAmp) {
	CALLBACK_AMP(event, paramStr, paramInt)
    	return
    }
}
DEFINE_FUNCTION CALLBACK (DEV device, CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    if (device == dvTV) {
	CALLBACK_TV(event, paramStr, paramInt)
    	return
    }
    if (device == dvClearOne) {
	CALLBACK_CLEARONE(event, paramStr, paramInt)
    	return
    }
}


DEFINE_EVENT
    
    LEVEL_EVENT[dvTP, TP_VOLUME] {
	if (USER_IS_CONTROLLING_VOLUME_SLIDER == 1) {
	    SEND_STRING 0:0:0, "'Setting Amp Volume to ',itohex(level.value),'-80'"
	    AMP_SET_VOLUME(level.value - 80)
	}
    }
    
    LEVEL_EVENT[dvTP, TP_CALLVOL] {
	if (USER_IS_CONTROLLING_CALLVOL_SLIDER == 1) {
	    SEND_STRING 0:0:0, "'Setting Amp Call Volume to ',itohex(level.value),'-80'"
	    AMP_SET_MICVOL(level.value - 80)
	}
    }
    
    LEVEL_EVENT[dvTP, TP_CALL_SETTINGS_MICGAIN] {
	if (USER_IS_CONTROLLING_MICGAIN_SLIDER == 1) {
	    CLEARONE_MICGAIN(level.value)
	}
    }
    
    BUTTON_EVENT[dvTP, 0] {
	RELEASE: {
	    if ((button.input.channel > 400) and (button.input.channel < 500)) {
		{ OFF[dvVidyo, button.input.channel - 400] }
	    }
	    if ((button.input.channel > 800) and (button.input.channel < 900)) {
		{ OFF[dvCam, button.input.channel - 800] }
	    }
	    
	    SWITCH (button.input.channel) {
		CASE TP_VOLUME: { WAIT 2 { USER_IS_CONTROLLING_VOLUME_SLIDER = 0 } }
		CASE TP_CALLVOL: { WAIT 2 { USER_IS_CONTROLLING_CALLVOL_SLIDER = 0 } }
		CASE TP_CALL_SETTINGS_MICGAIN: { WAIT 2 { USER_IS_CONTROLLING_MICGAIN_SLIDER = 0 } }
		
		CASE TP_ATV_UP: { OFF[dvATV, ATV_IR_UP] }
		CASE TP_ATV_DOWN: { OFF[dvATV, ATV_IR_DOWN] }
		CASE TP_ATV_LEFT: { OFF[dvATV, ATV_IR_LEFT] }
		CASE TP_ATV_RIGHT: { OFF[dvATV, ATV_IR_RIGHT] }
		CASE TP_ATV_MENU: { OFF[dvATV, ATV_IR_MENU] }
		CASE TP_ATV_OK: { OFF[dvATV, ATV_IR_OK] }
		CASE TP_ATV_PLAYPAUSE: { OFF[dvATV, ATV_IR_PLAYPAUSE] }
	    }
	}
	PUSH: {
	    if ((button.input.channel > 400) and (button.input.channel < 500)) {
		{ ON[dvVidyo, button.input.channel - 400] }
	    }
	    if ((button.input.channel > 800) and (button.input.channel < 900)) {
		{ ON[dvCam, button.input.channel - 800] }
	    }
	    SWITCH (button.input.channel) {
		CASE TP_VOLUME: { USER_IS_CONTROLLING_VOLUME_SLIDER = 1 }
		CASE TP_CALLVOL: { USER_IS_CONTROLLING_CALLVOL_SLIDER = 1 }
		CASE TP_CALL_SETTINGS_MICGAIN: { USER_IS_CONTROLLING_MICGAIN_SLIDER = 1 }
		
		CASE TP_ACCEPT_CALL: {
		    CLEARONE_CALL_ANSWER()
		    AMP_SET_STANDBY(0)
		    WAIT 20 {
			AMP_SET_INPUT('A')
			AMP_SET_MICVOL(-40)
		    }
		}
		case TP_DECLINE_CALL: {
		    CLEARONE_CALL_IGNORE()
		}
		
		CASE TP_CALL_DIAL_0:
		CASE TP_CALL_DIAL_1:
		CASE TP_CALL_DIAL_2:
		CASE TP_CALL_DIAL_3:
		CASE TP_CALL_DIAL_4:
		CASE TP_CALL_DIAL_5:
		CASE TP_CALL_DIAL_6:
		CASE TP_CALL_DIAL_7:
		CASE TP_CALL_DIAL_8:
		CASE TP_CALL_DIAL_9:
		CASE TP_CALL_DIAL_STAR:
		CASE TP_CALL_DIAL_HASH: { 
		    if (CURRENTLY_IN_CALL == 1) {
			if (TP_CALL_DIAL_HASH == button.input.channel) { CLEARONE_DIAL('#') }
			else if (TP_CALL_DIAL_STAR == button.input.channel) { CLEARONE_DIAL('*') }
			else { CLEARONE_DIAL("(button.input.channel - TP_CALL_DIAL_0 + '0')") }
		    } else {
			CURRENT_PHONE_NUMBER_APPEND(button.input.channel - TP_CALL_DIAL_0)
		    }
		}
		CASE TP_CALL_DIAL_BACKSPACE: { CURRENT_PHONE_NUMBER_BACKSPACE() }
		CASE TP_CALL_DIAL_CLEAR: { CURRENT_PHONE_NUMBER_CLEAR() }
		
		CASE TP_CALL_PRESETS_CALL:
		CASE TP_CALL_DIAL_CALL: {
		    if ((LENGTH_STRING(CURRENT_PHONE_NUMBER) > 4) and (CURRENT_PHONE_NUMBER[1] != '9')) {
			CLEARONE_DIAL("'9',CURRENT_PHONE_NUMBER")
		    } else {
			CLEARONE_DIAL(CURRENT_PHONE_NUMBER)
		    }
		}
		CASE TP_ENDCALL:
		CASE TP_CALL_PRESETS_END:
		CASE TP_CALL_DIAL_END: {
		    CLEARONE_ENDCALL()
		    CURRENT_PHONE_NUMBER_CLEAR()
		}
		CASE TP_CALL_PRESETS_REDIAL:
		CASE TP_CALL_DIAL_REDIAL: { CLEARONE_REDIAL() }
		CASE TP_CALL_PRESETS_MUTE:
		CASE TP_CALL_DIAL_MUTE: { CLEARONE_MUTE_MICS(CLEARONE_MUTE_TOGGLE) }
		
		CASE TP_CALL_PRESET_0:
		CASE TP_CALL_PRESET_1:
		CASE TP_CALL_PRESET_2:
		CASE TP_CALL_PRESET_3:
		CASE TP_CALL_PRESET_4:
		CASE TP_CALL_PRESET_5:
		CASE TP_CALL_PRESET_6:
		CASE TP_CALL_PRESET_7: {
		    stack_var integer i
		    i = button.input.channel - TP_CALL_PRESET_0
		    i = i + (PHONEBOOK_PAGE * 8)
		    if (i <= CLEARONE_PHONEBOOK_LENGTH) {
			CURRENT_PHONE_NUMBER_SET(CLEARONE_PHONEBOOK[i+1].NUMBER)
		    }
		}
		CASE TP_CALL_PRESET_PREVPAGE: {
		    PHONEBOOK_PAGE = 0
		    TP_BUTTON_HIDE(TP_CALL_PRESET_PREVPAGE)
		    TP_BUTTON_SHOW(TP_CALL_PRESET_NEXTPAGE)
		    REDRAW_PHONEBOOK()
		}
		CASE TP_CALL_PRESET_NEXTPAGE: {
		    PHONEBOOK_PAGE = 1
		    TP_BUTTON_SHOW(TP_CALL_PRESET_PREVPAGE)
		    TP_BUTTON_HIDE(TP_CALL_PRESET_NEXTPAGE)
		    REDRAW_PHONEBOOK()
		}
		
		CASE TP_CALL_SETTINGS_AUTOANSWER: { CLEARONE_AUTOANSWER(2) }
		CASE TP_CALL_SETTINGS_AUTOMATICMICGAIN: { CLEARONE_AUTOMATICGAIN(2) }
		CASE TP_CALL_SETTINGS_ECHOCANCELLATION: { CLEARONE_ECHOCANCELLATION(2) }
		CASE TP_CALL_SETTINGS_INPUTCOMPRESSION: { CLEARONE_INPUTCOMPRESSION(2) }
		CASE TP_CALL_SETTINGS_MICGATEDECAY: {
		    switch (CLEARONE_MICGATE_LAST) { 
			case 1: { CLEARONE_MICROPHONEDECAY(2) }
			case 2: { CLEARONE_MICROPHONEDECAY(3) }
			case 3: { CLEARONE_MICROPHONEDECAY(1) }
		    }
		}
		CASE TP_CALL_SETTINGS_NOISECANCELLATION: { CLEARONE_NOISECANCELLATION(2) }
		CASE TP_CALL_SETTINGS_RINGERENABLE: { CLEARONE_RINGER(2) }
		CASE TP_CALL_SETTINGS_TELCOAUTOLEVELCONTROL: { CLEARONE_TELCOLEVELCONTROL(2) }
		CASE TP_CALL_SETTINGS_TELCOCLEAREFFECT: { CLEARONE_CLEAREFFECT(2) }
		CASE TP_CALL_SETTINGS_TELCOECHOCANCELLATION: { CLEARONE_TELCOECHOCANCELLATION(2) }
		
		

		CASE TP_CALL_ROUTING_MIC_CALL: {
		    if (CLEARONE_MATRIX_MICS_TO_CALL == 0) { CLEARONE_ROUTING_MICS_TO_CALL(1) }
		    else { CLEARONE_ROUTING_MICS_TO_CALL(0) }
		}
		CASE TP_CALL_ROUTING_MIC_ROOMPC: {
		    if (CLEARONE_MATRIX_MICS_TO_PC == 0) { CLEARONE_ROUTING_MICS_TO_ROOMPC(1) }
		    else { CLEARONE_ROUTING_MICS_TO_ROOMPC(0) }
		}
		CASE TP_CALL_ROUTING_MIC_VIDYO: {
		    if (CLEARONE_MATRIX_MICS_TO_VIDYO == 0) { CLEARONE_ROUTING_MICS_TO_VIDYO(1) }
		    else { CLEARONE_ROUTING_MICS_TO_VIDYO(0) }
		}
		CASE TP_CALL_ROUTING_CALL_TO_SPEAKERS: {
		    if (CLEARONE_MATRIX_CALLAUDIO == 0) { CLEARONE_ROUTING_ADD_CALL_AUDIO(1) }
		    else { CLEARONE_ROUTING_ADD_CALL_AUDIO(0) }
		}
		CASE TP_CALL_ROUTING_ADD_ROOMPC: {
		    if (CLEARONE_MATRIX_ADDROOMPC == 0) { CLEARONE_ROUTING_ADD_ROOMPC(1) }
		    else { CLEARONE_ROUTING_ADD_ROOMPC(0) }
		}
		CASE TP_CALL_ROUTING_ADD_VIDYO: {
		    if (CLEARONE_MATRIX_ADDVIDYO == 0) { CLEARONE_ROUTING_ADD_VIDYO(1) }
		    else { CLEARONE_ROUTING_ADD_VIDYO(0) }
		}
		CASE TP_CALL_ROUTING_RESET: { CLEARONE_ROUTING_CLEAR_TO_DEFAULTS() }
		
		
		CASE TP_ATV_UP: { ON[dvATV, ATV_IR_UP] }
		CASE TP_ATV_DOWN: { ON[dvATV, ATV_IR_DOWN] }
		CASE TP_ATV_LEFT: { ON[dvATV, ATV_IR_LEFT] }
		CASE TP_ATV_RIGHT: { ON[dvATV, ATV_IR_RIGHT] }
		CASE TP_ATV_MENU: { ON[dvATV, ATV_IR_MENU] }
		CASE TP_ATV_OK: { ON[dvATV, ATV_IR_OK] }
		CASE TP_ATV_PLAYPAUSE: { ON[dvATV, ATV_IR_PLAYPAUSE] }
		
		CASE TP_HELP1_TURNONTV: {
		    TV_POWER_ON()
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    WAIT 50 {
			TV_BLANK_OFF()
			WAIT 10 { TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_1) }
			WAIT 30 { TV_MISC(TV_MISC_OSD_OFF) }
			WAIT 40 { TV_MUTE_ON() }
			WAIT 50 { 
			    SWITCHER_SET_OUTPUT_EDID(SWITCHER_EDID_1080p_50)
			    SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_OFF)
			    SWITCHER_SET_INPUT(SWITCHER_INPUT_HDMI1)
			}
			WAIT 60 {
			    SWITCHER_SET_OSD_TIMEOUT(3)
			    SWITCHER_SET_PICTUREMODE(SWITCHER_PICTUREMODE_STANDARD)
			    SWITCHER_SET_SIZE(SWITCHER_SIZE_FULL)
			    SWITCHER_KEY_AUTO()
			}
		    }
		}
		CASE TP_HELP1_TURNONAVR: {
		    AMP_SET_STANDBY(0)
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    WAIT 40 {
			AMP_SET_ECHO_INIT('OFF')
			AMP_SET_ECHO('OFF')
			AMP_SET_HEADER('OFF')
			AMP_SET_AUTO_LOUDNESS(1)
			AMP_SET_BACKSPACE('OFF')
			AMP_SET_EQ_BASS(0)
			AMP_SET_EQ_TREBLE(0)
			AMP_SET_INPUT('A')
			AMP_SET_LINEFEED('OFF')
			AMP_SET_MICVOL(-40)
			AMP_SET_MULTIZONE(0)
			AMP_SET_PAGING_ACTIVE(0)
			AMP_SET_VALUE_FEEDBACK('ON')
			AMP_SET_VOLUME(-40)
			AMP_SET_ZONELINK(0)
		    }
		    WAIT 50 { 
			SWITCHER_SET_OUTPUT_EDID(SWITCHER_EDID_NATIVE)
		    }
		    WAIT 55 { 
			SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_OFF)
		    }
		    WAIT 60 { 
			SWITCHER_SET_INPUT(SWITCHER_INPUT_HDMI1)
		    }
		    WAIT 70 {
			SWITCHER_SET_OSD_TIMEOUT(3)
		    }
		    WAIT 75 {
			SWITCHER_SET_PICTUREMODE(SWITCHER_PICTUREMODE_STANDARD)
		    }
		    WAIT 80 {
			SWITCHER_SET_SIZE(SWITCHER_SIZE_FULL)
		    }
		    WAIT 85 {
			SWITCHER_KEY_AUTO()
		    }
		}
		CASE TP_HELP1_CALL: {
		    if (CLEARONE_PHONEBOOK_LENGTH >= 1) {
			AMP_SET_STANDBY(0)
			WAIT 20 {
			    AMP_SET_INPUT('A')
			    AMP_SET_MICVOL(-40)
			}
			CLEARONE_DIAL(CLEARONE_PHONEBOOK[1].NUMBER)
		    }
		}
		
		CASE TP_CALL: {
		    AMP_SET_STANDBY(0)
		    WAIT 20 {
			AMP_SET_INPUT('A')
			AMP_SET_MICVOL(-32)
		    }
		}
		CASE TP_ROOMPC: {
		    AMP_SET_STANDBY(0)
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    TV_POWER_ON()
		    WAIT 20 {
			AMP_SET_INPUT('A')
			AMP_SET_VOLUME(-30)
			SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_ON)
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_1)
		    }
		    WAIT 230 {
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_1)
		    }
		    WAIT 235 {
		        TV_BLANK_OFF()
		    }
		}
		CASE TP_VIDYO: {
		    AMP_SET_STANDBY(0)
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    if (TV_STATE_POWER == TV_STATE_POWER_OFF) {
			SEND_COMMAND dvTP, '@PPN-PleaseWait'
		    }
		    TV_POWER_ON()
		    WAIT 20 {
			SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_OFF)
			AMP_SET_INPUT('A')
			AMP_SET_VOLUME(-30)
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 30 {
			SWITCHER_SET_INPUT(SWITCHER_INPUT_HDMI2)
		    }
		    WAIT 230 {
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 235 {
		        TV_BLANK_OFF()
		    }
		    ON[dvVidyo, 7] // Home
		    WAIT 8 { OFF[dvVidyo, 7] }
		}
		CASE TP_APPLETV: {
		    AMP_SET_STANDBY(0)
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    if (TV_STATE_POWER == TV_STATE_POWER_OFF) {
			SEND_COMMAND dvTP, '@PPN-PleaseWait'
		    }
		    TV_POWER_ON()
		    WAIT 20 {
			SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_OFF)
			AMP_SET_INPUT('A')
			AMP_SET_VOLUME(-30)
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 30 {
			SWITCHER_SET_INPUT(SWITCHER_INPUT_HDMI3)
		    }
		    WAIT 230 {
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 235 {
		        TV_BLANK_OFF()
		    }
		    ON[dvATV, ATV_IR_MENU]
		    WAIT 8 { OFF[dvATV, ATV_IR_MENU] }
		}
		CASE TP_HDMI: {
		    AMP_SET_STANDBY(0)
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    if (TV_STATE_POWER == TV_STATE_POWER_OFF) {
			SEND_COMMAND dvTP, '@PPN-PleaseWait'
		    }
		    TV_POWER_ON()
		    WAIT 20 {
			SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_OFF)
			AMP_SET_INPUT('A')
			AMP_SET_VOLUME(-30)
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 30 {
			SWITCHER_SET_INPUT(SWITCHER_INPUT_HDMI4)
		    }
		    WAIT 230 {
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 235 {
		        TV_BLANK_OFF()
		    }
		}
		CASE TP_VGA: {
		    AMP_SET_STANDBY(0)
		    SWITCHER_SET_POWER(SWITCHER_POWER_ON)
		    if (TV_STATE_POWER == TV_STATE_POWER_OFF) {
			SEND_COMMAND dvTP, '@PPN-PleaseWait'
		    }
		    TV_POWER_ON()
		    WAIT 20 {
			SWITCHER_SET_AUDIO_MUTE(SWITCHER_AUDIO_MUTE_OFF)
			AMP_SET_INPUT('A')
			AMP_SET_VOLUME(-30)
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 30 {
			SWITCHER_SET_INPUT(SWITCHER_INPUT_VGA1)
		    }
		    WAIT 230 {
			TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_2)
		    }
		    WAIT 235 {
		        TV_BLANK_OFF()
		    }
		    WAIT 40 {
			SWITCHER_KEY_AUTO()
		    }
		}
		
		CASE TP_POWER: {
		    TV_INPUT(TV_IN_HDMI_DTV_AUTO_INPUT_1)
		    if (CURRENTLY_IN_CALL == 0) {
			AMP_SET_STANDBY(1)
		    }
		    SWITCHER_SET_POWER(SWITCHER_POWER_OFF)
		    WAIT 5 {
		        TV_BLANK_ON()
		    }
		    WAIT 15 {
			TV_POWER_OFF()
		    }
		}
		CASE TP_SCREENBLANK: {
		    if (TV_STATE_BLANK == TV_STATE_BLANK_OFF) {
			TV_BLANK_ON()
			TP_BUTTON_ON(TP_SCREENBLANK)
		    } else {
			TV_BLANK_OFF()
			TP_BUTTON_OFF(TP_SCREENBLANK)
		    }
		}
		CASE TP_MUTE: {
		    if (AMP_STATE_MUTE == AMP_STATE_MUTE_OFF) {
			PrevVol = AMP_STATE_VOLUME
			AMP_SET_VOLUME(-80)
			TP_BUTTON_ON(TP_MUTE)
		    } else {
			AMP_SET_VOLUME(PrevVol)
			TP_BUTTON_OFF(TP_MUTE)
		    }
		}
	    }
	}
    }
