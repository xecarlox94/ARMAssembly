#include <stdio.h>
#include <stdlib.h>
#include <signal.h>


void handler(int sig)
{
	static int beeps = 0;
	
	printf("BEEP %d\n", (beeps + 1));
	
	if (++beeps < 5)
	{
		alarm(1);
	}
	else 
	{
		printf("BOOM!\n");
		exit(1);
	}
}


int main() 
{
	signal(SIGALRM, handler);
	
	alarm(1);
	
	while(1) 
	{
	};
	
	exit(0);
}
