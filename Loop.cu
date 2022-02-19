#include <stdio.h>

__global__
void doubleElements(int* List)
{
  int i;
  i = threadIdx.x;
  List[i]=1+i;
}


int main()
{
  int N = 5;
  int *List;

  size_t size = N * sizeof(int);

  cudaMallocManaged(&List, size);


  size_t threads_per_block = 5;

  doubleElements<<<1, threads_per_block>>>(List);
  cudaDeviceSynchronize();
  for (int i=0;i<N;i++) printf("%d \t",List[i]);

  cudaFree(List);
}