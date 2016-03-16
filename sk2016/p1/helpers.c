#include "helpers.h"

static uint8_t buf[IP_MAXPACKET];

void err(const char * msg, int val)
{
  if (val < 0)
  {
    fprintf(stderr, "%s: (%d) %s\n", msg, errno, strerror(errno));
    exit(1);
  }

  #ifdef DEBUG
  printf("[DEBUG] %s: OK!\n", msg);
  #endif
}

// checksum function by ~mbi
u_int16_t compute_icmp_checksum (const void * buff, int length)
{
  u_int32_t sum;
  const u_int16_t * ptr = buff;
  assert (length % 2 == 0);
  for (sum = 0; length > 0; length -= 2)
    sum += * ptr++;
  sum = (sum >> 16) + (sum & 0xffff);
  return (u_int16_t)(~(sum + (sum >> 16)));
}

void traceroute(int sockfd, struct sockaddr_in address)
{
  struct in_addr received_addresses[PER_TTL];
  int received;
  time_t avg;
  bool reached = false;
  
  for (uint8_t ttl = 1; ttl <= TTL_MAX; ttl++)
  {
    send_icmps_with_ttl(sockfd, address, ttl);
    reached = receive_icmps(sockfd, ttl, received_addresses, &received, &avg);

    printf("%d. ", ttl);
    print_addresses(received_addresses, received);
    if (received == PER_TTL)
      printf(" %lums\n", avg);
    else if (received > 0)
      printf(" ???\n");

    if (reached)
      break;
  }
}

int addr_cmp(const void * l, const void * r)
{
  return ((struct in_addr *)l)->s_addr - ((struct in_addr *)r)->s_addr;
}
  

void print_addresses(struct in_addr * addresses, int received)
{
  qsort(addresses, received, sizeof(* addresses), addr_cmp);
  
  if (received == 0)
  {
    printf("*\n");
    return;
  }
  else
    printf("%s", inet_ntoa(addresses[0]));

  for (int i = 1; i < received; i++)
  {
    if (addresses[i - 1].s_addr == addresses[i].s_addr)
      continue;
    printf(" %s", inet_ntoa(addresses[i]));
  }
}

void send_icmps_with_ttl(int sockfd, const struct sockaddr_in address, uint8_t ttl)
{
  for (unsigned int i = 0; i < PER_TTL; i++)
  {
    struct icmphdr to_send;
    to_send.type = ICMP_ECHO;
    to_send.code = 0;
    to_send.un.echo.id = getpid(); // later used to check if it is our
    to_send.un.echo.sequence = ttl; // so we know from which 'level of ttl' it came
    to_send.checksum = 0;
    to_send.checksum = compute_icmp_checksum((u_int16_t*)&to_send, sizeof(to_send));

    err("Setting ttl", setsockopt(sockfd, IPPROTO_IP, IP_TTL, &ttl, sizeof(ttl)));
    err("Sending packet", sendto(sockfd, &to_send, 8, 0, &address, sizeof(address)));
  }
}

// 0 - received packet from target
// 1 - received packet but not from target
// -1 - non interesting packet (wrong pid or ttl) or nothing to report
int receive_icmp(const int sockfd, uint8_t ttl, struct in_addr * address)
{
  int ret = recv(sockfd, buf, IP_MAXPACKET, MSG_DONTWAIT);

  if (ret < 0 && errno == EWOULDBLOCK)
    return -1;
  else
    err("Receiving packet", ret);

  struct ip * ip_packet = (struct ip *) buf;
  struct icmp * icmp_packet = (struct icmp *)((uint8_t *)ip_packet + ip_packet->ip_hl * 4);

  if (icmp_packet->icmp_type == ICMP_TIME_EXCEEDED && icmp_packet->icmp_code == ICMP_EXC_TTL)
  {
    struct ip * orig_ip_packet = (struct ip *)((uint8_t *)icmp_packet + ICMP_HEADER);
    struct icmp * orig_icmp_packet = (struct icmp *)((uint8_t *)orig_ip_packet + orig_ip_packet->ip_hl * 4);

    if (orig_icmp_packet->icmp_id == getpid() && orig_icmp_packet->icmp_seq == ttl)
    {
      // received packet from computer on route to target (time exceeded)
      *address = ip_packet->ip_src;
      return 1;
    }
  }
  else if (icmp_packet->icmp_id == getpid() && icmp_packet->icmp_seq == ttl && icmp_packet->icmp_type == ICMP_ECHOREPLY)
  {
    // received packet from target
    *address = ip_packet->ip_src;
    return 0;
  }
  return -1;
}

bool receive_icmps(int sockfd, uint8_t ttl, struct in_addr * received_addresses, int * received, time_t * avg)
{
  *received = 0;
  bool reached = false;
  struct timespec start, lap;
  time_t total_time = 0;
  
  clock_gettime(CLOCK_REALTIME, &start);
  clock_gettime(CLOCK_REALTIME, &lap);
  
  while (*received < PER_TTL)
  {
    struct timespec elapsed;
    elapsed.tv_nsec = lap.tv_nsec - start.tv_nsec;
    elapsed.tv_sec = lap.tv_sec - start.tv_sec;

    time_t elapsed_ms = elapsed.tv_sec * 1000 + elapsed.tv_nsec / 1000000;

    if (elapsed_ms > TIMEOUT)
      break;

    int ret = receive_icmp(sockfd, ttl, received_addresses + *received);
    if (ret == 0)
    {
      (*received)++;
      total_time += elapsed_ms;
      reached = true;
    }
    else if (ret == 1)
    {
      (*received)++;
      total_time += elapsed_ms;
    }
    clock_gettime(CLOCK_REALTIME, &lap);
  }

  if (*received > 0)
    *avg = total_time / *received;
  
  return reached;
}
