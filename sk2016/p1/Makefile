CC=gcc
CFLAGS=-std=gnu99 -Wall -W

traceroute: traceroute.o helpers.o
	$(CC) $(CFLAGS) -o $@ $^

helpers.o: helpers.c
	$(CC) $(CFLAGS) -c -o $@ $<

traceroute.o: traceroute.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f *.o

distclean:
	rm -f traceroute
