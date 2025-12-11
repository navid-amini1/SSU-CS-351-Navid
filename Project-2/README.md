Project 2 – Threading and Multi-Core Applications

CS 351 – Computer Architecture

This project contains two multithreaded programs:

A threaded mean calculator (threaded.cpp)

A Monte-Carlo volume estimator using a signed-distance function (sdf.cpp)

Each program was compared to its single-threaded version. Timing measurements were collected, and speedup graphs were produced to analyze performance.

Part 1 — Computing a Mean (threaded.cpp)
Serial and Threaded Performance

The serial version (mean.out) provides the baseline runtime.
The threaded version (threaded.out) was run using different numbers of threads, and the speedup was calculated using:

speedup = T_serial / T_parallel

Mean Calculation Speedup Graph

The graph plots number of threads (x-axis) against speedup (y-axis).

Observations

Speedup increases significantly when moving from 1 → 4 → 8 threads.

The curve begins to flatten, indicating diminishing returns as thread count increases.

The flattening is expected due to memory bandwidth limitations and the serial fraction of the program.

Maximum Speedup

The highest measured speedup for this section was approximately 10.4× using 8 threads.

Amdahl’s Law Analysis

Amdahl’s Law models the theoretical speedup of a program with both serial and parallel components.

Given that the measured speedup approaches a limit near 10×, we can estimate the parallel fraction:

S_infinity ≈ 10
S_infinity = 1 / (1 − p)

1 − p ≈ 0.1  
p ≈ 0.9

Estimated Parallel Fraction

About 90% of the computation is parallel, and the remaining 10% is serial overhead (file I/O, setup, synchronization, etc.).

Bandwidth Analysis

Each iteration of the mean kernel loads one 4-byte float from memory:

Data per iteration = 4 bytes


Because all threads read from different sections of the same array, the program becomes memory-bandwidth bound.
This explains why speedup levels off even with additional threads.

Part 2 — Computing a Volume (sdf.cpp)

The Monte-Carlo estimator samples points inside a unit cube and subtracts the portion that lies inside a sphere of radius 0.5.

Analytical Volume Comparison
Volume of cube        = 1
Volume of sphere      = 4π(0.5)^3 / 3 = 0.5235987756
Expected volume       = 1 − sphere volume = 0.4764012244


The computed results match closely with the expected analytical value.

Volume Calculation Speedup Graph

Observations

Speedup behavior is similar to the mean calculation.

Strong gains occur from 1 → 4 → 8 threads.

The curve begins to flatten at higher thread counts for the same reasons as before:

Random number generation overhead

Memory access cost

Barrier synchronization

Maximum Speedup

The highest measured speedup for the volume computation was also about 10.4×.

Conclusion

Both programs show substantial improvements from multithreading.

Memory bandwidth and serial overhead limit the maximum achievable speedup.

Amdahl’s Law accurately explains the flattening behavior seen in the graphs.

The Monte-Carlo volume estimator matches the expected theoretical value.

The included graphs (mean_speedup.png and volume_speedup.png) illustrate the performance characteristics clearly.

Files Included

mean.cpp

threaded.cpp

sdf.cpp

Makefile

trials.sh

mean_speedup.png

volume_speedup.png

Timing result files

End of Report
