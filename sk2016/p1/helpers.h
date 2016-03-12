#ifndef _HELPERS_H_
#define _HELPERS_H_

#define TTL_MAX 30
#define PER_TTL 3
#define TIMEOUT 1000

//
#define ICMP_HEADER 8

//

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <time.h>
#include <sys/socket.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <assert.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdint.h>
#include <inttypes.h>

void err(const char * msg, int val);
u_int16_t compute_icmp_checksum (const void * buff, int length);
void traceroute(int sockfd, struct sockaddr_in address);
void print_addresses(struct in_addr * addresses, int received);
void send_icmps_with_ttl(int sockfd, struct sockaddr_in address, uint8_t ttl);
bool receive_icmps(int sockfd, uint8_t ttl, struct in_addr * received_addresses, size_t * received, time_t * avg);

#endif
