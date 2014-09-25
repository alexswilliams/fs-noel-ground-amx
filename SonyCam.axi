PROGRAM_NAME='SonyCam'

#if_not_defined __CAM__
#define __CAM__


DEFINE_DEVICE

    dvCam = 5001:7:1
    

DEFINE_CONSTANT

    

DEFINE_FUNCTION CAM_SET_BAUD() {
    SEND_COMMAND dvCam, 'SET MODE IR'
}

DEFINE_START
    CAM_SET_BAUD()


#end_if
