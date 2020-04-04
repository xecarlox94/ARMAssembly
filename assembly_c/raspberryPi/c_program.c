
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>


extern int openf(void);

extern void closef(int fd);

extern int mapm(int fd);


int main(void)
{
	int fd;
	
	static volatile uint32_t *gpio ;
	
	
	fd = openf();
	
	
	printf("file handler: %d\n", fd);
	
	
	gpio = (uint32_t *) mapm(fd);
	
	
	printf("gpio address: %d\n", (int) gpio);
	
	
	
	
	
	
	while (1)
	{
		
	}
	
	closef(fd);
	
}
