// Rafal Florczak 265304

#include "helpers.h"

void download_file(const int sockfd, const struct sockaddr_in addr, const char * file_name, const int file_size);

int main(int argc, char * argv[])
{
  if (argc != 4)
  {
    fprintf(stderr, "\nUsage: %s <port> <out file> <file size>\n", argv[0]);
    exit(1);
  }

  const int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
  error("Creatnig socket", sockfd);

  struct sockaddr_in address;
  address.sin_family = AF_INET;
  inet_pton(AF_INET, "156.17.4.30", &address.sin_addr);

  uint16_t port;
  int ret = sscanf(argv[1], "%hu", &port);
  if (ret == 1)
    address.sin_port = htons(port);
  else
    fail("Invalid port number!");

  if (!(strlen(argv[2]) > 0))
    fail("\nEmpty file name!");

  unsigned int file_size;
  ret = sscanf(argv[3], "%u", &file_size);
  if (ret != 1)
    fail("Invalid file size");

  download_file(sockfd, address, argv[2], file_size);
  return 0;
}

void download_file(const int sockfd, const struct sockaddr_in addr, const char * file_name, const int file_size)
{
  int parts = file_size / PART_SIZE;
  if (file_size % PART_SIZE > 0)
    parts++;

  char * buffer = malloc(PART_SIZE * parts);
  bool * received = malloc(sizeof(bool) * parts);
  memset(received, false, sizeof(bool) * parts);

  while (send_requests(sockfd, addr, received, file_size, parts))
  {
    receive_file(sockfd, addr, received, buffer);

    int count = 0;
    for (int i = 0; i < parts; i++)
      if (received[i])
	count++;

    printf("%4.2f%% done\n", count * 100.0 / parts);
  }

  FILE * f = fopen(file_name, "w");
  if (f != NULL)
  {
    error("Write to output file", fwrite(buffer, sizeof(char), file_size, f));
    fclose(f);
  }
  else
    fail("Couldn't write to output file");

  free(buffer);
  free(received);
}
