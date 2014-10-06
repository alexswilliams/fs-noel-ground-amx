PROGRAM_NAME='ClearOneInteractPro'
#if_not_defined __CLEARONE__
#define __CLEARONE__

DEFINE_DEVICE
    dvClearOne = 5001:3:1


DEFINE_TYPE
    STRUCTURE PhoneBook {
	CHAR NAME[32]
	CHAR NUMBER[32]
	INTEGER PRESET
    }
    STRUCTURE HMS {
	INTEGER Hours
	INTEGER Minutes
	INTEGER Seconds
    }

DEFINE_VARIABLE
    CHAR CLEARONE_Baud_Set = 'f'
    CHAR CLEARONE_buf[1024]
    LONG CLEARONE_TIMELINE[30] = {1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000, 50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50}
    
    PhoneBook CLEARONE_PHONEBOOK[20]
    INTEGER CLEARONE_PHONEBOOK_LENGTH = 0
    
    INTEGER CLEARONE_MATRIX[5][5] = {
	{0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0}
    }
    HMS CLEARONE_TimeConnected = {0,0,0}
    INTEGER CLEARONE_OffHook = 0
    INTEGER CLEARONE_MICGATE_LAST = 0
    
    
DEFINE_CONSTANT
    
    
    CLEARONE_MUTE_UNMUTED		= 0
    CLEARONE_MUTE_MUTED			= 1
    CLEARONE_MUTE_TOGGLE		= 2
    
    CLEARONE_MATRIX_MICS		= 1
    CLEARONE_MATRIX_SPEAKERS		= 2
    CLEARONE_MATRIX_CALL		= 3
    CLEARONE_MATRIX_VIDYO		= 4
    CLEARONE_MATRIX_PC			= 5
    
    CLEARONE_MATRIX_CALL_TO_SPEAKER_LEFT	= 'A P 7 O'
    CLEARONE_MATRIX_CALL_TO_SPEAKER_RIGHT	= 'A P 8 O'
    CLEARONE_MATRIX_CALL_TO_VIDYO		= 'A P 1 D'
    CLEARONE_MATRIX_VIDYO_TO_SPEAKER_LEFT	= '1 W 7 O'
    CLEARONE_MATRIX_VIDYO_TO_SPEAKER_RIGHT	= '1 W 8 O'
    CLEARONE_MATRIX_VIDYO_TO_CALL		= '1 W 1 T'
    CLEARONE_MATRIX_MICS_TO_VIDYO		= 'B P 1 D'
    CLEARONE_MATRIX_MICS_TO_CALL		= 'B P 1 T'
    CLEARONE_MATRIX_MICS_TO_PC			= 'B P 6 O'

DEFINE_FUNCTION CHAR[3] CLEARONE_GET_MATRIX_FROM_NUM_Q(INTEGER inp, INTEGER is_destination) {
    switch (inp) {
	case CLEARONE_MATRIX_MICS:	{ return '1 M' }
	case CLEARONE_MATRIX_SPEAKERS:	{ return '7 O' }
	case CLEARONE_MATRIX_PC:	{ return '6 O' }
	case CLEARONE_MATRIX_CALL:	{ if (is_destination==1) { return '1 T' } else { return '1 R'} }
	case CLEARONE_MATRIX_VIDYO:	{ if (is_destination==1) { return '1 D' } else { return '1 W'} }
    }
}


DEFINE_FUNCTION CLEARONE_SET_BAUD() {
    if (CLEARONE_Baud_Set == 't') { return }
    CLEARONE_Baud_Set = 't'
    SEND_COMMAND dvClearOne, 'SET BAUD 57600,N,8,1'
    SEND_COMMAND dvClearOne, 'XON'
}



