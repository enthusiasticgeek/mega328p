MCU=atmega328p
F_CPU=16000000UL
CC=avr-gcc
file=1
OBJCOPY=avr-objcopy
CFLAGS=-std=c99 -Wall -g -Os -mmcu=${MCU} -DF_CPU=${F_CPU} -I.
TARGET=$(file)
SRCS=$(file).c
INTERFACE=/dev/ttyUSB0
all:
	${CC} ${CFLAGS} -o ${TARGET}.bin ${SRCS}
	${OBJCOPY} -j .text -j .data -O ihex ${TARGET}.bin ${TARGET}.hex
flash:
	avrdude -p ${MCU} -c arduino -U flash:w:${TARGET}.hex:i -F -P ${INTERFACE}
clean:
	rm -f *.bin *.hex
