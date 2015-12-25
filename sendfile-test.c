#include <fcntl.h>
#include <sys/sendfile.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int
main (int ac, char *av[])
{
  int fd;
  off_t off = 0;

  fd = open ("/tmp/sendfile-test-tmp", O_RDWR | O_TRUNC | O_SYNC | O_CREAT, 0644);
  ftruncate (fd, 2);
  lseek (fd, 0, SEEK_END);
  sendfile (fd, fd, &off, 0xfffffff);
  return 0;
}
