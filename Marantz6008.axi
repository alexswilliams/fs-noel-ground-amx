PROGRAM_NAME='Marantz6008'

#if_not_defined __MARANTZ6008__
#define __MARANTZ6008__


DEFINE_DEVICE
    
    dvAVR = 5001:1:1
    

DEFINE_CONSTANT

    AVR_PHONO		= 'PHONO'
    AVR_CD		= 'CD'
    AVR_DVD		= 'DVD'
    AVR_BD		= 'BD'
    AVR_TV		= 'TV'
    AVR_SATCBL		= 'SAT/CBL'
    AVR_MPLAY		= 'MPLAY'
    AVR_GAME		= 'GAME'
    AVR_TUNER		= 'TUNER'
    AVR_SPOTIFY		= 'SPOTIFY'
    AVR_SIRIUSXM	= 'SIRIUSXM'	// UNITED STATES ONLY
    AVR_PANDORA		= 'PANDORA'	// UNITED STATES ONLY
    AVR_FLICKR		= 'FLICKR'
    AVR_IRADIO		= 'IRADIO'
    AVR_SERVER		= 'SERVER'
    AVR_FAVORITES	= 'FAVORITES'
    AVR_AUX1		= 'AUX1'
    AVR_AUX2		= 'AUX2'
    AVR_NET		= 'NET'
    AVR_M_XPORT		= 'M-XPORT'
    AVR_USBIPOD		= 'USB/IPOD'
    AVR_USB		= 'USB'
    AVR_IPD		= 'IPD'		// Select USB and play iPod DIRECT
    AVR_IRP		= 'IRP'		// Select Internet Radio and play Recent
    AVR_FVP		= 'FVP'		// Select NETWORK and play Favourites
    
    AVR_SUR_MOVIE	= 'MOVIE'
    AVR_SUR_MUSIC	= 'MUSIC'
    AVR_SUR_GAME	= 'GAME'
    AVR_SUR_DIRECT	= 'DIRECT'
    AVR_SUR_PURE_DIRECT	= 'PURE DIRECT'
    AVR_SUR_STEREO	= 'STEREO'
    AVR_SUR_AUTO	= 'AUTO'
    AVR_SUR_DOLBY	= 'DOLBY DIGITAL'
    AVR_SUR_DTS		= 'DTS SURROUND'
    AVR_SUR_MULCHAN_ST	= 'MCH STEREO'
    AVR_SUR_VIRTUAL	= 'VIRTUAL'
    
    AVR_PM_OFF		= 'OFF'
    AVR_PM_STANDARD	= 'STD'
    AVR_PM_MOVIE	= 'MOV'
    AVR_PM_VIVID	= 'VVD'
    AVR_PM_STREAM	= 'STM'
    AVR_PM_CUSTOM	= 'CTM'
    
    AVR_MISC_UP		= 'MNCUP'
    AVR_MISC_DOWN	= 'MNCDN'
    AVR_MISC_LEFT	= 'MNCLT'
    AVR_MISC_RIGHT	= 'MNCRT'
    AVR_MISC_ENTER	= 'MNENT'
    AVR_MISC_CANCEL	= 'MNRTN'
    AVR_MISC_MENU_ON	= 'MNMEN ON'
    AVR_MISC_MENU_OFF	= 'MNMEN OFF'
    AVR_MISC_OPTION	= 'MNOPT'
    AVR_MISC_INFO	= 'MNINF'
    AVR_MISC_TRIGGER_ON		= 'TR1 ON'
    AVR_MISC_TRIGGER_OFF	= 'TR1 OFF'
    AVR_MISC_REMOTE_LOCK_ON	= 'SYREMOTE LOCK ON'
    AVR_MISC_REMOTE_LOCK_OFF	= 'SYREMOTE LOCK OFF'
    AVR_MISC_PANEL_LOCK_ON	= 'SYPANEL LOCK ON'
    AVR_MISC_PANEL_VOL_LOCK_ON	= 'SYPANEL+V LOCK ON'
    AVR_MISC_PANEL_LOCK_OFF	= 'SYPANEL LOCK ON'


    AVR_STATE_UNKNOWN = $fd
    
    AVR_STATE_INPUT_PHONO = 1
    AVR_STATE_INPUT_CD = 2
    AVR_STATE_INPUT_DVD = 3
    AVR_STATE_INPUT_BD = 4
    AVR_STATE_INPUT_TV = 5
    AVR_STATE_INPUT_SATCBL = 6
    AVR_STATE_INPUT_MPLAY = 7
    AVR_STATE_INPUT_GAME = 8
    AVR_STATE_INPUT_TUNER = 9
    AVR_STATE_INPUT_SPOTIFY = 10
    AVR_STATE_INPUT_SIRIUSXM = 11
    AVR_STATE_INPUT_PANDORA = 12
    AVR_STATE_INPUT_FLICKR = 13
    AVR_STATE_INPUT_IRADIO = 14
    AVR_STATE_INPUT_SERVER = 15
    AVR_STATE_INPUT_FAVORITES = 16
    AVR_STATE_INPUT_AUX1 = 17
    AVR_STATE_INPUT_AUX2 = 18
    AVR_STATE_INPUT_NET = 19
    AVR_STATE_INPUT_M_XPORT = 20
    AVR_STATE_INPUT_USBIPOD = 21
    AVR_STATE_INPUT_USB = 22
    AVR_STATE_INPUT_IPD = 23
    AVR_STATE_INPUT_IRP = 24
    AVR_STATE_INPUT_FVP = 25
    
    AVR_STATE_SURROUND_MOVIE = 30
    AVR_STATE_SURROUND_MUSIC = 31
    AVR_STATE_SURROUND_GAME = 32
    AVR_STATE_SURROUND_DIRECT = 33
    AVR_STATE_SURROUND_PURE_DIRECT = 34
    AVR_STATE_SURROUND_STEREO = 35
    AVR_STATE_SURROUND_AUTO = 36
    AVR_STATE_SURROUND_DOLBY = 37
    AVR_STATE_SURROUND_DTS = 38
    AVR_STATE_SURROUND_MULTICHAN_STEREO = 39
    AVR_STATE_SURROUND_VIRTUAL = 40
    
    AVR_STATE_PICTUREMODE_OFF = 50
    AVR_STATE_PICTUREMODE_STANDARD = 51
    AVR_STATE_PICTUREMODE_MOVIE = 52
    AVR_STATE_PICTUREMODE_VIVID = 53
    AVR_STATE_PICTUREMODE_STREAM = 54
    AVR_STATE_PICTUREMODE_CUSTOM = 55

    AVR_STATE_AUDIOSOURCE_AUTO = 60
    AVR_STATE_AUDIOSOURCE_HDMI = 61
    AVR_STATE_AUDIOSOURCE_DIGITAL = 62
    AVR_STATE_AUDIOSOURCE_ANALOGUE = 63
    AVR_STATE_AUDIOSOURCE_7_1IN = 64
    AVR_STATE_AUDIOSOURCE_NO = 65
    AVR_STATE_AUDIOSOURCE_ARC = 66
    
    AVR_STATE_OUTPUTRESOLUTION_48P = 70
    AVR_STATE_OUTPUTRESOLUTION_10I = 71
    AVR_STATE_OUTPUTRESOLUTION_72P = 72
    AVR_STATE_OUTPUTRESOLUTION_10P = 73
    AVR_STATE_OUTPUTRESOLUTION_10P24 = 74
    AVR_STATE_OUTPUTRESOLUTION_4K = 75
    AVR_STATE_OUTPUTRESOLUTION_AUTO = 76

    AVR_STATE_RESOLUTION_48P = 80
    AVR_STATE_RESOLUTION_10I = 81
    AVR_STATE_RESOLUTION_72P = 82
    AVR_STATE_RESOLUTION_10P = 83
    AVR_STATE_RESOLUTION_10P24 = 84
    AVR_STATE_RESOLUTION_4K = 85
    AVR_STATE_RESOLUTION_AUTO = 86
    
    AVR_STATE_POWER_ON = 1
    AVR_STATE_POWER_OFF = 0
    
    AVR_STATE_MUTE_ON = 1
    AVR_STATE_MUTE_OFF = 0
    
    

