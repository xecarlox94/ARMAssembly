// Button-controlled LED (in C), now truly standalone, controlling LED and button
// Same as tinkerHaWo35.c but using different pins: pin 23 for LED, pin 24 for button

// Compile: gcc  -o  t tut_button.c
// Run:     sudo ./t

#include <stdio.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdlib.h>
#include <ctype.h>
#include <poll.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/ioctl.h>

// original code based in wiringPi library by Gordon Henderson
// #include "wiringPi.h"

// =======================================================
// Tunables
// PINs (based on BCM numbering)
#define LED 23
#define BUTTON 24
// delay for loop iterations (mainly), in ms
#define DELAY 200
// =======================================================

#ifndef	TRUE
#define	TRUE	(1==1)
#define	FALSE	(1==2)
#endif

#define	PAGE_SIZE		(4*1024)
#define	BLOCK_SIZE		(4*1024)

#define	INPUT			 0
#define	OUTPUT			 1

#define	LOW			 0
#define	HIGH			 1

static volatile unsigned int gpiobase ;
static volatile uint32_t *gpio ;


// Mask for the bottom 64 pins which belong to the Raspberry Pi
//	The others are available for the other devices

#define	PI_GPIO_MASK	(0xFFFFFFC0)

/* ------------------------------------------------------- */

int failure (int fatal, const char *message, ...)
{
  va_list argp ;
  char buffer [1024] ;

  if (!fatal) //  && wiringPiReturnCodes)
    return -1 ;

  va_start (argp, message) ;
  vsnprintf (buffer, 1023, message, argp) ;
  va_end (argp) ;

  fprintf (stderr, "%s", buffer) ;
  exit (EXIT_FAILURE) ;

  return 0 ;
}

/* Main ----------------------------------------------------------------------------- */

int main (void)
{
  int pinLED = LED, pinButton = BUTTON;
  int fSel, shift, pin,  clrOff, setOff, off;
  int   fd ;
  int   j;
  int theValue, thePin;
  unsigned int howLong = DELAY;
  uint32_t res; /* testing only */

  printf ("Raspberry Pi button controlled LED (button in %d, led out %d)\n", BUTTON, LED) ;
  
  

  if (geteuid () != 0)
    fprintf (stderr, "setup: Must be root. (Did you forget sudo?)\n") ;

  // -----------------------------------------------------------------------------
  // constants for RPi2
  gpiobase = 0x3F200000 ;

  // -----------------------------------------------------------------------------
  // memory mapping 
  // Open the master /dev/memory device

  if ((fd = open ("/dev/mem", O_RDWR | O_SYNC | O_CLOEXEC) ) < 0)
    return failure (FALSE, "setup: Unable to open /dev/mem: %s\n", strerror (errno)) ;
    
	
	printf("file handler: %d\n", fd);

  // GPIO:
  gpio = (uint32_t *)mmap(0, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, gpiobase) ;
  if ((int32_t)gpio == -1)
    return failure (FALSE, "setup: mmap (GPIO) failed: %s\n", strerror (errno)) ;

  // -----------------------------------------------------------------------------
  // setting the mode
  
  
	printf("gpio address: %d\n", (int) gpio);
  


  // controlling LED pin 10
  *(gpio + 1) = (*(gpio + 1) & ~(0b111)) | 0b1;  // Sets bits to one = output
  
  // controlling LED pin 11
  *(gpio + 1) = (*(gpio + 1) & ~(0b111000)) | 0b1000;  // Sets bits to one = output
  
  // controlling LED pin 13
  *(gpio + 1) = (*(gpio + 1) & ~(0b111000000000)) | 0b1000000000;  // Sets bits to one = output
  
  
  

  // controlling button pin 26
  *(gpio + 1) = (*(gpio + 1) & ~(0b111 << 27)); // Sets bits to one = output
  
  
  
  

  // -----------------------------------------------------------------------------

  // now, start a loop, listening to pinButton and if set pressed, set pinLED
 fprintf(stderr, "starting loop ...\n");
 for (j=0; j<=70; j++)
  {
	  
	  if ((pinButton & 0xFFFFFFC0 /* PI_GPIO_MASK */) == 0)		// On-Board Pin; bottom 64 pins belong to the Pi
	  {
		  theValue = LOW ;
		  if ((*(gpio + 13 /* GPLEV0 */) & (0b1 << 19)) != 0)
		  {
			  //theValue = HIGH;
			  printf("button pressed!\n");
			  j = 0;
			  
		  } else 
		  {
			  //theValue = LOW ;
			  printf("button NOT pressed!\n");
		  }
	  } else 
	  {
		  fprintf(stderr, "only supporting on-board pins\n");
		  exit(1);
	  }

    if ((pinLED & 0xFFFFFFC0 /*PI_GPIO_MASK */) == 0)
    {
		if( j <= 10) {
			// red on
			
			*(gpio + 7) = 0b10000000000;
			// all other off
			
			*(gpio + 10) = 0b100000000000;
			
			// controlling LED pin 13
			*(gpio + 10) = 0b10000000000000;
			
			
		} else if ( j > 10 && j <=20 ) {
			// red on
			
			// yellow on
			
			// controlling LED pin 11
			*(gpio + 7) = 0b100000000000;
			
		} else if ( j > 20 && j <=30 ) {
			
			// controlling LED pin 10
			*(gpio + 10) = 0b10000000000;
			
			// controlling LED pin 11
			*(gpio + 10) = 0b100000000000;
			
			// controlling LED pin 13
			*(gpio + 7) = 0b10000000000000;
			
		} else if ( j > 30 && j <=40 ) {
			
			// all off
			// controlling LED pin 13
			*(gpio + 10) = 0b10000000000000;
			
		} else if ( j > 40 && j <=50 ) {
			
			// green on
			// controlling LED pin 13
			*(gpio + 7) = 0b10000000000000;
			// all off
			
		} else if ( j > 50 && j <=60 ) {
			// controlling LED pin 13
			*(gpio + 10) = 0b10000000000000;
			
			if ((j % 2) == 0)
			{
				
				// controlling LED pin 11
				*(gpio + 10) = 0b100000000000;
			} else {
				
				// controlling LED pin 11
				*(gpio + 7) = 0b100000000000;
			}
			
			
		} else if ( j > 60 && j <=70 ) {
			// red on
			// controlling LED pin 11
			*(gpio + 10) = 0b100000000000;
			
			// controlling LED pin 10
			*(gpio + 7) = 0b10000000000;
			
		}
		
	} else
	{
		fprintf(stderr, "only supporting on-board pins\n");          
		exit(1);
	}

    // INLINED delay
    {
      struct timespec sleeper, dummy ;

      // fprintf(stderr, "delaying by %d ms ...\n", howLong);
      sleeper.tv_sec  = (time_t)(howLong / 1000) ;
      sleeper.tv_nsec = (long)(howLong % 1000) * 1000000 ;

      nanosleep (&sleeper, &dummy) ;
    }
  }
 // Clean up: write LOW
 //*(gpio + 7) = 1 << (23 & 31) ;
 
 
 // controlling LED pin 10
 *(gpio + 10) = 0b10000000000;
 
 // controlling LED pin 11
 *(gpio + 10) = 0b100000000000;
 
 // controlling LED pin 13
 *(gpio + 10) = 0b10000000000000;

 fprintf(stderr, "end main.\n");
}
