#include <stdlib.h>

int main() {
  void *ptr = malloc(2);
  free(ptr);
  return 0;
}