DEFINE_FUNCTION CLEARONE_CALLBACK (DEV device, CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    stack_var integer icmd
    stack_var sinteger sparam
    stack_var integer lastparam
    stack_var integer paramstrlength
    
    paramstrlength = LENGTH_STRING(paramStr)
    if (paramstrlength >= 1) {
	lastparam = atoi("paramStr[LENGTH_STRING(paramStr)]")
	sparam = atoi(paramStr)
    }
    
    SEND_STRING 0:0:0, "'CLEARONE - ',event,': ',paramStr, ' (',itohex(paramInt),':',itohex(lastparam),':',itoa(sparam),')'"
    icmd = CLEARONE_CMD_TO_INT(event)
    
    switch (icmd) {
	case 1:	{
	    CLEARONE_OffHook = (paramStr[3] - '0')
	    CALLBACK(dvClearOne, 'PHONE_HOOK', paramStr[3], lastparam)
	}
	case 2: { CALLBACK(dvClearOne, 'DIALOUT', MID_STRING(paramStr, 3, LENGTH_STRING(paramStr) - 2), lastparam) }
	case 3: {
	    CLEARONE_TimeConnected.Hours = atoi("paramStr[3],paramStr[4]")
	    CLEARONE_TimeConnected.Minutes = atoi("paramStr[6],paramStr[7]")
	    CLEARONE_TimeConnected.Seconds = atoi("paramStr[9],paramStr[10]")
	    CALLBACK(dvClearOne, 'CALLDUR', paramStr, lastparam)
	}
	case 4: { CALLBACK(dvClearOne, 'MUTE', paramStr, lastparam) }
	case 5: { CALLBACK(dvClearOne, 'MICMUTE', paramStr, lastparam) }
	case 6: {
	    stack_var integer i
	    CLEARONE_PHONEBOOK_LENGTH = paramInt
	    for (i = 0; i < paramInt; i++) {
		CLEARONE_PHONEBOOK_READ(i)
	    }
	    CALLBACK(dvClearOne, 'PHONEBOOK_COUNT', paramStr, lastparam)
	}
	case 7: {
	    stack_var integer pos
	    stack_var integer prevpos
	    stack_var char buf[32]
	    stack_var PhoneBook entry 
	    
	    //               123456789 12345...
	    // PHONEBOOKREAD 0 2 2811 CAFE / RUNNERS
	    //		     | |   |  +============+------- Name
	    //		     | |   +----------------------- Number
	    //               | +--------------------------- Speed Dial Preset
	    //               +----------------------------- Index in Phonebook
	    
	    // Get Speed Dial number
	    pos = FIND_STRING(paramStr, ' ', 3); if (pos == 0) { return }
   	    entry.PRESET = atoi(MID_STRING(paramStr, 3, pos-3))
	    
	    // Get Number
	    prevpos = pos+1; pos = FIND_STRING(paramStr, ' ', prevpos); if (pos == 0) { return }
   	    entry.NUMBER = MID_STRING(paramStr, prevpos, pos-prevpos)
	    
	    // Get Name
	    entry.NAME = MID_STRING(paramStr, pos+1, LENGTH_STRING(paramStr)-pos)
	    
	    CLEARONE_PHONEBOOK[entry.preset] = entry
	    
	    CALLBACK(dvClearOne, 'PHONEBOOK', paramStr, lastparam)
	}
	case 8: { CALLBACK(dvClearOne, 'AUTO_ANSWER', paramStr, lastparam) }
	case 9: { CALLBACK(dvClearOne, 'ACCOUSTIC_ECHO_CANCELLATION', paramStr, lastparam) }
	case 10: { CALLBACK(dvClearOne, 'AUTOMATIC_GAIN_CONTROL', paramStr, lastparam) }
	case 11: { CALLBACK(dvClearOne, 'COMPRESSION', paramStr, lastparam) }
	case 12: { CALLBACK(dvClearOne, 'NOISE_CANCELLATION', paramStr, lastparam) }
	case 13: {
	    CLEARONE_MICGATE_LAST = lastparam
	    CALLBACK(dvClearOne, 'DECAY', paramStr, lastparam)
	}
	case 14: { CALLBACK(dvClearOne, 'RINGER_ENABLED', paramStr, lastparam) }
	case 15: { CALLBACK(dvClearOne, 'CLEAR_EFFECT', paramStr, lastparam) }
	case 16: { CALLBACK(dvClearOne, 'TELCO_LEVEL_CONTROL', paramStr, lastparam) }
	case 17: { CALLBACK(dvClearOne, 'TELCO_LOOPBACK_ECHO_CANCELLATION', paramStr, lastparam) }
	case 18: { CALLBACK(dvClearOne, 'VOLUME', paramStr, paramInt) }
	case 19: {
	    stack_var integer ifrom
	    stack_var integer ito
	    if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_CALL_TO_SPEAKER_LEFT, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_CALL; ito = CLEARONE_MATRIX_SPEAKERS
	    } else if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_CALL_TO_VIDYO, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_CALL; ito = CLEARONE_MATRIX_VIDYO
	    } else if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_MICS_TO_CALL, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_MICS; ito = CLEARONE_MATRIX_CALL
	    } else if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_MICS_TO_PC, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_MICS; ito = CLEARONE_MATRIX_PC
	    } else if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_MICS_TO_VIDYO, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_MICS; ito = CLEARONE_MATRIX_VIDYO
	    } else if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_VIDYO_TO_CALL, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_VIDYO; ito = CLEARONE_MATRIX_CALL
	    } else if (COMPARE_STRING(paramStr, "CLEARONE_MATRIX_VIDYO_TO_SPEAKER_LEFT, ' ?'") == 1) {
		ifrom = CLEARONE_MATRIX_VIDYO; ito = CLEARONE_MATRIX_SPEAKERS
	    } else { return }
	    if (lastparam > 1) { lastparam = 1 }
	    CLEARONE_MATRIX[ifrom][ito] = lastparam
	    SEND_STRING 0:0:0, "'Setting MATRIX[',itoa(ifrom),'][',itoa(ito),'] = ',itoa(lastparam)"
	    CALLBACK(dvClearOne, 'MATRIX_UPDATE', paramStr, lastparam)
	}
	case 20: {
	    CALLBACK(dvClearOne, 'RING', paramStr, lastparam)
	}
	case 999: { SEND_STRING 0:0:0, "'CLEARONE - Command Error: ', paramStr" }
	default: { SEND_STRING 0:0:0, "'CLEARONE - Unknown Command'" }
    }
}

