#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void sigproc(int sig)
{
  fprintf(stderr,"\nYou pressed ctr-C\n", sig);
}


void quitproc(int sig)
{
  fprintf(stderr,"\nYou pressed ctr-\\ \n", sig);
  exit(1);
}

int main()
{
  signal(SIGINT, sigproc);
  
  signal(SIGQUIT, quitproc);
  
  while(1) {}
}
