#include <stdio.h>
void init(int *List, int n)
{
    for (int i = 0; i < n; i++)
        List[i] = 0;
}
__global__ void Fibonacci(int *List,int* mutex)
{
    int i;
    i = threadIdx.x;
    if (i > 1) //Parrallel Programming getting results for parrallel summation
    {
        mutex(&lock);
        List[i] = List[i - 2] + List[i - 1];
        mutex(&unlock);
    }
}

int main()
{
    int N = 10;
    int *List;
    int *mutex; //all threads share on mutex.
    cudaMallocManaged((void **)&mutex, sizeof(int));
    *mutex = 0;

    size_t size = N * sizeof(int);

    cudaMallocManaged(&List, size);
    init(List, N);
    List[0] = 1;
    List[1] = 2;
    size_t threads_per_block = 10;

    Fibonacci<<<1, threads_per_block>>>(List);
    cudaDeviceSynchronize();
    for (int i = 0; i < N; i++)
        printf("%d \t", List[i]);

    cudaFree(List);
    cudaFree(mutex);
}