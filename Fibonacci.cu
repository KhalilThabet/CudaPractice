#include <stdio.h>

__global__ void Fibonacci(int *List)
{
    int i;
    i = threadIdx.x;
    if (i > 1)
        List[i] = List[i - 1] + List[i - 2];
}

int main()
{
    int N = 10;
    int *List;

    size_t size = N * sizeof(int);

    cudaMallocManaged(&List, size);
    List[0] = 1;
    List[1] = 1;
    size_t threads_per_block = 10;

    Fibonacci<<<1, threads_per_block>>>(List);
    cudaDeviceSynchronize();
    for (int i = 0; i < N; i++)
        printf("%d \t", List[i]);

    cudaFree(List);
}