PROGRAM_NAME='APartConcept1'

#if_not_defined __APartConcept1__
#define __APartConcept1__

DEFINE_DEVICE
    
    dvAmp = 5001:1:1
    


DEFINE_CONSTANT
    SINTEGER AMP_STATE_UNKNOWN = 254
    
    SINTEGER AMP_STATE_POWER_ON = 1
    SINTEGER AMP_STATE_POWER_OFF = 0
    SINTEGER AMP_STATE_MUTE_ON = 1
    SINTEGER AMP_STATE_MUTE_OFF = 0
    SINTEGER AMP_STATE_VOLUME_MUTED = -80
    CHAR AMP_STATE_INPUT_A = 'A'
    CHAR AMP_STATE_INPUT_B = 'B'
    CHAR AMP_STATE_INPUT_C = 'C'
    CHAR AMP_STATE_INPUT_D = 'D'


DEFINE_VARIABLE
    CHAR bAmp_Baud_Set = 'f'
    CHAR bufAmp[256]
    INTEGER AMP_CRPOS
    CHAR AMP_BUFOUT[64]
    
    SINTEGER AMP_STATE_POWER = AMP_STATE_UNKNOWN
    SINTEGER AMP_STATE_MUTE = AMP_STATE_UNKNOWN
    SINTEGER AMP_STATE_VOLUME = AMP_STATE_UNKNOWN
    SINTEGER AMP_STATE_MICMUTE = AMP_STATE_UNKNOWN
    SINTEGER AMP_STATE_MICVOLUME = AMP_STATE_UNKNOWN
    SINTEGER AMP_STATE_LOUDNESS = AMP_STATE_UNKNOWN
    CHAR AMP_STATE_INPUT = 'U'
    
    LONG AMP_TIMELINE[13] = {11000, 100, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50}
    
    
    
DEFINE_FUNCTION AMP_CALLBACK (DEV device, CHAR event[], CHAR paramStr[], SINTEGER paramInt) {
    //SEND_STRING 0:0:0, "'AMP - ',event,': ',paramStr, ' (',itohex(paramInt),')'"
    
    if (COMPARE_STRING(event, 'POWER') == 1) {
	AMP_STATE_POWER = paramInt
    } else if (COMPARE_STRING(event, 'MUTE') == 1) {
	AMP_STATE_MUTE = paramInt
    } else if (COMPARE_STRING(event, 'VOLUME') == 1) {
	SEND_STRING 0:0:0, "'AMP VOLUME: ',itohex(paramInt),' - ',paramStr"
	AMP_STATE_VOLUME = paramInt
    } else if (COMPARE_STRING(event, 'MICMUTE') == 1) {
	AMP_STATE_MICMUTE = paramInt
    } else if (COMPARE_STRING(event, 'MICVOLUME') == 1) {
	SEND_STRING 0:0:0, "'AMP CALL VOLUME: ',itohex(paramInt),' - ',paramStr"
	AMP_STATE_MICVOLUME = paramInt
    } else if (COMPARE_STRING(event, 'INPUT') == 1) {
	AMP_STATE_INPUT = paramStr[1]
    } else if (COMPARE_STRING(event, 'LOUDNESS') == 1) {
	AMP_STATE_LOUDNESS = paramInt
    } else {
	SEND_STRING 0:0:0, "'AMP - Unknown Parameter - ',event"
    }
    CALLBACK_SIGNED(device, event, paramStr, paramInt)
}

DEFINE_FUNCTION AMP_SET_BAUD() {
    if (bAmp_Baud_Set == 'f') {
	bAmp_Baud_Set = 't'
	SEND_COMMAND dvAmp, 'SET BAUD 19200,N,8,1'
    }
    AMP_SET_ECHO_INIT('OFF')
    AMP_SET_LINEFEED_INIT('OFF')
    AMP_SET_HEADER('ON')
}

// All INC and DEC commands have a range of -10 .. +10
// All Volume commands have a range of -80 .. 0
// EQ has a range of even numbers between -14 .. 14 inclusive
// Input gain has a range of even numbers between -20 .. 14 inclusive
// Source is A, B, C or D
// Everything else is 0 or 1



DEFINE_FUNCTION AMP_GET_MULTIZONE() { SEND_STRING dvAmp, "'>GET MULTIZONE',$0d" }
DEFINE_FUNCTION AMP_SET_MULTIZONE(INTEGER value) { SEND_STRING dvAmp, "'>SET MULTIZONE ',itoa(value),$0d" }	// 0 OR 1

DEFINE_FUNCTION AMP_GET_ZONELINK() { SEND_STRING dvAmp, "'>GET ZONELINK',$0d" }
DEFINE_FUNCTION AMP_SET_ZONELINK(INTEGER value) { SEND_STRING dvAmp, "'>SET ZONELINK ',itoa(value),$0d" }	// 0 OR 1

