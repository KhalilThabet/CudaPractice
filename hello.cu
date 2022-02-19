#include <stdio.h>

__global__
void doubleElements(char* word)
{
  int i;
  i = threadIdx.x;
  word[i]='H'+i;
}


int main()
{
  int N = 5;
  int *word;

  size_t size = N * sizeof(char);

  cudaMallocManaged(&word, size);


  size_t threads_per_block = 5;

  doubleElements<<<1, threads_per_block>>>(word);
  cudaDeviceSynchronize();

  cudaFree(word);
}