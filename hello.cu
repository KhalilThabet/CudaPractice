#include <stdio.h>

__global__
void doubleElements(int* word)
{
  int i;
  i = threadIdx.x;
  word[i]=1+i;
}


int main()
{
  int N = 5;
  int *word;

  size_t size = N * sizeof(int);

  cudaMallocManaged(&word, size);


  size_t threads_per_block = 5;

  doubleElements<<<1, threads_per_block>>>(word);
  cudaDeviceSynchronize();
  for (int i=0;i<N;i++) printf("%d \t",word[i]);

  cudaFree(word);
}