CC=gcc
CFLAGS=-std=gnu99 -Wall -W

client-udp: client-udp.o helpers.o
	$(CC) $(CFLAGS) -o $@ $^

helpers.o: helpers.c
	$(CC) $(CFLAGS) -c -o $@ $<

client-udp.o: client-udp.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f *.o

distclean:
	rm -f client-udp