DEFINE_VARIABLE
    CHAR bAVR_Baud_Set = 'f'
    CHAR bufAVR[256]
    INTEGER AVR_CRPOS
    CHAR AVR_BUFOUT[32]
    
    CHAR AVR_NEXTINPUT[32]
    
    INTEGER AVR_STATE_POWER = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_MUTE = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_VOLUME = 0
    INTEGER AVR_STATE_INPUT = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_SURROUND = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_PICTUREMODE = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_AUDIOSOURCE = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_RESOLUTION = AVR_STATE_UNKNOWN
    INTEGER AVR_STATE_OUTPUTRESOLUTION = AVR_STATE_UNKNOWN
    
    LONG AVR_TIMELINE[9] = {11000, 100, 100, 100, 100, 100, 100, 100, 100}

    
DEFINE_FUNCTION AVR_CALLBACK (DEV device, CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    //SEND_STRING 0:0:0, "'AVR - ',event,': ',paramStr, ' (',itohex(paramInt),')'"
    
    if (COMPARE_STRING(event, 'POWER') == 1) {
	AVR_STATE_POWER = paramInt
    } else if (COMPARE_STRING(event, 'MUTE') == 1) {
	//SEND_STRING 0:0:0, "'Setting AVR_STATE_MUTE to ',itoa(paramInt)"
	AVR_STATE_MUTE = paramInt
    } else if (COMPARE_STRING(event, 'VOLUME') == 1) {
	AVR_STATE_VOLUME = paramInt
    } else if (paramInt < 30) {
	AVR_STATE_INPUT = paramInt
    } else if (paramInt < 50) {
	AVR_STATE_SURROUND = paramInt
    } else if (paramInt < 60) {
	AVR_STATE_PICTUREMODE = paramInt
    } else if (paramInt < 70) {
	AVR_STATE_AUDIOSOURCE = paramInt
    } else if (paramInt < 80) {
	AVR_STATE_OUTPUTRESOLUTION = paramInt
    } else if (paramInt < 90) {
	AVR_STATE_RESOLUTION = paramInt
    } else {
	SEND_STRING 0:0:0, "'AVR - Unknown Parameter'"
    }
    CALLBACK(device, event, paramStr, paramInt)
}

    


