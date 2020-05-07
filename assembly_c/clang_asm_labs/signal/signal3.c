#include <signal.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <sys/time.h>


#define DELAY 250000

static uint64_t startT, stopT;

// function copied from Lecturer Hans-Wolfgang Loidl's work
uint64_t timeInMicroseconds(){
  struct timeval tv, tNow, tLong, tEnd ;
  uint64_t now ;
  // gettimeofday (&tNow, NULL) ;
  gettimeofday (&tv, NULL) ;
  now  = (uint64_t)tv.tv_sec * (uint64_t)1000000 + (uint64_t)tv.tv_usec ; // in us
  // now  = (uint64_t)tv.tv_sec * (uint64_t)1000 + (uint64_t)(tv.tv_usec / 1000) ; // in ms

  return (uint64_t)now; // (now - epochMilli) ;
}

void timer_handler(int sigNumber)
{
	static int counter = 0;
	stopT = timeInMicroseconds();
	counter++;
	if(startT) fprintf(stderr, "timer expired %d times; (measured interval %f sec)\n", counter, (stopT-startT)/1000000.0);
	startT = timeInMicroseconds();
}

int main ()
{
	struct sigaction sa;
	struct itimerval timer;
	
	fprintf(stderr, "Configuring a timer with a delay od %d micro seconds ... \n", DELAY);
	
	
	memset(&sa, 0, sizeof(sa));
	
	
	sa.sa_handler = &timer_handler;
	
	sigaction(SIGALRM, &sa, NULL);
	
	
	timer.it_value.tv_sec = 0;
	timer.it_value.tv_usec = DELAY;
	
	timer.it_interval.tv_sec = 0;
	timer.it_interval.tv_usec = DELAY;
	
	setitimer(ITIMER_REAL, &timer, NULL);
	
	while(1) {};
	
}
