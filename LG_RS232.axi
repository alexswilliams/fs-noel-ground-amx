PROGRAM_NAME='LG_RS232'

#if_not_defined __LG_RS232__
#define __LG_RS232__


DEFINE_DEVICE

    dvTV = 5001:2:1
    

DEFINE_CONSTANT

    // INPUT SELECTION
    TV_IN_DTV_INPUT_1_ANTENNA		= '00'
    TV_IN_DTV_INPUT_2_CABLE		= '01'
    TV_IN_ANALOGUE_INPUT_1_ANTENNA	= '10'
    TV_IN_ANALOGUE_INPUT_2_CABLE	= '11'
    TV_IN_AV_INPUT_1			= '20'
    TV_IN_AV_INPUT_2			= '21'
    TV_IN_S_VIDEO_INPUT_1		= '30'
    TV_IN_COMPONENT_INPUT_1		= '40'
    TV_IN_COMPONENT_INPUT_2		= '41'
    TV_IN_RGB_DTV_INPUT_1		= '50'
    TV_IN_RGB_PC_INPUT_1		= '60'
    TV_IN_DVI_DTV_INPUT_1		= '70'
    TV_IN_DVI_PC_INPUT_1		= '80'
    TV_IN_HDMI_DTV_AUTO_INPUT_1		= '90'
    TV_IN_HDMI_DTV_AUTO_INPUT_2		= '91'
    TV_IN_HDMI_DTV_AUTO_INPUT_3		= '92'
    TV_IN_HDMI_DTV_AUTO_INPUT_4		= '93'
    TV_IN_HDMI_PC_INPUT_1		= 'a0'

    xTV_IN_DTV_INPUT_1_ANTENNA		= $00
    xTV_IN_DTV_INPUT_2_CABLE		= $01
    xTV_IN_ANALOGUE_INPUT_1_ANTENNA	= $10
    xTV_IN_ANALOGUE_INPUT_2_CABLE	= $11
    xTV_IN_AV_INPUT_1			= $20
    xTV_IN_AV_INPUT_2			= $21
    xTV_IN_S_VIDEO_INPUT_1		= $30
    xTV_IN_COMPONENT_INPUT_1		= $40
    xTV_IN_COMPONENT_INPUT_2		= $41
    xTV_IN_RGB_DTV_INPUT_1		= $50
    xTV_IN_RGB_PC_INPUT_1		= $60
    xTV_IN_DVI_DTV_INPUT_1		= $70
    xTV_IN_DVI_PC_INPUT_1		= $80
    xTV_IN_HDMI_DTV_AUTO_INPUT_1	= $91
    xTV_IN_HDMI_DTV_AUTO_INPUT_2	= $92
    xTV_IN_HDMI_DTV_AUTO_INPUT_3	= $93
    xTV_IN_HDMI_DTV_AUTO_INPUT_4	= $94
    xTV_IN_HDMI_PC_INPUT_1		= $a0

    TV_ASPECT_NORMAL_4_3		= '01'
    TV_ASPECT_WIDE_16_9			= '02'
    TV_ASPECT_HORIZON_SPECTACLE		= '03'
    TV_ASPECT_ZOOM_1			= '04'
    TV_ASPECT_ZOOM_2			= '05'
    TV_ASPECT_AUTO			= '06'
    TV_ASPECT_14_9			= '07'
    TV_ASPECT_FULL			= '08'
    TV_ASPECT_JUST_SCAN_1_1_PIXELS	= '09'
    TV_ASPECT_ZOOM_3			= '0a'
    TV_ASPECT_FULL_WIDE			= '0b'
    TV_ASPECT_CINEMA_ZOOM_1		= '10'
    TV_ASPECT_CINEMA_ZOOM_16		= '1f'

    xTV_ASPECT_NORMAL_4_3		= $01
    xTV_ASPECT_WIDE_16_9		= $02
    xTV_ASPECT_HORIZON_SPECTACLE	= $03
    xTV_ASPECT_ZOOM_1			= $04
    xTV_ASPECT_ZOOM_2			= $05
    xTV_ASPECT_AUTO			= $06
    xTV_ASPECT_14_9			= $07
    xTV_ASPECT_FULL			= $08
    xTV_ASPECT_JUST_SCAN_1_1_PIXELS	= $09
    xTV_ASPECT_ZOOM_3			= $0a
    xTV_ASPECT_FULL_WIDE		= $0b
    xTV_ASPECT_CINEMA_ZOOM_1		= $10
    xTV_ASPECT_CINEMA_ZOOM_16		= $1f


    TV_MISC_OSD_OFF			= 'kl 01 00'
    TV_MISC_OSD_ON			= 'kl 01 01'
    TV_MISC_REMOTE_LOCK_OFF		= 'km 01 00'
    TV_MISC_REMOTE_LOCK_ON		= 'km 01 01'
    TV_MISC_MENU			= 'mc 01 43'
    TV_MISC_ENTER			= 'mc 01 44'
    TV_MISC_INFO			= 'mc 01 aa'

    TV_STATE_UNKNOWN = $fe
    TV_STATE_MUTE_ON = 1
    TV_STATE_MUTE_OFF = 0
    TV_STATE_POWER_ON = 1
    TV_STATE_POWER_OFF = 0
    TV_STATE_BLANK_ON = 1
    TV_STATE_BLANK_OFF = 0
    TV_STATE_INPUT_NO_SIGNAL = $ff
    


