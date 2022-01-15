#!/bin/bash

#build docker image run in docker directory:
# docker build -t stm_operate .   

FLASH=0
DEBUG=0
GDB=0
PRJ=.
CLEAN=0

STM32CUBEPATH=$(pwd)/stm32cubef1/STM32Cube_FW_F1_V1.7.0/
FREERTOSPATH=$(pwd)/FreeRTOSv202107.00/FreeRTOS/

while getopts cdgufp: option 
do 
 case "${option}" 
 in
     u) echo "Usage:
 -p <progect> - directory
 -f - flash to board
 -d - start debugger
 -g - start debugger
 -c - clean the project
 -u - usage"
        exit 0
        ;;
     p) PRJ=${OPTARG};;
     c) CLEAN=1;;
     f) FLASH=1;;
     d) DEBUG=1;;
     g) GDB=1;;
     *) echo "Wrong option. Use -u for usage info"
        exit 0
        ;;
 esac 
done

MOUNTPATHS="-v $(pwd)/$PRJ:/home/user/stm -v $STM32CUBEPATH:/home/user/stm32cubef1 -v $FREERTOSPATH:/home/user/FreeRTOS"
DOCKERPARAMS=" --rm=true --network host "
if [ "$CLEAN" = "1" ]; then
    echo "Cleaning..."
    docker run $DOCKERPARAMS  $MOUNTPATHS  stm_operate "scons -c"
    exit 0
fi

echo "Building..."
docker run $DOCKERPARAMS $MOUNTPATHS stm_operate "scons --debug=includes"

if [ "$?" != "0" ]; then
	echo Compilation failed
	exit $?
fi

if [ "$FLASH" = "1" ]; then
    echo "Flashing..."
    docker run $DOCKERPARAMS  $MOUNTPATHS  -ti --privileged -v /dev/bus/usb:/dev/bus/usb \
       stm_operate "openocd -f /usr/local/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/local/share/openocd/scripts/target/stm32f1x.cfg -c \"program main.bin 0x08000000 verify reset exit\" "
fi

if [ "$DEBUG" = "1" ]; then
    docker run $DOCKERPARAMS  $MOUNTPATHS -ti --privileged -v /dev/bus/usb:/dev/bus/usb \
       stm_operate "ifconfig; openocd -f /usr/local/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/local/share/openocd/scripts/target/stm32f1x.cfg" 
fi

if [ "$GDB" = "1" ]; then
    docker run $DOCKERPARAMS -ti  $MOUNTPATHS -ti --privileged -v /dev/bus/usb:/dev/bus/usb \
       stm_operate  "gdb-multiarch /home/user/stm/main.elf"

fi
