#include <stdio.h>

/*
// int main() {
void main() {
  __asm__ __volatile__("call real_main" ::);
  // return 0;
}
*/

// int real_main() {
int main() {
  printf("hello\n");
  return 0;
}