DEFINE_FUNCTION INTEGER CLEARONE_CMD_TO_INT(CHAR cmd[]) {
    if (COMPARE_STRING(cmd, 'TE') == 1)			{ return 1 }
    if (COMPARE_STRING(cmd, 'DIAL') == 1)		{ return 2 }
    if (COMPARE_STRING(cmd, 'CALLDUR') == 1)		{ return 3 }
    if (COMPARE_STRING(cmd, 'GMUTE') == 1)		{ return 4 }
    if (COMPARE_STRING(cmd, 'MUTE') == 1)		{ return 5 }
    if (COMPARE_STRING(cmd, 'PHONEBOOKCNT') == 1)	{ return 6 }
    if (COMPARE_STRING(cmd, 'PHONEBOOKREAD') == 1)	{ return 7 }
    if (COMPARE_STRING(cmd, 'AA') == 1)			{ return 8 }
    if (COMPARE_STRING(cmd, 'AEC') == 1)		{ return 9 }
    if (COMPARE_STRING(cmd, 'AGC') == 1)		{ return 10 }
    if (COMPARE_STRING(cmd, 'COMPSEL') == 1)		{ return 11 }
    if (COMPARE_STRING(cmd, 'NCSEL') == 1)		{ return 12 }
    if (COMPARE_STRING(cmd, 'DECAY') == 1)		{ return 13 }
    if (COMPARE_STRING(cmd, 'RINGEREN') == 1)		{ return 14 }
    if (COMPARE_STRING(cmd, 'CLEAREFFECT') == 1)	{ return 15 }
    if (COMPARE_STRING(cmd, 'TELCOLVLCTRL') == 1)	{ return 16 }
    if (COMPARE_STRING(cmd, 'TLEC') == 1)		{ return 17 }
    if (COMPARE_STRING(cmd, 'GAIN') == 1)		{ return 18 }
    if (COMPARE_STRING(cmd, 'MTRX') == 1)		{ return 19 }
    if (COMPARE_STRING(cmd, 'RING') == 1)		{ return 20 }
    
    if (COMPARE_STRING(cmd, 'ERROR') == 1)		{ return 999 }
    return 0
}

DEFINE_FUNCTION CLEARONE_PROCESS_STRING(CHAR str[]) {
    stack_var char cmd[32]
    stack_var char params[32]
    stack_var integer delim
    
    delim = FIND_STRING(str, ' ', 1)
    if (delim == 0) { cmd = str } else {
	cmd = MID_STRING(str, 1, delim-1)
	params = MID_STRING(str, delim+1, LENGTH_STRING(str) - delim)
    }
    CLEARONE_CALLBACK(dvClearOne, cmd, params, atoi(params))
}



