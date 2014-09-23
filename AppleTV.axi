PROGRAM_NAME='AppleTV'

#if_not_defined __ATV__
#define __ATV__


DEFINE_DEVICE

    dvATV = 5001:5:1
    

DEFINE_CONSTANT

    // INPUT SELECTION
    
    ATV_IR_PLAYPAUSE	= 1
    ATV_IR_MENU		= 44
    ATV_IR_UP		= 45
    ATV_IR_DOWN		= 46
    ATV_IR_LEFT		= 47
    ATV_IR_RIGHT	= 48
    ATV_IR_OK		= 49
    
    
    
#end_if
