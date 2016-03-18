#ifndef _HELPERS_H_
#define _HELPERS_H_

#define TTL_MAX 30
#define PER_TTL 3
#define TIMEOUT 1000
#define ICMP_HEADER 8

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
#include <netinet/ip_icmp.h>
#include <netinet/in.h>

void error(const char * message, int value);
u_int16_t compute_icmp_checksum (const void * buff, int length);
void traceroute(const int sockfd, const struct sockaddr_in address);
void print_addresses(struct in_addr * addresses, const int received);
void send_icmps_with_ttl(const int sockfd, const struct sockaddr_in address, const u_int8_t ttl);
bool receive_icmps(const int sockfd, const u_int8_t ttl, struct in_addr * received_addresses, int * received, time_t * avg);

#endif