DEFINE_FUNCTION CLEARONE_HOOK(INTEGER lifted) { SEND_STRING dvClearOne, "'#K0 TE 1 ',itoa(lifted), $0d" }
DEFINE_FUNCTION CLEARONE_HOOK_QUERY() { SEND_STRING dvClearOne, "'#K0 TE 1', $0d" }

DEFINE_FUNCTION CLEARONE_CALL_ANSWER() { CLEARONE_HOOK(1); }
DEFINE_FUNCTION CLEARONE_CALL_IGNORE() { CLEARONE_HOOK(1); WAIT 3 { CLEARONE_HOOK(0) } }
DEFINE_FUNCTION CLEARONE_DIAL(CHAR number[]) { SEND_STRING dvClearOne, "'#K0 DIAL 1 ',number,$0d" }
DEFINE_FUNCTION CLEARONE_ENDCALL() { CLEARONE_HOOK(0) }
DEFINE_FUNCTION CLEARONE_REDIAL() { SEND_STRING dvClearOne, "'#K0 REDIAL 1',$0d" }


DEFINE_FUNCTION CLEARONE_MUTE_MICS(INTEGER mute) { SEND_STRING dvClearOne, "'#K0 GMUTE M ', itoa(mute),$0d" }
DEFINE_FUNCTION CLEARONE_MUTE_MICS_QUERY() { SEND_STRING dvClearOne, "'#K0 GMUTE M',$0d" }

DEFINE_FUNCTION CLEARONE_PHONEBOOK_COUNT() { SEND_STRING dvClearOne, "'#K0 PHONEBOOKCNT',$0d" }
DEFINE_FUNCTION CLEARONE_PHONEBOOK_READ(INTEGER index) { SEND_STRING dvClearOne, "'#K0 PHONEBOOKREAD ',itoa(index),$0d" }

