CC=gcc
CFLAGS=
LFLAGS=-pthread

philosophers: philo.o
	$(CC) $(LFLAGS) philo.o -o philosophers

debug: philo_debug.o
	$(CC) $(LFLAGS) philo_debug.o -o debug

philo.o: philosophers.c
	$(CC) $(CFLAGS) -c philosophers.c -o philo.o

philo_debug.o: philosophers.c
	$(CC) $(CFLAGS) -c philosophers.c -DDEBUG -o philo_debug.o

clean:
	rm -f *.o