DEFINE_VARIABLE
    CHAR bTV_Baud_Set = 'f'
    CHAR bufTV[256]
    INTEGER TV_CRPOS
    CHAR TV_BUFOUT[32]
    INTEGER TV_BUFINT
    INTEGER TV_COUNTER
    CHAR TV_CMD
    
    INTEGER TV_STATE_INPUT = TV_STATE_UNKNOWN
    INTEGER TV_STATE_POWER = TV_STATE_UNKNOWN
    INTEGER TV_STATE_MUTE = TV_STATE_UNKNOWN
    INTEGER TV_STATE_BLANK = TV_STATE_UNKNOWN
    INTEGER TV_STATE_ASPECT = TV_STATE_UNKNOWN

    LONG TV_TIMELINE[5] = {7000, 300, 300, 300, 300}


DEFINE_FUNCTION TV_CALLBACK(DEV device, CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    //SEND_STRING 0:0:0, "'TV - ',event,': ',paramStr, '(',itohex(paramInt),')'"
    
    if (COMPARE_STRING(event, 'INPUT') == 1) {
	TV_STATE_INPUT = paramInt
    } else if (COMPARE_STRING(event, 'POWER') == 1) {
	TV_STATE_POWER = paramInt
    } else if (COMPARE_STRING(event, 'MUTE') == 1) {
	TV_STATE_MUTE = paramInt
    } else if (COMPARE_STRING(event, 'BLANK') == 1) {
	//SEND_STRING 0:0:0, "'Setting TV_STATE_BLANK to ', itoa(paramInt)"
	TV_STATE_BLANK = paramInt
    } else if (COMPARE_STRING(event, 'ASPECT') == 1) {
	TV_STATE_ASPECT = paramInt
    } else {
	SEND_STRING 0:0:0, "'TV - Unknown Parameter'"
    }
    CALLBACK(device, event, paramStr, paramInt)
}


DEFINE_FUNCTION TV_SET_BAUD() {
    if (bTV_Baud_Set == 't') { return }
    bTV_Baud_Set = 't'
    SEND_COMMAND dvTV, 'SET BAUD 9600,N,8,1'
}

// POWER COMMANDS
DEFINE_FUNCTION TV_POWER_ON() {
    SEND_STRING dvTV, "'ka 01 01',$0d"
    WAIT 3 { SEND_STRING dvTV, "'ka 01 01',$0d" }
}
DEFINE_FUNCTION TV_POWER_OFF() {
    SEND_STRING dvTV, "'ka 01 00',$0d"
    WAIT 3 { SEND_STRING dvTV, "'ka 01 00',$0d" }
}
DEFINE_FUNCTION TV_POWER_QUERY() {SEND_STRING dvTV, "'ka 01 ff',$0d"}


// MUTE COMMANDS
DEFINE_FUNCTION TV_MUTE_ON() {SEND_STRING dvTV, "'ke 01 00',$0d"}
DEFINE_FUNCTION TV_MUTE_OFF() {SEND_STRING dvTV, "'ke 01 01',$0d"}
DEFINE_FUNCTION TV_MUTE_QUERY() {SEND_STRING dvTV, "'ke 01 ff',$0d"}

// SCREEN BLANK COMMANDS
DEFINE_FUNCTION TV_BLANK_ON() {
    SEND_STRING dvTV, "'kd 01 01',$0d"
    WAIT 3 { SEND_STRING dvTV, "'kd 01 01',$0d" }
}
DEFINE_FUNCTION TV_BLANK_OFF() {
    SEND_STRING dvTV, "'kd 01 00',$0d"
    WAIT 3 { SEND_STRING dvTV, "'kd 01 00',$0d" }
}
DEFINE_FUNCTION TV_BLANK_QUERY() {SEND_STRING dvTV, "'kd 01 ff',$0d"}