DEFINE_FUNCTION INTEGER AVR_STATUS_TO_INDEX (CHAR input[]) {
    if (COMPARE_STRING(input, "'SI',AVR_PHONO") == 1)		{ return 1 }
    if (COMPARE_STRING(input, "'SI',AVR_CD") == 1)		{ return 2 }
    if (COMPARE_STRING(input, "'SI',AVR_DVD") == 1)		{ return 3 }
    if (COMPARE_STRING(input, "'SI',AVR_BD") == 1)		{ return 4 }
    if (COMPARE_STRING(input, "'SI',AVR_TV") == 1)		{ return 5 }
    if (COMPARE_STRING(input, "'SI',AVR_SATCBL") == 1)		{ return 6 }
    if (COMPARE_STRING(input, "'SI',AVR_MPLAY") == 1)		{ return 7 }
    if (COMPARE_STRING(input, "'SI',AVR_GAME") == 1)		{ return 8 }
    if (COMPARE_STRING(input, "'SI',AVR_TUNER") == 1)		{ return 9 }
    if (COMPARE_STRING(input, "'SI',AVR_SPOTIFY") == 1)		{ return 10 }
    if (COMPARE_STRING(input, "'SI',AVR_SIRIUSXM") == 1)	{ return 11 }
    if (COMPARE_STRING(input, "'SI',AVR_PANDORA") == 1)		{ return 12 }
    if (COMPARE_STRING(input, "'SI',AVR_FLICKR") == 1)		{ return 13 }
    if (COMPARE_STRING(input, "'SI',AVR_IRADIO") == 1)		{ return 14 }
    if (COMPARE_STRING(input, "'SI',AVR_SERVER") == 1)		{ return 15 }
    if (COMPARE_STRING(input, "'SI',AVR_FAVORITES") == 1)	{ return 16 }
    if (COMPARE_STRING(input, "'SI',AVR_AUX1") == 1)		{ return 17 }
    if (COMPARE_STRING(input, "'SI',AVR_AUX2") == 1)		{ return 18 }
    if (COMPARE_STRING(input, "'SI',AVR_NET") == 1)		{ return 19 }
    if (COMPARE_STRING(input, "'SI',AVR_M_XPORT") == 1)		{ return 20 }
    if (COMPARE_STRING(input, "'SI',AVR_USBIPOD") == 1)		{ return 21 }
    if (COMPARE_STRING(input, "'SI',AVR_USB") == 1)		{ return 22 }
    if (COMPARE_STRING(input, "'SI',AVR_IPD") == 1)		{ return 23 }
    if (COMPARE_STRING(input, "'SI',AVR_IRP") == 1)		{ return 24 }
    if (COMPARE_STRING(input, "'SI',AVR_FVP") == 1)		{ return 25 }

    if (COMPARE_STRING(input, "'MS',AVR_SUR_MOVIE") == 1)	{ return 30 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_MUSIC") == 1)	{ return 31 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_GAME") == 1)	{ return 32 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_DIRECT") == 1)	{ return 33 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_PURE_DIRECT") == 1)	{ return 34 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_STEREO") == 1)	{ return 35 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_AUTO") == 1)	{ return 36 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_DOLBY") == 1)	{ return 37 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_DTS") == 1)		{ return 38 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_MULCHAN_ST") == 1)	{ return 39 }
    if (COMPARE_STRING(input, "'MS',AVR_SUR_VIRTUAL") == 1)	{ return 40 }

    if (COMPARE_STRING(input, "'PV',AVR_PM_OFF") == 1)		{ return 50 }
    if (COMPARE_STRING(input, "'PV',AVR_PM_STANDARD") == 1)	{ return 51 }
    if (COMPARE_STRING(input, "'PV',AVR_PM_MOVIE") == 1)	{ return 52 }
    if (COMPARE_STRING(input, "'PV',AVR_PM_VIVID") == 1)	{ return 53 }
    if (COMPARE_STRING(input, "'PV',AVR_PM_STREAM") == 1)	{ return 54 }
    if (COMPARE_STRING(input, "'PV',AVR_PM_CUSTOM") == 1)	{ return 55 }

    if (COMPARE_STRING(input, "'SDAUTO'") == 1)			{ return 60 }
    if (COMPARE_STRING(input, "'SDHDMI'") == 1)			{ return 61 }
    if (COMPARE_STRING(input, "'SDDIGITAL'") == 1)		{ return 62 }
    if (COMPARE_STRING(input, "'SDANALOG'") == 1)		{ return 63 }
    if (COMPARE_STRING(input, "'SD7.1IN'") == 1)		{ return 64 }
    if (COMPARE_STRING(input, "'SDNO'") == 1)			{ return 65 }
    if (COMPARE_STRING(input, "'SDARC'") == 1)			{ return 66 }

    if (COMPARE_STRING(input, "'VSSC48P'") == 1)		{ return 70 }
    if (COMPARE_STRING(input, "'VSSC10I'") == 1)		{ return 71 }
    if (COMPARE_STRING(input, "'VSSC72P'") == 1)		{ return 72 }
    if (COMPARE_STRING(input, "'VSSC10P'") == 1)		{ return 73 }
    if (COMPARE_STRING(input, "'VSSC10P24'") == 1)		{ return 74 }
    if (COMPARE_STRING(input, "'VSSC4K'") == 1)			{ return 75 }
    if (COMPARE_STRING(input, "'VSSCAUTO'") == 1)		{ return 76 }

    if (COMPARE_STRING(input, "'VSSCH48P'") == 1)		{ return 80 }
    if (COMPARE_STRING(input, "'VSSCH10I'") == 1)		{ return 81 }
    if (COMPARE_STRING(input, "'VSSCH72P'") == 1)		{ return 82 }
    if (COMPARE_STRING(input, "'VSSCH10P'") == 1)		{ return 83 }
    if (COMPARE_STRING(input, "'VSSCH10P24'") == 1)		{ return 84 }
    if (COMPARE_STRING(input, "'VSSCH4K'") == 1)		{ return 85 }
    if (COMPARE_STRING(input, "'VSSCHAUTO'") == 1)		{ return 86 }


    if (COMPARE_STRING(input, 'ZMON') == 1)			{ return 91 }
    if (COMPARE_STRING(input, 'ZMOFF') == 1)			{ return 92 }

    if (COMPARE_STRING(input, 'MUON') == 1)			{ return 93 }
    if (COMPARE_STRING(input, 'MUOFF') == 1)			{ return 94 }

    if (COMPARE_STRING(input, 'MV???') == 1)			{ return 98 }
    if (COMPARE_STRING(input, 'MV??') == 1)			{ return 99 }

    return 0
}

