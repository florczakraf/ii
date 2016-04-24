// Rafal Florczak 265304

#include "helpers.h"

void error(const char * message, int value)
{
  if (value < 0)
  {
    fprintf(stderr, "%s: (%d) %s\n", message, errno, strerror(errno));
    exit(1);
  }

  #ifdef DEBUG
  printf("[DEBUG] %s: OK!\n", msg);
  #endif
}

void fail(const char * message)
{
  fprintf(stderr, "\n%s\n", message);
  exit(1);
}

void receive_file(const int sockfd, const struct sockaddr_in addr, bool * received, const int parts, char * buffer)
{
  char * tmp = malloc(MAX_UDP_SIZE * sizeof(char));

  struct timeval tv;
  tv.tv_sec = TIMEOUT;
  tv.tv_usec = 0;

  fd_set descriptors;
  FD_ZERO(&descriptors);
  FD_SET(sockfd, &descriptors);

  int ready = select(sockfd+1, &descriptors, NULL, NULL, &tv);
  error("Select", ready);
  if (ready)
  {
    struct sockaddr_in sender;
    socklen_t sender_size = sizeof(sender);

    int result = recvfrom(sockfd, tmp, MAX_UDP_SIZE, NULL, (struct sockaddr *) &sender, &sender_size);
    if (result <= 0)
      fail("Socket should not be empty at this moment because we use Select");

    if (sender.sin_addr.s_addr != addr.sin_addr.s_addr || sender.sin_port != addr.sin_port)
      return;
      //continue; // These aren't the packets we are looking for.

    int data_offset;
    int offset, size;
    sscanf(tmp, "DATA %d %d%n", &offset, &size, &data_offset);

    if (!received[offset / PART_SIZE])
    {
      memcpy(buffer + offset, tmp + data_offset + 1, size);
      received[offset / PART_SIZE] = true;
      #ifdef DEBUG
      printf("Received: %d/%d\n", offset/PART_SIZE + 1, parts);
      #endif
    }
  }

  free(tmp);
}

int send_request(const int sockfd, const struct sockaddr_in addr, const int file_size, const int offset)
{
  char * buffer = malloc(65507 * sizeof(char));
  int size = ((file_size - offset) < PART_SIZE) ? (file_size - offset) : PART_SIZE;
  sprintf(buffer, "GET %d %d\n", offset, size);
  error("Sending GET request", sendto(sockfd, buffer, strlen(buffer), 0, (struct sockaddr *) &addr, sizeof(addr)));
  free(buffer);
}

int send_requests(const int sockfd, const struct sockaddr_in addr, bool * received, const int file_size, const int parts)
{
  int counter = 0;
  for (int i = 0; i < parts; i++)
  {
    if (!received[i])
    {
      counter++;
      int offset = i * PART_SIZE;
      send_request(sockfd, addr, file_size, offset);
    }
  }
  return counter;
}
