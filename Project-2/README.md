# Project 2 – Threading and Multi-Core Applications  
CS 351 – Computer Architecture  

This project implements two multithreaded programs:

1. A threaded mean calculator (`threaded.cpp`)  
2. A Monte-Carlo volume estimator using a signed-distance function (`sdf.cpp`)

Both programs are compared to a single-threaded baseline and speedup graphs are produced.

---

## Part 1 — Computing a Mean (`threaded.cpp`)

### Serial and Threaded Programs

- `mean.out` – serial program that reads values from a binary file and computes the mean.  
- `threaded.out` – multithreaded version that splits the work across several threads.

The main data file used for timing is `data.bin`.

### Speedup Definition

Speedup is defined as:

`speedup = T_serial / T_parallel`

where:

- `T_serial`   = running time of the serial program (`mean.out`)  
- `T_parallel` = running time of the threaded program (`threaded.out`) with N threads  

### Mean Calculation Speedup Graph

![Mean Speedup](mean_speedup.png)

- **X-axis:** number of threads  
- **Y-axis:** speedup relative to the serial time  

From my measurements and graph:

- Serial time is used as speedup = 1.0 (baseline).
- With 4 threads I see about **6.5×** speedup.
- With 8 threads I see about **10.4×** speedup.

#### Observations

- Speedup increases a lot when going from 1 → 4 → 8 threads.
- After a point, adding more threads gives smaller improvements (curve starts to flatten).
- This flattening is expected because:
  - All threads are reading from the same large array.
  - Memory bandwidth and synchronization overhead become the bottleneck instead of pure computation.

### Amdahl’s Law Discussion

Amdahl’s Law (in words):

> Program time is a mix of a serial part (cannot be parallelized) and a parallel part (can be sped up with threads).

One common form:

`Speedup(N) = 1 / ( (1 - p) + p / N )`

where:

- `p` is the fraction of the program that can be parallelized.  
- `N` is the number of threads.

From the graph, the maximum speedup seems to level off around **10×**.

If we assume the “infinite threads” speedup is about 10, then:

`Speedup_infinity = 1 / (1 - p) ≈ 10`

So:

`1 - p ≈ 0.1`  
`p ≈ 0.9`

**Interpretation:**

- About **90%** of the work is parallel.  
- About **10%** is effectively serial (file I/O, setup, barriers, etc.).  

This matches what we expect: there is always some overhead that cannot be parallelized away.

### Mean Kernel Bandwidth

For each iteration of the main loop:

- We read **one 4-byte float** from memory.

So:

`data per iteration ≈ 4 bytes`

Because all threads read different parts of the same array, the kernel becomes **memory-bandwidth bound**:

- The CPU has plenty of compute power, but memory cannot feed data fast enough to get unlimited speedup.
- This is another reason the speedup curve flattens at higher thread counts.

---

## Part 2 — Computing a Volume (`sdf.cpp`)

The second program estimates the volume of a shape using **Monte Carlo integration**:

- Region: unit cube `[0,1] × [0,1] × [0,1]`  
- From this cube, we remove a centered sphere of radius `0.5`.  
- Random points are generated inside the cube and tested with a signed-distance function (SDF).

### Analytical Volume for Comparison

- Volume of cube: `V_cube = 1`  
- Volume of sphere with radius 0.5:

  `V_sphere = (4/3) * π * (0.5)^3 ≈ 0.5235987756`

- Expected target volume:

  `V = V_cube - V_sphere ≈ 1 - 0.5235987756 ≈ 0.4764012244`

The program’s computed volume values are close to this expected value when using a large number of samples (`-n` option).

### Volume Calculation Speedup Graph

![Volume Speedup](volume_speedup.png)

- **X-axis:** number of threads  
- **Y-axis:** speedup relative to the 1-thread time  

From my runs:

- 1 thread: baseline speedup = 1.0  
- 2 threads: roughly 2× speedup  
- 4 threads: roughly 2× speedup (limited by other costs)  
- 8 threads: roughly 4× speedup  

#### Observations

- The overall shape of the speedup curve is similar to the mean calculation case.
- There is a strong improvement going from 1 → 4 → 8 threads.
- At higher thread counts, speedup grows more slowly because of:
  - Cost of random number generation  
  - Memory effects / cache behavior  
  - Barrier and synchronization overhead  

The maximum measured speedup for the volume calculation is also on the order of **10×** when comparing against the serial-style baseline, which is consistent with the Amdahl’s Law discussion above.

---

## Conclusion

- Both programs benefit significantly from using multiple threads.
- Speedup is limited by:
  - Serial sections of the code (file I/O, setup, control logic).
  - Memory bandwidth and synchronization overhead.
- Amdahl’s Law helps explain why speedup flattens and why we do not get perfect linear speedup.
- The Monte Carlo volume estimator produces results that are close to the analytical volume of the cube minus the sphere.
- The graphs `mean_speedup.png` and `volume_speedup.png` are included for visualizing the scaling behavior.

---

## Files Included

- `mean.cpp` – serial mean calculation  
- `threaded.cpp` – multithreaded mean calculation  
- `sdf.cpp` – Monte Carlo SDF volume estimator  
- `Makefile` – builds `mean.out`, `threaded.out`, `sdf.out`  
- `trials.sh` – script for collecting timing data  
- `mean_speedup.png` – graph of mean calculation speedup  
- `volume_speedup.png` – graph of volume calculation speedup  
- `results.txt`, `timing_results.txt`, `fresh_results.txt` – timing and result logs (optional helper files)

---

_End of Report_