DEFINE_FUNCTION AVR_TURN_ON_AND_SET_INPUT(CHAR input[]) {
    if (AVR_STATE_POWER == AVR_STATE_POWER_OFF) {
	AVR_ZONE1_ON()
	AVR_NEXTINPUT = input
	WAIT 40 'AVR Turning On' {
	    AVR_INPUT(AVR_NEXTINPUT)
	}
    } else {
	AVR_INPUT(input)
    }
}

DEFINE_FUNCTION AVR_SET_BAUD() {
    if (bAVR_Baud_Set == 'f') {
	bAVR_Baud_Set = 't'
	SEND_COMMAND dvAVR, 'SET BAUD 9600,N,8,1'
    }
}

// POWER COMMANDS
DEFINE_FUNCTION AVR_ZONE1_ON() {
    SEND_STRING dvAVR, "'ZMON',$0d"
    WAIT 1 { AVR_ZONE1_QUERY() }
}
DEFINE_FUNCTION AVR_ZONE1_OFF() {
    SEND_STRING dvAVR, "'ZMOFF',$0d"
    WAIT 1 { AVR_ZONE1_QUERY() }
}
DEFINE_FUNCTION AVR_ZONE1_QUERY() {SEND_STRING dvAVR, "'ZM?',$0d"}