// INPUT COMMANDS
DEFINE_FUNCTION TV_INPUT(CHAR Input[]) {SEND_STRING dvTV, "'xb 01 ',Input,$0d"}
DEFINE_FUNCTION TV_INPUT_QUERY() {SEND_STRING dvTV, "'xb 01 ff',$0d"}

// ASPECT COMMANDS
DEFINE_FUNCTION TV_ASPECT(CHAR Input[]) {SEND_STRING dvTV, "'kc 01 ',Input,$0d"}
DEFINE_FUNCTION TV_ASPECT_QUERY() {SEND_STRING dvTV, "'kc 01 ff',$0d"}



// MISC COMMANDS (MENU, CURSOR, ETC)
DEFINE_FUNCTION TV_MISC(CHAR Input[]) {SEND_STRING dvTV, "Input,$0d"}



DEFINE_START
    CREATE_BUFFER dvTV, bufTV


DEFINE_EVENT


    DATA_EVENT[dvTV] {
	STRING: {
	    //SEND_STRING 0:0:0, "'TV Buffer: ', bufTV"
	    
	    TV_COUNTER = 0
	    TV_CRPOS = FIND_STRING(bufTV, "'x'", 1)
	    
	    while (TV_CRPOS > 0) {
		TV_CMD = GET_BUFFER_CHAR(bufTV)
		TV_COUNTER = TV_COUNTER + 1
		//SEND_STRING 0:0:0, "'TV Buffer CMD: ', TV_CMD"
		if (TV_COUNTER == 256) { break }
		if ((TV_CMD < 'a') or (TV_CMD > 'e')) { continue }
		TV_CRPOS = FIND_STRING(bufTV, "'x'", 1)
		TV_BUFOUT = GET_BUFFER_STRING(bufTV, TV_CRPOS)
		TV_BUFINT = HEXTOI(MID_STRING(TV_BUFOUT, 7, 2))
		
		// 'a 01 OK01x'
		// '-123456789'
		
		switch (TV_CMD) {
		    case 'a': {	// Power
			switch (TV_BUFINT) {
			case 0: { TV_CALLBACK(dvTV, 'POWER', 'Off', 0) }
			case 1: { TV_CALLBACK(dvTV, 'POWER', 'On', 1) }
			}
		    }
		    case 'b': {	// Input
			if (TV_BUFOUT[5] == 'N') {
			    TV_CALLBACK(dvTV, 'INPUT', 'No Signal', $ff)
			} else {
			    switch (TV_BUFINT) {
			    case xTV_IN_DTV_INPUT_1_ANTENNA: { TV_CALLBACK(dvTV, 'INPUT', 'DTV (Antenna)', TV_BUFINT) }
			    case xTV_IN_DTV_INPUT_2_CABLE: { TV_CALLBACK(dvTV, 'INPUT', 'DTV (Cable)', TV_BUFINT) }
			    case xTV_IN_ANALOGUE_INPUT_1_ANTENNA: { TV_CALLBACK(dvTV, 'INPUT', 'Analogue TV (Antenna)', TV_BUFINT) }
			    case xTV_IN_ANALOGUE_INPUT_2_CABLE: { TV_CALLBACK(dvTV, 'INPUT', 'Analogue TV (Cable)', TV_BUFINT) }
			    case xTV_IN_AV_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'AV 1', TV_BUFINT) }
			    case xTV_IN_AV_INPUT_2: { TV_CALLBACK(dvTV, 'INPUT', 'AV 2', TV_BUFINT) }
			    case xTV_IN_S_VIDEO_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'S-Video', TV_BUFINT) }
			    case xTV_IN_COMPONENT_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'Component 1', TV_BUFINT) }
			    case xTV_IN_COMPONENT_INPUT_2: { TV_CALLBACK(dvTV, 'INPUT', 'Component 2', TV_BUFINT) }
			    case xTV_IN_RGB_DTV_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'RGB (TV)', TV_BUFINT) }
			    case xTV_IN_RGB_PC_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'RGB (PC)', TV_BUFINT) }
			    case xTV_IN_DVI_DTV_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'DVI (TV)', TV_BUFINT) }
			    case xTV_IN_DVI_PC_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'DVI (PC)', TV_BUFINT) }
			    case xTV_IN_HDMI_DTV_AUTO_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'HDMI 1', TV_BUFINT) }
			    case xTV_IN_HDMI_DTV_AUTO_INPUT_2: { TV_CALLBACK(dvTV, 'INPUT', 'HDMI 2', TV_BUFINT) }
			    case xTV_IN_HDMI_DTV_AUTO_INPUT_3: { TV_CALLBACK(dvTV, 'INPUT', 'HDMI 3', TV_BUFINT) }
			    case xTV_IN_HDMI_DTV_AUTO_INPUT_4: { TV_CALLBACK(dvTV, 'INPUT', 'HDMI 4', TV_BUFINT) }
			    case xTV_IN_HDMI_PC_INPUT_1: { TV_CALLBACK(dvTV, 'INPUT', 'HDMI PC', TV_BUFINT) }
			    }
			}
		    }
		    case 'c': {	// Aspect Ratio
			if (TV_BUFOUT[5] == 'N') {
			    TV_CALLBACK(dvTV, 'ASPECT', 'Unknown', $ff)
			} else {
			    switch (TV_BUFINT) {
			    case xTV_ASPECT_NORMAL_4_3: { TV_CALLBACK(dvTV, 'ASPECT', 'Normal (4:3)', TV_BUFINT) }
			    case xTV_ASPECT_WIDE_16_9: { TV_CALLBACK(dvTV, 'ASPECT', 'Wide (16:9)', TV_BUFINT) }
			    case xTV_ASPECT_HORIZON_SPECTACLE: { TV_CALLBACK(dvTV, 'ASPECT', 'Horizon (Spectacle)', TV_BUFINT) }
			    case xTV_ASPECT_ZOOM_1: { TV_CALLBACK(dvTV, 'ASPECT', 'Zoom 1', TV_BUFINT) }
			    case xTV_ASPECT_ZOOM_2: { TV_CALLBACK(dvTV, 'ASPECT', 'Zoom 2', TV_BUFINT) }
			    case xTV_ASPECT_AUTO: { TV_CALLBACK(dvTV, 'ASPECT', 'Auto', TV_BUFINT) }
			    case xTV_ASPECT_14_9: { TV_CALLBACK(dvTV, 'ASPECT', '14:9', TV_BUFINT) }
			    case xTV_ASPECT_FULL: { TV_CALLBACK(dvTV, 'ASPECT', 'Full', TV_BUFINT) }
			    case xTV_ASPECT_JUST_SCAN_1_1_PIXELS: { TV_CALLBACK(dvTV, 'ASPECT', 'Just Scan (1x1 pixels)', TV_BUFINT) }
			    case xTV_ASPECT_ZOOM_3: { TV_CALLBACK(dvTV, 'ASPECT', 'Zoom 3', TV_BUFINT) }
			    case xTV_ASPECT_FULL_WIDE: { TV_CALLBACK(dvTV, 'ASPECT', 'Full Wide', TV_BUFINT) }
			    case xTV_ASPECT_CINEMA_ZOOM_1: { TV_CALLBACK(dvTV, 'ASPECT', 'Cinema Zoom 1', TV_BUFINT) }
			    case xTV_ASPECT_CINEMA_ZOOM_16: { TV_CALLBACK(dvTV, 'ASPECT', 'Cinema Zoom 16', TV_BUFINT) }
			    }
			}
		    }
		    case 'd': {	// Blank
			switch (TV_BUFINT) {
			case $ff:
			case 0: { TV_CALLBACK(dvTV, 'BLANK', 'Off', 0) }
			case 1: { TV_CALLBACK(dvTV, 'BLANK', 'On', 1) }
			}
		    }
		    case 'e': {	// Mute
			switch (TV_BUFINT) {
			case $ff:
			case 0: { TV_CALLBACK(dvTV, 'MUTE', 'On', 1) }
			case 1: { TV_CALLBACK(dvTV, 'MUTE', 'Off', 0) }
			}
		    }
		}
		TV_CRPOS = FIND_STRING(bufTV, "'x'", 1)
	    }
	}
    }


    TIMELINE_EVENT[3] {
	switch (timeline.sequence) {
	    case 1: { TV_POWER_QUERY() 			}
	    case 2: { TV_INPUT_QUERY() 			}
	    case 3: { TV_MUTE_QUERY() 			}
	    case 4: { TV_BLANK_QUERY() 			}
	    case 5: { TV_ASPECT_QUERY() 		}
	}
    }
    
DEFINE_START
    TV_SET_BAUD()
    TIMELINE_CREATE(3, TV_TIMELINE, 5, TIMELINE_RELATIVE, TIMELINE_REPEAT)
    

#end_if