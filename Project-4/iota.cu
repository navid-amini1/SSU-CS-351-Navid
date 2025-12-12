
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

#include <cuda_runtime.h>
#include <cstdlib>

using Count = size_t;
using DataType = long;

const DataType DefalutStartValue = -6;
const Count TestSize = 1'000'000'000;
const Count NumCheckValues = 500;

static inline void CudaCheck(cudaError_t e)
{
    if (e != cudaSuccess) {
        std::cerr << cudaGetErrorString(e) << "\n";
        std::exit(EXIT_FAILURE);
    }
}

__global__ void iota(Count n, DataType* values, DataType startValue)
{
    Count idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) values[idx] = startValue + static_cast<DataType>(idx);
}

int main(int argc, char* argv[])
{
    Count numValues = argc > 1 ? std::stol(argv[1]) : TestSize;
    size_t numBytes = numValues * sizeof(DataType);

    std::vector<DataType> values(numValues);

    DataType* gpuValues = nullptr;
    CudaCheck(cudaMalloc(&gpuValues, numBytes));

    DataType startValue = DefalutStartValue;

    int chunkSize = 256;
    int numChunks = int((double)numValues / chunkSize + 1);

    iota<<<numChunks, chunkSize>>>(numValues, gpuValues, startValue);
    CudaCheck(cudaGetLastError());
    CudaCheck(cudaDeviceSynchronize());

    CudaCheck(cudaMemcpy(values.data(), gpuValues, numBytes, cudaMemcpyDeviceToHost));

    Count step = numValues / NumCheckValues;
    for (Count i = 0, n = 0; i < numValues && n < NumCheckValues; ++n, i += step) {
        if (values[i] != startValue + static_cast<DataType>(i)) return EXIT_FAILURE;
    }

    cudaFree(gpuValues);
    return EXIT_SUCCESS;
}