// VOLUME COMMANDS
DEFINE_FUNCTION AVR_ZONE1_VOL_UP() {
    SEND_STRING dvAVR, "'MVUP',$0d"
    WAIT 1 { AVR_ZONE1_VOL_QUERY() }
}
DEFINE_FUNCTION AVR_ZONE1_VOL_DOWN() {
    SEND_STRING dvAVR, "'MVDOWN',$0d"
    WAIT 1 { AVR_ZONE1_VOL_QUERY() }
}
DEFINE_FUNCTION AVR_ZONE1_VOL_SET(SINTEGER num) {
    LOCAL_VAR CHAR v[2];
    if (num > 98) { return }
    v = itoa(num)
    AVR_SET_BAUD()
    if (num < 10)	{ SEND_STRING dvAVR, "'MV0',v,$0d" }
    else		{ SEND_STRING dvAVR, "'MV', v,$0d" }
    WAIT 1 { AVR_ZONE1_VOL_QUERY() }
}
DEFINE_FUNCTION AVR_ZONE1_VOL_QUERY() {SEND_STRING dvAVR, "'MV?',$0d"}

// MUTE COMMANDS
DEFINE_FUNCTION AVR_MUTE_ON() {
    SEND_STRING dvAVR, "'MUON',$0d"
    WAIT 1 { AVR_MUTE_QUERY() }
}
DEFINE_FUNCTION AVR_MUTE_OFF() {
    SEND_STRING dvAVR, "'MUOFF',$0d"
    WAIT 1 { AVR_MUTE_QUERY() }
}
DEFINE_FUNCTION AVR_MUTE_QUERY() {SEND_STRING dvAVR, "'MU?',$0d"}

// INPUT COMMANDS
DEFINE_FUNCTION AVR_INPUT(CHAR Input[]) {
    SEND_STRING dvAVR, "'SI',Input,$0d"
    WAIT 1 { AVR_INPUT_QUERY() }
}
DEFINE_FUNCTION AVR_INPUT_QUERY() {SEND_STRING dvAVR, "'SI?',$0d"}

