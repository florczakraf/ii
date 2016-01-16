#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>

#define N 4
#define TARGET 10

#ifdef DEBUG
    #define DEB(x) x
#else
    #define DEB(x)
#endif

enum STATE
{
  thinking,
  eating,
  hungry
};

inline int left (int i)
{
  return (i + N - 1) % N;
}

inline int right (int i)
{
  return (i + 1) % N;
}

typedef struct
{
  sem_t mutex;
  sem_t is_in_use[N];
  enum STATE state[N];
  int ate[N]; // to stop program eventually
} shared_data;

shared_data * shared;

void test(int i) // philosopher #i eats if he can
{
  if( shared->state[i] == hungry && shared->state[left(i)] != eating && shared->state[right(i)] != eating)
  {
    shared->state[i] = eating;
    DEB(printf("Philosopher #%d takes spoons: %d and %d\n", i + 1, left(i) + 1, i + 1));
    shared->ate[i] += 1;
    DEB(printf("Philosopher #%d eats\n", i + 1);)
    sem_post(&shared->is_in_use[i]);
  }
}

void init_shared() // initiates shared memory
{
  int i;
  int prot = PROT_READ | PROT_WRITE;
  int flags = MAP_SHARED | MAP_ANONYMOUS;
  shared = mmap(0, sizeof(*shared), prot, flags, -1, 0);
  sem_init(&shared->mutex, 1, 1);
  for(i = 0; i < N; i++)
  {
    sem_init(&shared->is_in_use[i], 1, 1);
    shared->state[i] = thinking;
    shared->ate[i] = 0;
  }
}

void take_spoon(int i) // waits until philosopher #i can eat
{
  sem_wait(&shared->mutex);
  shared->state[i] = hungry;
  DEB(printf("Philosopher #%d is hungry\n", i + 1);)
  test(i);
  sem_post(&shared->mutex);
  sem_wait(&shared->is_in_use[i]);
}

int finished() // tests if all philosophers reached TARGET
{
  int c = N, i;
  for (i = 0; i < N; i++)
  {
    if (shared->ate[i] >= TARGET)
      c--;
  }
  return !c;
}

void put_spoon(int i) // philosopher #i informs his neighbours that he finished eating
{
  sem_wait(&shared->mutex);
  shared->state[i] = thinking;
  DEB(printf("Philosopher #%d puts down spoons: %d and %d\n", i + 1, left(i) + 1, i + 1));

  DEB(if (shared->ate[i] == TARGET)
  {
    printf("Philosopher #%d reached target\n", i + 1);
  })
  
  DEB(printf("Philosopher #%d thinks\n", i + 1));

  test(left(i));
  test(right(i));
  
  sem_post(&shared->mutex);
}

void philosopher(int i) // loop for each philosopher
{
  while(1)
  {
    DEB(sleep(1));
    take_spoon(i);
    DEB(sleep(1));
    put_spoon(i);
    DEB(sleep(1));

    if (finished())
      return;
  }
}

int main(void)
{
  int i;
  pid_t pid, pids[N];
  init_shared();

  for(i = 0; i < N; i++)
  {
    pid = fork();
    if(pid == 0)
    {
      // child
      philosopher(i);
      _exit(0);
    }
    else if(pid > 0)
    {
      // parent
      pids[i] = pid;
      printf("Starting process with pid %d\n", pids[i]);
    }
    else
    {
      perror("There was an error while fork operation");
      exit(0);
    }
  }

  for(i = 0; i < N; i++) // waiting until all children are done
    waitpid(pids[i], NULL, 0);

  printf("-----RESULTS-----\nN = %d\nTARGET = %d\n", N, TARGET);
  
  for (i = 0; i < N; i++)
  {
    printf("Philosopher #%d ate %d times\n", i + 1, shared->ate[i]);
  }

  //cleaning
  for(i = 0; i < N; i++)
    sem_destroy(&shared->is_in_use[i]);
  sem_destroy(&shared->mutex);
  munmap(shared, sizeof(*shared));

  return 0;
}
