#include <signal.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <sys/time.h>

// sytem call codes
#define SETITIMER 104
#define GETITIMER 105
#define SIGACTION 67

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


/*
int getitimer(int which, struct itimerval *curr_value);
int setitimer(int which, const struct itimerval *new_value,
              struct itimerval *old_value);

int sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oldact);
*/


static inline int getitimer_asm(int which, struct itimerval *curr_value)
{
	int res
	
	asm volatile (
		"\t MOV R0, %[which]\n"
		"\t LDR R1, %[buffer]\n"
		"\t MOV R7, %[getitimer]\n"
		"\t SWI 0\n"
		"\t MOV %[result], R0\n"
		: [result] "=r" (res)
		: [buffer] "m" (curr_value)
		, [which] "r" (ITIMER_REAL)
		, [getitimer] "r" (GET_ITIMER)
		: "r0","r1","r7","cc");
	
	return res;
}


static inline int setitimer_asm(int which, const struct itimerval *new_value, struct itimerval *old_value)
{
	int res
	
	asm(
		"\t MOV R0, %[which]\n"
		"\t LDR R1, %[buffer1]\n"
		"\t LDR R2, %[buffer2]\n"
		"\t MOV R7, %[setitimer]\n"
		"\t SWI 0\n"
		"\t MOV %[result], R0\n"
		: [result] "=r" (res)
		: [buffer1] "m" (new_value)
		, [buffer2] "m" (old_value)
		, [which] "r" (ITIMER_REAL)
		, [setitimer] "r" (SET_ITIMER)
		: "r0","r1","r2","r7","cc");
	
	return res;
}

int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
{
	int res
	
	asm(
		"\t MOV R0, %[signum]\n"
		"\t LDR R1, %[buffer1]\n"
		"\t LDR R2, %[buffer2]\n"
		"\t MOV R7, %[sigaction]\n"
		"\t SWI 0\n"
		"\t MOV %[result], R0\n"
		: [result] "=r" (res)
		: [buffer1] "m" (act)
		, [buffer2] "m" (oldact)
		, [signum] "r" (signum)
		, [sigaction] "r" (SIGACTION)
		: "r0","r1","r2","r7","cc");
	
	return res;
}

int main ()
{
	struct sigaction sa;
	struct itimerval timer;
	
	fprintf(stderr, "Configuring a timer with a delay od %d micro seconds ... \n", DELAY);
	
	
	memset(&sa, 0, sizeof(sa));
	
	
	sa.sa_handler = &timer_handler;
	
	sigaction_asm(SIGALRM, &sa, NULL);
	
	
	timer.it_value.tv_sec = 0;
	timer.it_value.tv_usec = DELAY;
	
	timer.it_interval.tv_sec = 0;
	timer.it_interval.tv_usec = DELAY;
	
	setitimer_asm(ITIMER_REAL, &timer, NULL);
	
	while(1) {};
	
}