// AUDIO SOURCE COMMANDS
DEFINE_FUNCTION AVR_AUDIO_SOURCE_AUTO() {
    SEND_STRING dvAVR, "'SDAUTO',$0d"
    WAIT 1 { AVR_AUDIO_SOURCE_QUERY() }
}
DEFINE_FUNCTION AVR_AUDIO_SOURCE_HDMI() {
    SEND_STRING dvAVR, "'SDHDMI',$0d"
    WAIT 1 { AVR_AUDIO_SOURCE_QUERY() }
}
DEFINE_FUNCTION AVR_AUDIO_SOURCE_OPTICAL_OR_COAX() {
    SEND_STRING dvAVR, "'SDDIGITAL',$0d"
    WAIT 1 { AVR_AUDIO_SOURCE_QUERY() }
}
DEFINE_FUNCTION AVR_AUDIO_SOURCE_ANALOGUE() {
    SEND_STRING dvAVR, "'SDANALOG',$0d"
    WAIT 1 { AVR_AUDIO_SOURCE_QUERY() }
}
DEFINE_FUNCTION AVR_AUDIO_SOURCE_7_1CH_IN_MODE() {
    SEND_STRING dvAVR, "'SD7.1IN',$0d"
    WAIT 1 { AVR_AUDIO_SOURCE_QUERY() }
}
DEFINE_FUNCTION AVR_AUDIO_SOURCE_NONE() {
    SEND_STRING dvAVR, "'SDNO',$0d"
    WAIT 1 { AVR_AUDIO_SOURCE_QUERY() }
}
DEFINE_FUNCTION AVR_AUDIO_SOURCE_QUERY() {SEND_STRING dvAVR, "'SD?',$0d"}

// SURROUND COMMANDS
DEFINE_FUNCTION AVR_SURROUND (CHAR Input[]) {
    SEND_STRING dvAVR, "'MS',Input,$0d"
    WAIT 1 { AVR_SURROUND_QUERY() }
}
DEFINE_FUNCTION AVR_SURROUND_QUERY() {SEND_STRING dvAVR, "'MS?',$0d"}

// RESOLUTION COMMANDS
DEFINE_FUNCTION AVR_RESOLUTION_INPUT_QUERY() {SEND_STRING dvAVR, "'VSSCH ?',$0d"}
DEFINE_FUNCTION AVR_RESOLUTION_OUTPUT_QUERY() {SEND_STRING dvAVR, "'VSSC ?',$0d"}

// PICTURE MODE COMMANDS
DEFINE_FUNCTION AVR_PM(CHAR Input[]) {
    SEND_STRING dvAVR, "'PV',Input,$0d"
    WAIT 1 { AVR_PM_QUERY() }
}
DEFINE_FUNCTION AVR_PM_QUERY() {SEND_STRING dvAVR, "'PV?',$0d"}


// MISC COMMANDS (MENU, CURSOR, ETC)
DEFINE_FUNCTION AVR_MISC(CHAR Input[]) {SEND_STRING dvAVR, "Input,$0d"}



