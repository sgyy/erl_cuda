#include <cuda_runtime.h>
#include <stdio.h>

__global__ void add( int *a, int *b, int *c ) {
*c = *a + *b;
}

int main( int argc, char *argv[] ) {

    size_t size = sizeof( int );

    int a, b , c;

    if(argc <= 1) {
       exit(1);
    }

    int arg1 = atoi(argv[1]);
    int arg2 = atoi(argv[2]);

    a = arg1;
    b = arg2;

    // Allocate the device input
    int *d_a = NULL;
    cudaMalloc((void **)&d_a, size);

    int *d_b = NULL;
    cudaMalloc((void **)&d_b, size);

    int *d_c = NULL;
    cudaMalloc((void **)&d_c, size);

    // copy host input to device input in device memory
    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

    // launch add CUDA Kernel
    add<<< 1, 1 >>>(d_a, d_b, d_c);

    // copy device result to host result in host memory
    cudaMemcpy( &c, d_c, size, cudaMemcpyDeviceToHost);

    printf("%d", c);

    //free device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    cudaDeviceReset();
    
    return 0;
}