DEFINE_FUNCTION AMP_GET_VOLUME() { SEND_STRING dvAmp, "'>GET MSCLVL',$0d" }
DEFINE_FUNCTION AMP_INC_VOLUME_1() { SEND_STRING dvAmp, "'>INC MSCLVL',$0d" }
DEFINE_FUNCTION AMP_DEC_VOLUME_1() { SEND_STRING dvAmp, "'>DEC MSCLVL',$0d" }
DEFINE_FUNCTION AMP_INC_VOLUME_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>INC MSCLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_DEC_VOLUME_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>DEC MSCLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_INC_VOLUME(SINTEGER value) { SEND_STRING dvAmp, "'>INC MSCLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_VOLUME(SINTEGER value) { SEND_STRING dvAmp, "'>DEC MSCLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_INC_VOLUME_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>INC MSCLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_VOLUME_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>DEC MSCLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_SET_VOLUME(SINTEGER value) { SEND_STRING dvAmp, "'>SET MSCLVL ',itoa(value),$0d" }	// -80 TO 0

DEFINE_FUNCTION AMP_GET_MICVOL() { SEND_STRING dvAmp, "'>GET MICLVL',$0d" }
DEFINE_FUNCTION AMP_INC_MICVOL_1() { SEND_STRING dvAmp, "'>INC MICLVL',$0d" }
DEFINE_FUNCTION AMP_DEC_MICVOL_1() { SEND_STRING dvAmp, "'>DEC MICLVL',$0d" }
DEFINE_FUNCTION AMP_INC_MICVOL_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>INC MICLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_DEC_MICVOL_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>DEC MICLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_INC_MICVOL(SINTEGER value) { SEND_STRING dvAmp, "'>INC MICLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_MICVOL(SINTEGER value) { SEND_STRING dvAmp, "'>DEC MICLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_INC_MICVOL_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>INC MICLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_MICVOL_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>DEC MICLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_SET_MICVOL(SINTEGER value) { SEND_STRING dvAmp, "'>SET MICLVL ',itoa(value),$0d" }	// -80 TO 0

DEFINE_FUNCTION AMP_GET_MAXVOLUME() { SEND_STRING dvAmp, "'>GET MAXMSCLVL',$0d" }
DEFINE_FUNCTION AMP_INC_MAXVOLUME_1() { SEND_STRING dvAmp, "'>INC MAXMSCLVL',$0d" }
DEFINE_FUNCTION AMP_DEC_MAXVOLUME_1() { SEND_STRING dvAmp, "'>DEC MAXMSCLVL',$0d" }
DEFINE_FUNCTION AMP_INC_MAXVOLUME_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>INC MAXMSCLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_DEC_MAXVOLUME_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>DEC MAXMSCLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_INC_MAXVOLUME(SINTEGER value) { SEND_STRING dvAmp, "'>INC MAXMSCLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_MAXVOLUME(SINTEGER value) { SEND_STRING dvAmp, "'>DEC MAXMSCLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_INC_MAXVOLUME_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>INC MAXMSCLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_MAXVOLUME_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>DEC MAXMSCLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_SET_MAXVOLUME(SINTEGER value) { SEND_STRING dvAmp, "'>SET MAXMSCLVL ',itoa(value),$0d" }	// -80 TO 0

DEFINE_FUNCTION AMP_GET_MAXMICVOL() { SEND_STRING dvAmp, "'>GET MAXMICLVL',$0d" }
DEFINE_FUNCTION AMP_INC_MAXMICVOL_1() { SEND_STRING dvAmp, "'>INC MAXMICLVL',$0d" }
DEFINE_FUNCTION AMP_DEC_MAXMICVOL_1() { SEND_STRING dvAmp, "'>DEC MAXMICLVL',$0d" }
DEFINE_FUNCTION AMP_INC_MAXMICVOL_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>INC MAXMICLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_DEC_MAXMICVOL_1_Z(INTEGER zone) { SEND_STRING dvAmp, "'>DEC MAXMICLVL ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_INC_MAXMICVOL(SINTEGER value) { SEND_STRING dvAmp, "'>INC MAXMICLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_MAXMICVOL(SINTEGER value) { SEND_STRING dvAmp, "'>DEC MAXMICLVL ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_INC_MAXMICVOL_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>INC MAXMICLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_DEC_MAXMICVOL_Z(SINTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>DEC MAXMICLVL ZONE',itoa(zone),' ',itoa(value),$0d" }
DEFINE_FUNCTION AMP_SET_MAXMICVOL(SINTEGER value) { SEND_STRING dvAmp, "'>SET MAXMICLVL ',itoa(value),$0d" }	// -80 TO 0

DEFINE_FUNCTION AMP_GET_INPUT() { SEND_STRING dvAmp, "'>GET SELECT',$0d" }
DEFINE_FUNCTION AMP_SET_INPUT(CHAR value) { SEND_STRING dvAmp, "'>SET SELECT ',value,$0d" }	// A, B, C, D

DEFINE_FUNCTION AMP_GET_EQ_BASS() { SEND_STRING dvAmp, "'>GET EQBASS',$0d" }
DEFINE_FUNCTION AMP_SET_EQ_BASS(SINTEGER value) { SEND_STRING dvAmp, "'>SET EQBASS ',itoa(value),$0d" } // -14 to 14, steps of 2

DEFINE_FUNCTION AMP_GET_EQ_TREBLE() { SEND_STRING dvAmp, "'>GET EQTREB',$0d" }
DEFINE_FUNCTION AMP_SET_EQ_TREBLE(SINTEGER value) { SEND_STRING dvAmp, "'>SET EQTREB ',itoa(value),$0d" } // -14 to 14, steps of 2

DEFINE_FUNCTION AMP_GET_STANDBY() { SEND_STRING dvAmp, "'>GET STANDBY',$0d" }
DEFINE_FUNCTION AMP_SET_STANDBY(INTEGER value) { SEND_STRING dvAmp, "'>SET STANDBY ',itoa(value),$0d" } // 0 = POWER ON, 1 = STANDBY

DEFINE_FUNCTION AMP_GET_AUTO_LOUDNESS() { SEND_STRING dvAmp, "'>GET AUTOLD',$0d" }
DEFINE_FUNCTION AMP_SET_AUTO_LOUDNESS(INTEGER value) { SEND_STRING dvAmp, "'>SET AUTOLD ',itoa(value),$0d" } // 0 OR 1

DEFINE_FUNCTION AMP_GET_PAGING_ACTIVE() { SEND_STRING dvAmp, "'>GET PAGACT',$0d" }
DEFINE_FUNCTION AMP_GET_PAGING_ACTIVE_Z(INTEGER zone) { SEND_STRING dvAmp, "'>GET PAGACT ZONE',itoa(zone),$0d" }
DEFINE_FUNCTION AMP_SET_PAGING_ACTIVE(INTEGER value) { SEND_STRING dvAmp, "'>SET PAGACT ',itoa(value),$0d" } // 0 OR 1
DEFINE_FUNCTION AMP_SET_PAGING_ACTIVE_Z(INTEGER value, INTEGER zone) { SEND_STRING dvAmp, "'>SET PAGACT ZONE',itoa(zone),' ',itoa(value),$0d" } // 0 OR 1

DEFINE_FUNCTION AMP_GET_INPUT_GAIN(CHAR input) { SEND_STRING dvAmp, "'>GET IPGAIN ',input,$0d" }
DEFINE_FUNCTION AMP_SET_INPUT_GAIN(CHAR input, INTEGER value) { SEND_STRING dvAmp, "'>SET IPGAIN ',input,' ',itoa(value),$0d" } // -20 .. 14

DEFINE_FUNCTION AMP_GET_LINEFEED() { SEND_STRING dvAmp, "'>GET LF',$0d" }
DEFINE_FUNCTION AMP_SET_LINEFEED(CHAR value[]) { SEND_STRING dvAmp, "$0d,'>SET LF ',value,$0d" } // ON OR OFF
DEFINE_FUNCTION AMP_SET_LINEFEED_INIT(CHAR value[]) { SEND_STRING dvAmp, "$0d,'SET LF ',value,$0d" } // ON OR OFF

DEFINE_FUNCTION AMP_GET_BACKSPACE() { SEND_STRING dvAmp, "'>GET BS',$0d" }
DEFINE_FUNCTION AMP_SET_BACKSPACE(CHAR value[]) { SEND_STRING dvAmp, "$0d,'>SET BS ',value,$0d" } // ON OR OFF

DEFINE_FUNCTION AMP_GET_HEADER() { SEND_STRING dvAmp, "'>GET HEADER',$0d" }
DEFINE_FUNCTION AMP_SET_HEADER(CHAR value[]) { SEND_STRING dvAmp, "$0d,'SET HEADER ',value,$0d,'>SET HEADER ',value,$0d" } // ON OR OFF

DEFINE_FUNCTION AMP_GET_ECHO() { SEND_STRING dvAmp, "'>GET ECHO',$0d" }

DEFINE_FUNCTION AMP_SET_ECHO(CHAR value[]) { SEND_STRING dvAmp, "$0d,'>SET ECHO ',value,$0d" } // ON OR OFF
DEFINE_FUNCTION AMP_SET_ECHO_INIT(CHAR value[]) { SEND_STRING dvAmp, "$0d,'SET ECHO ',value,$0d" } // ON OR OFF

DEFINE_FUNCTION AMP_GET_VALUE_FEEDBACK() { SEND_STRING dvAmp, "'>GET VALFB',$0d" }
DEFINE_FUNCTION AMP_SET_VALUE_FEEDBACK(CHAR value[]) { SEND_STRING dvAmp, "$0d,'>SET VALFB ',value,$0d" } // ON OR OFF

DEFINE_FUNCTION AMP_GET_INFO() { SEND_STRING dvAmp, "'>GET INFO',$0d" }

DEFINE_FUNCTION AMP_GET_SOURCENAME(CHAR input) { SEND_STRING dvAmp, "'>GET SOURCENAME ',input,$0d" }
DEFINE_FUNCTION AMP_SET_SOURCENAME(CHAR input, CHAR value[]) { SEND_STRING dvAmp, "$0d,'>SET SOURCENAME ',input,' ',value,$0d" } // ON OR OFF

DEFINE_FUNCTION AMP_GET_SERIAL() { SEND_STRING dvAmp, "'>GET SERIAL',$0d" }

DEFINE_FUNCTION AMP_GET_HWVERSION() { SEND_STRING dvAmp, "'>GET HWVRSN',$0d" }

DEFINE_FUNCTION AMP_GET_SWVERSION() { SEND_STRING dvAmp, "'>GET SWVRSN',$0d" }

DEFINE_FUNCTION AMP_RESET_TO_FACTORY() { SEND_STRING dvAmp, "'>SET RESTORE ON',$0d" }


DEFINE_CONSTANT

    INTEGER AMP_MULTIZONE_ON		= 1
    INTEGER AMP_MULTIZONE_OFF		= 2
    INTEGER AMP_ZONELINK_ON		= 3
    INTEGER AMP_ZONELINK_OFF		= 4
    INTEGER AMP_MUTE_ON			= 5
    INTEGER AMP_VOLUME			= 6
    INTEGER AMP_MUTE_ON_ZONE		= 7
    INTEGER AMP_VOLUME_ZONE		= 8
    INTEGER AMP_MICMUTE_ON		= 9
    INTEGER AMP_MICVOL			= 10
    INTEGER AMP_MICMUTE_ON_ZONE		= 11
    INTEGER AMP_MICVOL_ZONE		= 12
    INTEGER AMP_MAXVOL			= 13
    INTEGER AMP_MAXVOL_ZONE		= 14
    INTEGER AMP_MAXMIC			= 15
    INTEGER AMP_MAXMIC_ZONE		= 16
    INTEGER AMP_INPUT			= 17
    INTEGER AMP_INPUT_A			= 117
    INTEGER AMP_INPUT_B			= 217
    INTEGER AMP_INPUT_C			= 317
    INTEGER AMP_INPUT_D			= 417
    INTEGER AMP_EQ_BASS			= 18
    INTEGER AMP_EQ_TREBLE		= 19
    INTEGER AMP_STANDBY_ACTIVE		= 20
    INTEGER AMP_STANDBY_INACTIVE	= 21
    INTEGER AMP_AUTO_LOUDNESS_ON	= 22
    INTEGER AMP_AUTO_LOUDNESS_OFF	= 23
    INTEGER AMP_PAGING_ACTIVE_ON_ZONE	= 24
    INTEGER AMP_PAGING_ACTIVE_OFF_ZONE	= 25
    INTEGER AMP_INPUT_GAIN		= 26
    INTEGER AMP_ECHO_ON			= 27
    INTEGER AMP_ECHO_OFF		= 28
    INTEGER AMP_LINEFEED_ON		= 29
    INTEGER AMP_LINEFEED_OFF		= 30
    INTEGER AMP_BACKSPACE_ON		= 31
    INTEGER AMP_BACKSPACE_OFF		= 32
    INTEGER AMP_HEADER_ON		= 33
    INTEGER AMP_HEADER_OFF		= 34
    INTEGER AMP_VALUE_FEEDBACK_ON	= 35
    INTEGER AMP_VALUE_FEEDBACK_OFF	= 36

    INTEGER AMP_ERROR_PROTECT    	= 98
    INTEGER AMP_ERROR_TEMPERATURE	= 99
    
    


DEFINE_FUNCTION INTEGER AMP_MATCH_STRING(CHAR input[]) {
    if (COMPARE_STRING(input, "'MULTIZONE ON'") == 1)		{ return 001 }
    if (COMPARE_STRING(input, "'MULTIZONE 1'") == 1)		{ return 001 }
    if (COMPARE_STRING(input, "'MULTIZONE OFF'") == 1)		{ return 002 }
    if (COMPARE_STRING(input, "'MULTIZONE 0'") == 1)		{ return 002 }
    
    if (COMPARE_STRING(input, "'ZONELINK ON'") == 1)		{ return 003 }
    if (COMPARE_STRING(input, "'ZONELINK 1'") == 1)		{ return 003 }
    if (COMPARE_STRING(input, "'ZONELINK OFF'") == 1)		{ return 004 }
    if (COMPARE_STRING(input, "'ZONELINK 0'") == 1)		{ return 004 }
    
    if (COMPARE_STRING(input, "'MSCLVL OFF'") == 1)		{ return 005 }
    if (COMPARE_STRING(input, "'MSCLVL -80'") == 1)		{ return 005 }
    if (COMPARE_STRING(input, "'MSCLVL -??'") == 1)		{ return 006 }
    if (COMPARE_STRING(input, "'MSCLVL -?'") == 1)		{ return 006 }
    if (COMPARE_STRING(input, "'MSCLVL 0'") == 1)		{ return 006 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE1 OFF'") == 1)	{ return 107 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE1 -80'") == 1)	{ return 107 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE1 -??'") == 1)	{ return 108 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE1 -?'") == 1)	{ return 108 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE1 0'") == 1)		{ return 108 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE2 OFF'") == 1)	{ return 207 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE2 -80'") == 1)	{ return 207 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE2 -??'") == 1)	{ return 208 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE2 -?'") == 1)	{ return 208 }
    if (COMPARE_STRING(input, "'MSCLVL ZONE2 0'") == 1)		{ return 208 }
    if (COMPARE_STRING(input, "'MICLVL OFF'") == 1)		{ return 009 }
    if (COMPARE_STRING(input, "'MICLVL -80'") == 1)		{ return 009 }
    if (COMPARE_STRING(input, "'MICLVL -??'") == 1)		{ return 010 }
    if (COMPARE_STRING(input, "'MICLVL -?'") == 1)		{ return 010 }
    if (COMPARE_STRING(input, "'MICLVL 0'") == 1)		{ return 010 }
    if (COMPARE_STRING(input, "'MICLVL ZONE1 OFF'") == 1)	{ return 111 }
    if (COMPARE_STRING(input, "'MICLVL ZONE1 -80'") == 1)	{ return 111 }
    if (COMPARE_STRING(input, "'MICLVL ZONE1 -??'") == 1)	{ return 112 }
    if (COMPARE_STRING(input, "'MICLVL ZONE1 -?'") == 1)	{ return 112 }
    if (COMPARE_STRING(input, "'MICLVL ZONE1 0'") == 1)		{ return 112 }
    if (COMPARE_STRING(input, "'MICLVL ZONE2 OFF'") == 1)	{ return 211 }
    if (COMPARE_STRING(input, "'MICLVL ZONE2 -80'") == 1)	{ return 211 }
    if (COMPARE_STRING(input, "'MICLVL ZONE2 -??'") == 1)	{ return 212 }
    if (COMPARE_STRING(input, "'MICLVL ZONE2 -?'") == 1)	{ return 212 }
    if (COMPARE_STRING(input, "'MICLVL ZONE2 0'") == 1)		{ return 212 }

    if (COMPARE_STRING(input, "'MAXMSCLVL -??'") == 1)		{ return 013 }
    if (COMPARE_STRING(input, "'MAXMSCLVL -?'") == 1)		{ return 013 }
    if (COMPARE_STRING(input, "'MAXMSCLVL 0'") == 1)		{ return 013 }
    if (COMPARE_STRING(input, "'MAXMSCLVL ZONE1 -??'") == 1)	{ return 114 }
    if (COMPARE_STRING(input, "'MAXMSCLVL ZONE1 -?'") == 1)	{ return 114 }
    if (COMPARE_STRING(input, "'MAXMSCLVL ZONE1 0'") == 1)	{ return 114 }
    if (COMPARE_STRING(input, "'MAXMSCLVL ZONE2 -??'") == 1)	{ return 214 }
    if (COMPARE_STRING(input, "'MAXMSCLVL ZONE2 -?'") == 1)	{ return 214 }
    if (COMPARE_STRING(input, "'MAXMSCLVL ZONE2 0'") == 1)	{ return 214 }
    if (COMPARE_STRING(input, "'MAXMICLVL -??'") == 1)		{ return 015 }
    if (COMPARE_STRING(input, "'MAXMICLVL -?'") == 1)		{ return 015 }
    if (COMPARE_STRING(input, "'MAXMICLVL 0'") == 1)		{ return 015 }
    if (COMPARE_STRING(input, "'MAXMICLVL ZONE1 -??'") == 1)	{ return 116 }
    if (COMPARE_STRING(input, "'MAXMICLVL ZONE1 -?'") == 1)	{ return 116 }
    if (COMPARE_STRING(input, "'MAXMICLVL ZONE1 0'") == 1)	{ return 116 }
    if (COMPARE_STRING(input, "'MAXMICLVL ZONE2 -??'") == 1)	{ return 216 }
    if (COMPARE_STRING(input, "'MAXMICLVL ZONE2 -?'") == 1)	{ return 216 }
    if (COMPARE_STRING(input, "'MAXMICLVL ZONE2 0'") == 1)	{ return 216 }
    
    if (COMPARE_STRING(input, "'SELECT A'") == 1)		{ return 117 }
    if (COMPARE_STRING(input, "'SELECT B'") == 1)		{ return 217 }
    if (COMPARE_STRING(input, "'SELECT C'") == 1)		{ return 317 }
    if (COMPARE_STRING(input, "'SELECT D'") == 1)		{ return 417 }
    
    if (COMPARE_STRING(input, "'EQBASS ?'") == 1)		{ return 018 }
    if (COMPARE_STRING(input, "'EQBASS ??'") == 1)		{ return 018 }
    if (COMPARE_STRING(input, "'EQBASS -??'") == 1)		{ return 018 }
    
    if (COMPARE_STRING(input, "'EQTREB ?'") == 1)		{ return 019 }
    if (COMPARE_STRING(input, "'EQTREB ??'") == 1)		{ return 019 }
    if (COMPARE_STRING(input, "'EQTREB -??'") == 1)		{ return 019 }
    
    if (COMPARE_STRING(input, "'STANDBY ON'") == 1)		{ return 020 }
    if (COMPARE_STRING(input, "'STANDBY 1'") == 1)		{ return 020 }
    if (COMPARE_STRING(input, "'STANDBY OFF'") == 1)		{ return 021 }
    if (COMPARE_STRING(input, "'STANDBY 0'") == 1)		{ return 021 }

    if (COMPARE_STRING(input, "'AUTOLD ON'") == 1)		{ return 022 }
    if (COMPARE_STRING(input, "'AUTOLD 1'") == 1)		{ return 022 }
    if (COMPARE_STRING(input, "'AUTOLD OFF'") == 1)		{ return 023 }
    if (COMPARE_STRING(input, "'AUTOLD 0'") == 1)		{ return 023 }

    if (COMPARE_STRING(input, "'PAGACT ZONE1 ON'") == 1)	{ return 124 }
    if (COMPARE_STRING(input, "'PAGACT ZONE1 1'") == 1)		{ return 124 }
    if (COMPARE_STRING(input, "'PAGACT ZONE1 OFF'") == 1)	{ return 125 }
    if (COMPARE_STRING(input, "'PAGACT ZONE1 0'") == 1)		{ return 125 }
    if (COMPARE_STRING(input, "'PAGACT ZONE2 ON'") == 1)	{ return 224 }
    if (COMPARE_STRING(input, "'PAGACT ZONE2 1'") == 1)		{ return 224 }
    if (COMPARE_STRING(input, "'PAGACT ZONE2 OFF'") == 1)	{ return 225 }
    if (COMPARE_STRING(input, "'PAGACT ZONE2 0'") == 1)		{ return 225 }
    
    if (COMPARE_STRING(input, "'IPGAIN A ?'") == 1)		{ return 126 }
    if (COMPARE_STRING(input, "'IPGAIN A ??'") == 1)		{ return 126 }
    if (COMPARE_STRING(input, "'IPGAIN A -??'") == 1)		{ return 126 }
    if (COMPARE_STRING(input, "'IPGAIN B ?'") == 1)		{ return 226 }
    if (COMPARE_STRING(input, "'IPGAIN B ??'") == 1)		{ return 226 }
    if (COMPARE_STRING(input, "'IPGAIN B -??'") == 1)		{ return 226 }
    if (COMPARE_STRING(input, "'IPGAIN C ?'") == 1)		{ return 326 }
    if (COMPARE_STRING(input, "'IPGAIN C ??'") == 1)		{ return 326 }
    if (COMPARE_STRING(input, "'IPGAIN C -??'") == 1)		{ return 326 }
    if (COMPARE_STRING(input, "'IPGAIN D ?'") == 1)		{ return 426 }
    if (COMPARE_STRING(input, "'IPGAIN D ??'") == 1)		{ return 426 }
    if (COMPARE_STRING(input, "'IPGAIN D -??'") == 1)		{ return 426 }
    
    if (COMPARE_STRING(input, "'ECHO ON'") == 1)		{ return 027 }
    if (COMPARE_STRING(input, "'ECHO 1'") == 1)			{ return 027 }
    if (COMPARE_STRING(input, "'ECHO OFF'") == 1)		{ return 028 }
    if (COMPARE_STRING(input, "'ECHO 0'") == 1)			{ return 028 }

    if (COMPARE_STRING(input, "'LF ON'") == 1)			{ return 029 }
    if (COMPARE_STRING(input, "'LF 1'") == 1)			{ return 029 }
    if (COMPARE_STRING(input, "'LF OFF'") == 1)			{ return 030 }
    if (COMPARE_STRING(input, "'LF 0'") == 1)			{ return 030 }
    
    if (COMPARE_STRING(input, "'BS ON'") == 1)			{ return 031 }
    if (COMPARE_STRING(input, "'BS 1'") == 1)			{ return 031 }
    if (COMPARE_STRING(input, "'BS OFF'") == 1)			{ return 032 }
    if (COMPARE_STRING(input, "'BS 0'") == 1)			{ return 032 }

    if (COMPARE_STRING(input, "'HEADER ON'") == 1)		{ return 033 }
    if (COMPARE_STRING(input, "'HEADER 1'") == 1)		{ return 033 }
    if (COMPARE_STRING(input, "'HEADER OFF'") == 1)		{ return 034 }
    if (COMPARE_STRING(input, "'HEADER 0'") == 1)		{ return 034 }

    if (COMPARE_STRING(input, "'VALFB ON'") == 1)		{ return 035 }
    if (COMPARE_STRING(input, "'VALFB 1'") == 1)		{ return 035 }
    if (COMPARE_STRING(input, "'VALFB OFF'") == 1)		{ return 036 }
    if (COMPARE_STRING(input, "'VALFB 0'") == 1)		{ return 036 }
/*
    if (COMPARE_STRING(MID_STRING(input, 1, 12), "'SOURCENAME A'") == 1)	{ return 137 }
    if (COMPARE_STRING(MID_STRING(input, 1, 12), "'SOURCENAME B'") == 1)	{ return 237 }
    if (COMPARE_STRING(MID_STRING(input, 1, 12), "'SOURCENAME C'") == 1)	{ return 337 }
    if (COMPARE_STRING(MID_STRING(input, 1, 12), "'SOURCENAME D'") == 1)	{ return 437 }

    if (COMPARE_STRING(MID_STRING(input, 1, 7), "'SERIAL '") == 1)	{ return 038 }
    
    if (COMPARE_STRING(MID_STRING(input, 1, 7), "'HWVRSN '") == 1)	{ return 039 }
    
    if (COMPARE_STRING(MID_STRING(input, 1, 7), "'SWVRSN '") == 1)	{ return 040 }
*/

    if (COMPARE_STRING(input, "'ERROR: AMPLIFIER PROTECT!'") == 1)		{ return 098 }
    if (COMPARE_STRING(input, "'ERROR: OVER TEMPERATURE!'") == 1)		{ return 099 }
    
    return 0
}


DEFINE_FUNCTION AMP_PARSE_STRING(CHAR buf[]) {
    stack_var integer spacepos
    stack_var integer functionmatch
    stack_var char paramstr[32]
    stack_var sinteger paramint
    
    SEND_STRING 0:0:0, "'AMP: buf:',buf"
    spacepos = FIND_STRING(buf, ' ', 1)
    if (spacepos > 0) {
	paramstr = MID_STRING(buf, spacepos+1, LENGTH_STRING(buf) - spacepos)
	paramint = atoi(paramstr)
	SEND_STRING 0:0:0, "'AMP: ParamStr:',paramstr,' ParamInt:',itoa(paramint)"
    }
    
    functionmatch = AMP_MATCH_STRING(buf)
    //SEND_STRING 0:0:0, "'AMP: FunctionMatch:',itoa(functionmatch)"
    switch (functionmatch) {
	case AMP_MULTIZONE_ON: { AMP_CALLBACK(dvAmp, 'MULTIZONE', 'ON', 1) } 
	case AMP_MULTIZONE_OFF: { AMP_CALLBACK(dvAmp, 'MULTIZONE', 'OFF', 0) } 
	case AMP_ZONELINK_ON: { AMP_CALLBACK(dvAmp, 'ZONELINK', 'ON', 1) } 
	case AMP_ZONELINK_OFF: { AMP_CALLBACK(dvAmp, 'ZONELINK', 'OFF', 0) } 
	case AMP_MUTE_ON: { AMP_CALLBACK(dvAmp, 'MUTE', 'ON', 1); AMP_CALLBACK(dvAmp, 'VOLUME', '-80', -80)  } 
	case AMP_VOLUME: { AMP_CALLBACK(dvAmp, 'MUTE', 'OFF', 0); AMP_CALLBACK(dvAmp, 'VOLUME', paramstr, paramint)  } 
	//case AMP_MUTE_ON_ZONE: {  } 
	//case AMP_VOLUME_ZONE: {  } 
	case AMP_MICMUTE_ON: { AMP_CALLBACK(dvAmp, 'MICMUTE', 'ON', 1); AMP_CALLBACK(dvAmp, 'MICVOLUME', '-80', -80) } 
	case AMP_MICVOL: { AMP_CALLBACK(dvAmp, 'MICMUTE', 'OFF', 0); AMP_CALLBACK(dvAmp, 'MICVOLUME', paramstr, paramint) } 
	//case AMP_MICMUTE_ON_ZONE: {  } 
	//case AMP_MICVOL_ZONE: {  } 
	case AMP_MAXVOL: { AMP_CALLBACK(dvAmp, 'MAXVOLUME', paramstr, paramint) } 
	//case AMP_MAXVOL_ZONE: {  }
	case AMP_MAXMIC: { AMP_CALLBACK(dvAmp, 'MAXMICVOLUME', paramstr, paramint) } 
	//case AMP_MAXMIC_ZONE: {  } 
	case AMP_INPUT_A: { AMP_CALLBACK(dvAmp, 'INPUT', 'A', 1); AMP_CALLBACK(dvAmp, 'POWER', 'ON', 1); } 
	case AMP_INPUT_B: { AMP_CALLBACK(dvAmp, 'INPUT', 'B', 2); AMP_CALLBACK(dvAmp, 'POWER', 'ON', 1); } 
	case AMP_INPUT_C: { AMP_CALLBACK(dvAmp, 'INPUT', 'C', 3); AMP_CALLBACK(dvAmp, 'POWER', 'ON', 1); } 
	case AMP_INPUT_D: { AMP_CALLBACK(dvAmp, 'INPUT', 'D', 4); AMP_CALLBACK(dvAmp, 'POWER', 'ON', 1); } 
	case AMP_EQ_BASS: { AMP_CALLBACK(dvAmp, 'EQ', 'BASS', paramint) } 
	case AMP_EQ_TREBLE: { AMP_CALLBACK(dvAmp, 'EQ', 'TREBLE', paramint) } 
	case AMP_STANDBY_ACTIVE: { AMP_CALLBACK(dvAmp, 'POWER', 'OFF', 0) } 
	case AMP_STANDBY_INACTIVE: { AMP_CALLBACK(dvAmp, 'POWER', 'ON', 1) } 
	case AMP_AUTO_LOUDNESS_ON: { AMP_CALLBACK(dvAmp, 'LOUDNESS', 'ON', 1) } 
	case AMP_AUTO_LOUDNESS_OFF: { AMP_CALLBACK(dvAmp, 'LOUDNESS', 'OFF', 0) } 
	//case AMP_PAGING_ACTIVE_ON_ZONE: {  } 
	//case AMP_PAGING_ACTIVE_OFF_ZONE: {  } 
	case AMP_INPUT_GAIN: { AMP_CALLBACK(dvAmp, 'INPUTGAIN', paramstr[1], paramint) } 
	case AMP_ECHO_ON: { AMP_CALLBACK(dvAmp, 'ECHO', 'ON', 1) } 
	case AMP_ECHO_OFF: { AMP_CALLBACK(dvAmp, 'ECHO', 'OFF', 0) } 
	case AMP_LINEFEED_ON: { AMP_CALLBACK(dvAmp, 'LINEFEED', 'ON', 1) } 
	case AMP_LINEFEED_OFF: { AMP_CALLBACK(dvAmp, 'LINEFEED', 'OFF', 0) } 
	case AMP_BACKSPACE_ON: { AMP_CALLBACK(dvAmp, 'BACKSPACE', 'ON', 1) } 
	case AMP_BACKSPACE_OFF: { AMP_CALLBACK(dvAmp, 'BACKSPACE', 'OFF', 0) } 
	case AMP_HEADER_ON: { AMP_CALLBACK(dvAmp, 'HEADER', 'ON', 1) } 
	case AMP_HEADER_OFF: { AMP_CALLBACK(dvAmp, 'HEADER', 'OFF', 0) } 
	case AMP_VALUE_FEEDBACK_ON: { AMP_CALLBACK(dvAmp, 'VALUEFEEDBACK', 'ON', 1) } 
	case AMP_VALUE_FEEDBACK_OFF: { AMP_CALLBACK(dvAmp, 'VALUEFEEDBACK', 'OFF', 0) } 
	case AMP_ERROR_PROTECT: { AMP_CALLBACK(dvAmp, 'ERROR', 'AMPLIFIER PROTECT!', 1) } 
	case AMP_ERROR_TEMPERATURE: { AMP_CALLBACK(dvAmp, 'ERROR', 'OVER TEMPERATURE!', 1) } 
    }
}


DEFINE_EVENT
    
    
    
    DATA_EVENT[dvAmp] {
	STRING: {
	    AMP_CRPOS = FIND_STRING(bufAmp, "$0d", 1)
	    //SEND_STRING 0:0:0, "'Amp Buffer: ', bufAmp, ' CRPOS = ',itoa(AMP_CRPOS)"
	    while (AMP_CRPOS > 0) {
		AMP_BUFOUT = GET_BUFFER_STRING(bufAmp, AMP_CRPOS - 1)
		GET_BUFFER_CHAR(bufAmp)
		
		AMP_CRPOS = FIND_STRING(AMP_BUFOUT, '>', 1)
		if (AMP_CRPOS == 0) {
		    AMP_CRPOS = FIND_STRING(bufAmp, "$0d", 1)
		    continue
		}
		AMP_BUFOUT = MID_STRING(AMP_BUFOUT, AMP_CRPOS + 1, LENGTH_STRING(AMP_CRPOS) - AMP_CRPOS - 2)
		//SEND_STRING 0:0:0, "'Amp BufOut: --- ',AMP_BUFOUT,'  >pos = ',itoa(AMP_CRPOS)"
		//SEND_STRING 0:0:0, "'AMP Now Processing: ',AMP_BUFOUT"
		
		AMP_PARSE_STRING(AMP_BUFOUT)
		
	    }
	}
    }
    
    TIMELINE_EVENT[1] {
	switch (timeline.sequence) {
	    case 1: {	AMP_SET_BAUD()			}
	    case 2: { 	AMP_GET_INFO() /* EQ LVL MAXLVL INPUT AUTOLD PAGACT PAGING MULTIZONE */ 	}
	    case 3: { 	AMP_GET_BACKSPACE() 		}
	    case 4: { 	AMP_GET_ECHO()	 		}
	    case 5: { 	AMP_GET_HEADER()		}
	    case 6: { 	AMP_GET_INPUT_GAIN('A')		}
	    case 7: { 	AMP_GET_INPUT_GAIN('B')		}
	    case 8: { 	AMP_GET_INPUT_GAIN('C')		}
	    case 9: { 	AMP_GET_INPUT_GAIN('D') 	}
	    case 10: { 	AMP_GET_LINEFEED()	 	}
	    case 11: { 	AMP_GET_INPUT()		}
	    case 12: { 	AMP_GET_VALUE_FEEDBACK() 	}
	    case 13: { 	AMP_GET_ZONELINK()	 	}
//	    case 5: { 	AMP_GET_HWVERSION()		}
//	    case 11: { 	AMP_GET_SERIAL() 		}
//	    case 13: { 	AMP_GET_SWVERSION()		}
//	    case 14: { 	AMP_GET_SOURCENAME('A') 	}
//	    case 15: { 	AMP_GET_SOURCENAME('B') 	}
//	    case 16: { 	AMP_GET_SOURCENAME('C') 	}
//	    case 17: { 	AMP_GET_SOURCENAME('D') 	}
	}
    }

DEFINE_START
    AMP_SET_BAUD()
    CREATE_BUFFER dvAmp, bufAmp
    TIMELINE_CREATE(1, AMP_TIMELINE, 13, TIMELINE_RELATIVE, TIMELINE_REPEAT)
    


#end_if
