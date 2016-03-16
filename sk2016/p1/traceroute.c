#include "helpers.h"

int main(int argc, char * argv[])
{
  struct sockaddr_in address;
  int ret;
  
  if (argc != 2)
  {
    fprintf(stderr, "\nUsage: %s <address>\n", argv[0]);
    fprintf(stderr, "- address is target for traceroute\n");
    exit(1);
  }

  // check address
  ret = inet_pton(AF_INET, argv[1], &address.sin_addr);
  if (ret <= 0)
  {
    fprintf(stderr, "Invalid target address.\n");
    return 1;
  }
  #ifdef DEBUG
    printf("[DEBUG] Address is correct.\n");
  #endif
  
  int sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
  err("Creating socket", sockfd);

  address.sin_family = AF_INET;
  traceroute(sockfd, address);

  return 0;
}

