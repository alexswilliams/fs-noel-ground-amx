PROGRAM_NAME='AtlonaATLINE'

#if_not_defined __AtlonaATLINE__
#define __AtlonaATLINE__


DEFINE_DEVICE
    
    dvSwitcher = 5001:8:1
    

DEFINE_CONSTANT


DEFINE_VARIABLE
    CHAR bSWITCHER_Baud_Set = 'f'
    CHAR bufSWITCHER[256]
    INTEGER SWITCHER_CRPOS
    CHAR SWITCHER_BUFOUT[64]
    LONG SWITCHER_TIMELINE[9] = {11000, 100, 100, 100, 100, 100, 100, 100, 100}

DEFINE_FUNCTION SWITCHER_CALLBACK (DEV device, CHAR event[], CHAR paramStr[], INTEGER paramInt) {
    //SEND_STRING 0:0:0, "'AVR - ',event,': ',paramStr, ' (',itohex(paramInt),')'"
    
}


DEFINE_FUNCTION SWITCHER_SET_BAUD() {
    if (bSWITCHER_Baud_Set == 'f') {
	bSWITCHER_Baud_Set = 't'
	SEND_COMMAND dvSWITCHER, 'SET MODE SERIAL'
	SEND_COMMAND dvSWITCHER, 'SET BAUD 19200,N,8,1'
    }
}


DEFINE_EVENT


    DATA_EVENT[dvSWITCHER] {
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
    SWITCHER_SET_BAUD()
    CREATE_BUFFER dvSWITCHER, bufSWITCHER
    TIMELINE_CREATE(1, SWITCHER_TIMELINE, 9, TIMELINE_RELATIVE, TIMELINE_REPEAT)
    


#end_if
