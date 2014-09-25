PROGRAM_NAME='Vidyo'

#if_not_defined __VIDYO__
#define __VIDYO__


DEFINE_DEVICE

    dvVidyo = 5001:6:1
    

DEFINE_CONSTANT

    

DEFINE_FUNCTION VIDYO_SET_BAUD() {
    SEND_COMMAND dvVidyo, 'SET MODE IR'
}

DEFINE_START
    VIDYO_SET_BAUD()


#end_if
