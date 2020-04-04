
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>


extern int openf(void);

extern void closef(int fd);

extern int mapm(int fd);

extern void fsel(int gpio, int pin, int mode);

extern void fset(int gpio, int pin, int bitValue);

extern void fclr(int gpio, int pin);

extern int flev(int gpio, int pin);

int main(void)
{
	int fd;
	
	static volatile uint32_t *gpio;
	
	
	fd = openf();
	
	
	printf("file handler: %d\n", fd);
	
	
	gpio = (uint32_t *) mapm(fd);
	
	
	printf("gpio address: %d\n", (int) gpio);
	
	
	fsel(gpio, 19, 0);
	fsel(gpio, 13, 1);
	fsel(gpio, 15, 1);
	
	fset(gpio,19,1);
	fset(gpio,13,1);
	
	while (1)
	{
		
		if (flev(gpio,19)) printf("BUTTON PRESSED!!!!!!\n");
		else printf("btn NOT pressed\n");
	}
	printf("\n");
	
	fclr(gpio,19,1);
	fclr(gpio,13,1);
	
	closef(fd);
	
}