DEFINE_EVENT


    DATA_EVENT[dvAVR] {
	STRING: {
	    //SEND_STRING 0:0:0, "'AVR Buffer: ', bufAVR"
	    
	    AVR_CRPOS = FIND_STRING(bufAVR, "$0d", 1)
	    //SEND_STRING 0:0:0, "'Buf == ',bufAVR, ' - CRPOS == ', itoa(AVR_CRPOS)"
	    while (AVR_CRPOS > 0) {
		AVR_BUFOUT = GET_BUFFER_STRING(bufAVR, AVR_CRPOS - 1)
		GET_BUFFER_CHAR(bufAVR)
		
		if (AVR_BUFOUT[1] == '@') {
		    AVR_CRPOS = FIND_STRING(bufAVR, "$0d", 1)
		    continue
		}
		
		
		//SEND_STRING 0:0:0, "'AVR Now Processing: ',AVR_BUFOUT"
		AVR_CRPOS = AVR_STATUS_TO_INDEX(AVR_BUFOUT)
		
		switch (AVR_CRPOS) {
		case 1: { AVR_CALLBACK(dvAVR, 'INPUT', 'Phono', AVR_CRPOS) }
		case 2: { AVR_CALLBACK(dvAVR, 'INPUT', 'CD', AVR_CRPOS) }
		case 3: { AVR_CALLBACK(dvAVR, 'INPUT', 'DVD', AVR_CRPOS) }
		case 4: { AVR_CALLBACK(dvAVR, 'INPUT', 'Blu-ray', AVR_CRPOS) }
		case 5: { AVR_CALLBACK(dvAVR, 'INPUT', 'TV', AVR_CRPOS) }
		case 6: { AVR_CALLBACK(dvAVR, 'INPUT', 'Satellite / Cable', AVR_CRPOS) }
		case 7: { AVR_CALLBACK(dvAVR, 'INPUT', 'Media Player', AVR_CRPOS) }
		case 8: { AVR_CALLBACK(dvAVR, 'INPUT', 'Game', AVR_CRPOS) }
		case 9: { AVR_CALLBACK(dvAVR, 'INPUT', 'Tuner', AVR_CRPOS) }
		case 10: { AVR_CALLBACK(dvAVR, 'INPUT', 'Spotify', AVR_CRPOS) }
		case 11: { AVR_CALLBACK(dvAVR, 'INPUT', 'Sirius XM', AVR_CRPOS) }
		case 12: { AVR_CALLBACK(dvAVR, 'INPUT', 'Pandora', AVR_CRPOS) }
		case 13: { AVR_CALLBACK(dvAVR, 'INPUT', 'Flickr', AVR_CRPOS) }
		case 14: { AVR_CALLBACK(dvAVR, 'INPUT', 'Internet Radio', AVR_CRPOS) }
		case 15: { AVR_CALLBACK(dvAVR, 'INPUT', 'Server', AVR_CRPOS) }
		case 16: { AVR_CALLBACK(dvAVR, 'INPUT', 'Favourites', AVR_CRPOS) }
		case 17: { AVR_CALLBACK(dvAVR, 'INPUT', 'Aux 1', AVR_CRPOS) }
		case 18: { AVR_CALLBACK(dvAVR, 'INPUT', 'Aux 2', AVR_CRPOS) }
		case 19: { AVR_CALLBACK(dvAVR, 'INPUT', 'Network Service', AVR_CRPOS) }
		case 20: { AVR_CALLBACK(dvAVR, 'INPUT', 'M-XPort', AVR_CRPOS) }
		case 21: { AVR_CALLBACK(dvAVR, 'INPUT', 'USB / iPod', AVR_CRPOS) }
		case 22: { AVR_CALLBACK(dvAVR, 'INPUT', 'USB Autoplay', AVR_CRPOS) }
		case 23: { AVR_CALLBACK(dvAVR, 'INPUT', 'iPod DIRECT Autoplay', AVR_CRPOS) }
		case 24: { AVR_CALLBACK(dvAVR, 'INPUT', 'Internet Radio Autoplay', AVR_CRPOS) }
		case 25: { AVR_CALLBACK(dvAVR, 'INPUT', 'Network Service Favourite', AVR_CRPOS) }
		
		case 30: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Movie', AVR_CRPOS) }
		case 31: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Music', AVR_CRPOS) }
		case 32: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Game', AVR_CRPOS) }
		case 33: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Direct', AVR_CRPOS) }
		case 34: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Pure Direct', AVR_CRPOS) }
		case 35: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Auto', AVR_CRPOS) }
		case 36: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Stereo', AVR_CRPOS) }
		case 37: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Dolby Digital', AVR_CRPOS) }
		case 38: { AVR_CALLBACK(dvAVR, 'SURROUND', 'DTS Surround', AVR_CRPOS) }
		case 39: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Multi-Channel Stereo', AVR_CRPOS) }
		case 40: { AVR_CALLBACK(dvAVR, 'SURROUND', 'Virtual Surround', AVR_CRPOS) }

		case 50: { AVR_CALLBACK(dvAVR, 'PICTUREMODE', 'Off', AVR_CRPOS) }
		case 51: { AVR_CALLBACK(dvAVR, 'PICTUREMODE', 'Standard', AVR_CRPOS) }
		case 52: { AVR_CALLBACK(dvAVR, 'PICTUREMODE', 'Movie', AVR_CRPOS) }
		case 53: { AVR_CALLBACK(dvAVR, 'PICTUREMODE', 'Vivid', AVR_CRPOS) }
		case 54: { AVR_CALLBACK(dvAVR, 'PICTUREMODE', 'Stream', AVR_CRPOS) }
		case 55: { AVR_CALLBACK(dvAVR, 'PICTUREMODE', 'Custom', AVR_CRPOS) }

		case 60: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', 'Auto', AVR_CRPOS) }
		case 61: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', 'HDMI', AVR_CRPOS) }
		case 62: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', 'Optical / Coaxial', AVR_CRPOS) }
		case 63: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', 'Analogue', AVR_CRPOS) }
		case 64: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', '7.1 In', AVR_CRPOS) }
		case 65: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', 'No Audio', AVR_CRPOS) }
		case 66: { AVR_CALLBACK(dvAVR, 'AUDIOSOURCE', 'Audio Return Channel', AVR_CRPOS) }

		case 70: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', '480p / 576p', AVR_CRPOS) }
		case 71: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', '1080i', AVR_CRPOS) }
		case 72: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', '720p', AVR_CRPOS) }
		case 73: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', '1080p', AVR_CRPOS) }
		case 74: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', '1080p @ 24fps', AVR_CRPOS) }
		case 75: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', '4K', AVR_CRPOS) }
		case 76: { AVR_CALLBACK(dvAVR, 'OUTPUTRESOLUTION', 'Automatic', AVR_CRPOS) }

		case 80: { AVR_CALLBACK(dvAVR, 'RESOLUTION', '480p / 576p', AVR_CRPOS) }
		case 81: { AVR_CALLBACK(dvAVR, 'RESOLUTION', '1080i', AVR_CRPOS) }
		case 82: { AVR_CALLBACK(dvAVR, 'RESOLUTION', '720p', AVR_CRPOS) }
		case 83: { AVR_CALLBACK(dvAVR, 'RESOLUTION', '1080p', AVR_CRPOS) }
		case 84: { AVR_CALLBACK(dvAVR, 'RESOLUTION', '1080p @ 24fps', AVR_CRPOS) }
		case 85: { AVR_CALLBACK(dvAVR, 'RESOLUTION', '4K', AVR_CRPOS) }
		case 86: { AVR_CALLBACK(dvAVR, 'RESOLUTION', 'Automatic', AVR_CRPOS) }

		case 91: { AVR_CALLBACK(dvAVR, 'POWER', 'On', 1) }
		case 92: { AVR_CALLBACK(dvAVR, 'POWER', 'Off', 0) }

		case 93: { AVR_CALLBACK(dvAVR, 'MUTE', 'On', 1) }
		case 94: { AVR_CALLBACK(dvAVR, 'MUTE', 'Off', 0) }
		
		case 98:
		case 99: {
		    if ((AVR_BUFOUT[4] >= '0') && (AVR_BUFOUT[4] <= '9')) {
			AVR_CALLBACK(dvAVR, 'VOLUME', MID_STRING(AVR_BUFOUT, 3, 2), atoi(MID_STRING(AVR_BUFOUT, 3, 2)))
		    }
		}
		}
		
		AVR_CRPOS = FIND_STRING(bufAVR, "$0d", 1)
	    }
	}
    }
    
    TIMELINE_EVENT[1] {
	switch (timeline.sequence) {
	    case 1: { 	AVR_ZONE1_QUERY() 		}
	    case 2: { 	AVR_ZONE1_VOL_QUERY() 		}
	    case 3: { 	AVR_MUTE_QUERY() 		}
	    case 4: { 	AVR_INPUT_QUERY() 		}
	    case 5: { 	AVR_AUDIO_SOURCE_QUERY() 	}
	    case 6: { 	AVR_SURROUND_QUERY() 		}
	    case 7: { 	AVR_RESOLUTION_OUTPUT_QUERY() 	}
	    case 8: { 	AVR_RESOLUTION_INPUT_QUERY()	}
	    case 9: { 	AVR_PM_QUERY() 			}
	}
    }

DEFINE_START
    AVR_SET_BAUD()
    CREATE_BUFFER dvAVR, bufAVR
    TIMELINE_CREATE(1, AVR_TIMELINE, 9, TIMELINE_RELATIVE, TIMELINE_REPEAT)
    
    

#end_if