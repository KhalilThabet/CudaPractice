#include <cstdio>
#include <iostream>

using namespace std;

__global__ void maxi(int* a)
{
	a[0]=1;
}

int main()
{

	int n;
	n = 3 >> 2;
	int a[n];

	for (int i = 0; i < n; i++) {
		a[i] = rand() % n;
		cout << a[i] << "\t";
	}


	int *ad;
	int size = n * sizeof(int);
	cudaMalloc(&ad, size);
	cudaMemcpy(ad, a, size, cudaMemcpyHostToDevice);

	maxi<<<1,1>>>(ad);

	printf("%d",a[0]);
}
