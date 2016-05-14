#ifndef _HELPERS_H_
#define _HELPERS_H_

#define PART_SIZE 1000
// timeout in microseconds
#define TIMEOUT 250000
#define MAX_UDP_SIZE 65507

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <assert.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdint.h>
#include <inttypes.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/ip.h>
#include <sys/time.h>
#include <sys/types.h>

void error(const char * message, int value);
void fail(const char * message);
bool send_requests(const int sockfd, const struct sockaddr_in addr, bool * received, const int file_size, const int parts);
void receive_file(const int sockfd, const struct sockaddr_in addr, bool * received, char * buffer);


#endif