DEFINE_FUNCTION CLEARONE_AUTOANSWER(INTEGER value) { SEND_STRING dvClearOne, "'#K0 AA 1 ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_AUTOANSWER_QUERY() { SEND_STRING dvClearOne, "'#K0 AA 1',$0d" }

DEFINE_FUNCTION CLEARONE_ECHOCANCELLATION(INTEGER value) { SEND_STRING dvClearOne, "'#K0 AEC * ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_ECHOCANCELLATION_QUERY() { SEND_STRING dvClearOne, "'#K0 AEC *',$0d" }

DEFINE_FUNCTION CLEARONE_AUTOMATICGAIN(INTEGER value) { SEND_STRING dvClearOne, "'#K0 AGC * M ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_AUTOMATICGAIN_QUERY() { SEND_STRING dvClearOne, "'#K0 AGC * M',$0d" }

DEFINE_FUNCTION CLEARONE_INPUTCOMPRESSION(INTEGER value) { SEND_STRING dvClearOne, "'#K0 COMPSEL A ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_INPUTCOMPRESSION_QUERY() { SEND_STRING dvClearOne, "'#K0 COMPSEL A',$0d" }

DEFINE_FUNCTION CLEARONE_NOISECANCELLATION(INTEGER value) { SEND_STRING dvClearOne, "'#K0 NCSEL * M ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_NOISECANCELLATION_QUERY() { SEND_STRING dvClearOne, "'#K0 NCSEL * M',$0d" }

DEFINE_FUNCTION CLEARONE_MICROPHONEDECAY(INTEGER value) { SEND_STRING dvClearOne, "'#K0 DECAY * ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_MICROPHONEDECAY_QUERY() { SEND_STRING dvClearOne, "'#K0 DECAY *',$0d" }

DEFINE_FUNCTION CLEARONE_RINGER(INTEGER value) { SEND_STRING dvClearOne, "'#K0 RINGEREN * ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_RINGER_QUERY() { SEND_STRING dvClearOne, "'#K0 RINGEREN *',$0d" }

DEFINE_FUNCTION CLEARONE_CLEAREFFECT(INTEGER value) { SEND_STRING dvClearOne, "'#K0 CLEAREFFECT * ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_CLEAREFFECT_QUERY() { SEND_STRING dvClearOne, "'#K0 CLEAREFFECT *',$0d"}

DEFINE_FUNCTION CLEARONE_TELCOLEVELCONTROL(INTEGER value) { SEND_STRING dvClearOne, "'#K0 TELCOLVLCTRL 1 R ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_TELCOLEVELCONTROL_QUERY() { SEND_STRING dvClearOne, "'#K0 TELCOLVLCTRL 1 R',$0d" }

DEFINE_FUNCTION CLEARONE_TELCOECHOCANCELLATION(INTEGER value) { SEND_STRING dvClearOne, "'#K0 TLEC * R ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_TELCOECHOCANCELLATION_QUERY() { SEND_STRING dvClearOne, "'#K0 TLEC * R',$0d" }

DEFINE_FUNCTION CLEARONE_MICGAIN(INTEGER value) { SEND_STRING dvClearOne, "'#K0 GAIN * M ',itoa(value),'.00 A',$0d" }
DEFINE_FUNCTION CLEARONE_MICGAIN_QUERY() { SEND_STRING dvClearOne, "'#K0 GAIN * M',$0d" }

DEFINE_FUNCTION CLEARONE_CALLDURATION_QUERY() { SEND_STRING dvClearOne, "'#K0 CALLDUR 1',$0d" }


DEFINE_FUNCTION CLEARONE_ROUTING(CHAR paramstring[], INTEGER value) { SEND_STRING dvClearOne, "'#K0 MTRX ',paramstring,' ',itoa(value),$0d" }
DEFINE_FUNCTION CLEARONE_ROUTING_TOGGLE(CHAR paramstring[]) { CLEARONE_ROUTING(paramstring, 2) }
DEFINE_FUNCTION CLEARONE_ROUTING_QUERY(CHAR paramstring[]) { SEND_STRING dvClearOne, "'#K0 MTRX ',paramstring,$0d" }
DEFINE_FUNCTION CLEARONE_ROUTING_CLEAR_TO_DEFAULTS() {
    stack_var integer i
    stack_var integer j
    for (i = 1; i <= 5; i++) { for (j = 1; j <= 5; j++) { CLEARONE_MATRIX[i][j] = 0 } }
    
    SEND_STRING dvClearOne, "'#K0 MTRXCLEAR',$0d"
    SEND_STRING dvClearOne, "'#K0 MTRX 1 R A P 1',$0d"		// Telco -> Processing A (Telco)
    
    SEND_STRING dvClearOne, "'#K0 MTRX 1 M B P 4',$0d"		// Mics -> Processing B (Mic)
    SEND_STRING dvClearOne, "'#K0 MTRX 2 M B P 4',$0d"		// Mics -> Processing B (Mic)
    SEND_STRING dvClearOne, "'#K0 MTRX 3 M B P 4',$0d"		// Mics -> Processing B (Mic)
    
    SEND_STRING dvClearOne, "'#K0 MTRX 1 L 1 B 1',$0d"		// PC Line Out -> AEC Reference 1
    
    SEND_STRING dvClearOne, "'#K0 MTRX 1 W 1 T 1',$0d"		// USB -> Telco
    SEND_STRING dvClearOne, "'#K0 MTRX 1 W 6 O 1',$0d"		// USB -> PC Line In
    SEND_STRING dvClearOne, "'#K0 MTRX 1 W 7 O 1',$0d"		// USB -> Out Left
    SEND_STRING dvClearOne, "'#K0 MTRX 1 W 8 O 1',$0d"		// USB -> Out Right
    SEND_STRING dvClearOne, "'#K0 MTRX 1 W 1 B 1',$0d"		// USB -> AEC Reference 1
    
    SEND_STRING dvClearOne, "'#K0 MTRX A P 1 D 1',$0d"		// Telco -> USB
    SEND_STRING dvClearOne, "'#K0 MTRX A P 6 O 1',$0d"		// Processing A (Telco) -> PC Line In
    SEND_STRING dvClearOne, "'#K0 MTRX A P 7 O 1',$0d"		// Processing A (Telco) -> Out Left
    SEND_STRING dvClearOne, "'#K0 MTRX A P 8 O 1',$0d"		// Processing A (Telco) -> Out Right
    SEND_STRING dvClearOne, "'#K0 MTRX A P 1 B 1',$0d"		// Processing A (Telco) -> AEC Reference 1
    
    SEND_STRING dvClearOne, "'#K0 MTRX B P 1 T 1',$0d"		// Processing B (Mics) -> Telco
    SEND_STRING dvClearOne, "'#K0 MTRX B P 1 D 1',$0d"		// Processing B (Mics) -> USB
    SEND_STRING dvClearOne, "'#K0 MTRX B P 6 O 1',$0d"		// Processing B (Mics) -> PC Line In
}



DEFINE_EVENT
    DATA_EVENT[dvClearOne] {
	STRING: {
	    stack_var integer crpos
	    stack_var integer hashpos
	    stack_var integer lookupval
	    stack_var char bufout[80]
	    //SEND_STRING 0:0:0, "'CLEARONE Buffer: ', CLEARONE_buf"
	    
	    hashpos = FIND_STRING(CLEARONE_buf, '#K0 ', 1)
	    if (hashpos > 0) { crpos = FIND_STRING(CLEARONE_buf, "$0d", hashpos) }
	    
	    //SEND_STRING 0:0:0, "'Buf == ',CLEARONE_buf, ' - CRPOS == ', itoa(crpos), ' - HASHPOS == ', itoa(hashpos)"
	    
	    while ((hashpos > 0) and (crpos > 0)) {
		bufout = GET_BUFFER_STRING(CLEARONE_buf, crpos - 1)
		bufout = MID_STRING(bufout, hashpos + 4, crpos - hashpos - 4)
		
		CLEARONE_PROCESS_STRING(bufout)
		
		//SEND_STRING 0:0:0, "'CLEARONE Now Processing: ',bufout"
		hashpos = FIND_STRING(CLEARONE_buf, '#K0 ', 1)
		if (hashpos > 0) { crpos = FIND_STRING(CLEARONE_buf, "$0d", hashpos) }
	    }
	}
    }
    
    TIMELINE_EVENT[4] {
	switch (timeline.sequence) {
	    case 1:
	    case 2:
	    case 3:
	    case 4:
	    case 5:
	    case 6:
	    case 7:
	    case 8:
	    case 9:
	    case 10:
	    case 11:
	    case 12:{ CLEARONE_CALLDURATION_QUERY(); CLEARONE_HOOK_QUERY() }
	    case 13:{ CLEARONE_AUTOANSWER_QUERY()	}
	    case 14:{ CLEARONE_AUTOMATICGAIN_QUERY()	}
	    case 15:{ CLEARONE_CLEAREFFECT_QUERY()	}
	    case 16:{ CLEARONE_ECHOCANCELLATION_QUERY()	}
	    case 17:{ CLEARONE_INPUTCOMPRESSION_QUERY()	}
	    case 18:{ CLEARONE_MICGAIN_QUERY()		}
	    case 19:{ CLEARONE_MICROPHONEDECAY_QUERY()	}
	    case 20:{ CLEARONE_MUTE_MICS_QUERY()	}
	    case 21:{ CLEARONE_NOISECANCELLATION_QUERY() }
	    case 22:{ CLEARONE_PHONEBOOK_COUNT()	}
	    case 23:{ CLEARONE_RINGER_QUERY()		}
	    case 24:{ CLEARONE_ROUTING_QUERY(CLEARONE_MATRIX_CALL_TO_SPEAKER_LEFT) }
	    case 25:{ CLEARONE_ROUTING_QUERY(CLEARONE_MATRIX_CALL_TO_VIDYO) }
	    case 26:{ CLEARONE_ROUTING_QUERY(CLEARONE_MATRIX_VIDYO_TO_CALL) }
	    case 27:{ CLEARONE_ROUTING_QUERY(CLEARONE_MATRIX_VIDYO_TO_SPEAKER_LEFT) }
	    case 28:{ CLEARONE_ROUTING_QUERY(CLEARONE_MATRIX_MICS_TO_CALL) }
	    case 29:{ CLEARONE_ROUTING_QUERY(CLEARONE_MATRIX_MICS_TO_VIDYO) }
	    case 30:{  }
	}
    }
    
DEFINE_START
    CLEARONE_SET_BAUD()
    CREATE_BUFFER dvClearOne, CLEARONE_buf
    TIMELINE_CREATE(4, CLEARONE_TIMELINE, 30, TIMELINE_RELATIVE, TIMELINE_REPEAT)

#end_if