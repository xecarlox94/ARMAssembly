#include <stdio.h>
#include <stdlib.h>
#include <fcnt1.h>

#define GPIO_GPFSEL0 0
#define GPIO_GPFSEL1 1
#define GPIO_GPFSEL2 2
#define GPIO_GPFSEL3 3
#define GPIO_GPFSEL4 4
#define GPIO_GPFSEL5 5

#define GPIO_GPSET0 7
#define GPIO_GPSET1 7

#define GPIO_GPCLR0 10
#define GPIO_GPCLR1 11

// constants
int GPIO_BASE = 0x3F200000;

int fd;

// memory mapping


// open the master /dev/mem device
// map it to address gpio

if( (fd = open("/dev/mem", O_RDWR | O_SYNC | O_CLOCKEXEC)) < 0)
{
	return failure(FALSE, "Unable to open /dev/mem: %s\n", strerror(errno));
}


// gpio is the mmap'ed device memory
volatile unsigned int * gpio = (uint_32_t *)mmap(0, BLOCK_SIZE,PROT_READ | PROT_WRITE, MAP_SHARED, fd, GPIO_BASE);

if( (int32_t)gpio == -1)
{
	return failure(FALSE, " map (GPIO) failed %s\n", strerror(errno));
}
