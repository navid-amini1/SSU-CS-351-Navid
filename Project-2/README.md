# Project 2 – Threading and Multi-Core Applications  
**CS 351 – Computer Architecture**

This project implements two multithreaded programs:

1. A threaded mean calculator (`threaded.cpp`)  
2. A Monte-Carlo volume estimator using a signed-distance function (`sdf.cpp`)

Both programs were compared to their serial baselines, and speedup graphs were produced.

---

# 📌 Part 1 — Computing a Mean (`threaded.cpp`)

## ✔ Serial and Threaded Performance

The serial version (`mean.out`) provides the baseline time.  
The threaded version (`threaded.out`) was run with multiple thread counts.

**Speedup definition:**

\[
\text{speedup} = \frac{T_{serial}}{T_{parallel}}
\]

---

# 📈 Mean Calculation Speedup Graph

![Mean Speedup](mean_speedup.png)

This graph plots **number of threads (X-axis)** vs **speedup (Y-axis)**.

### ✔ Observations

- Speedup increases significantly from **1 → 4 → 8 threads**.
- The curve begins to **flatten**, showing diminishing returns.
- This is expected because the program becomes **memory-bandwidth limited**.

### ✔ Maximum Speedup

The highest measured speedup is approximately **10.4×** at 8 threads.

---

# 🧮 Amdahl’s Law Analysis

Amdahl’s Law:

\[
S(n) = \frac{1}{(1 - p) + \frac{p}{n}}
\]

The observed maximum speedup approaches **10×**.

We solve for the parallel fraction \( p \):

\[
S_\infty = \frac{1}{1 - p}
\]
\[
10 = \frac{1}{1 - p}
\]
\[
1 - p = 0.1
\]
\[
p = 0.9
\]

### ✔ Estimated Parallel Fraction

\[
p \approx 0.90
\]

This means:

- **90%** of the work is parallelizable.  
- **10%** is serial overhead (file loading, loop overhead, memory stalls, barrier synchronization).

---

# 💾 Bandwidth Analysis

Each iteration reads **one 4-byte float**:

\[
\text{Data per iteration} = 4 \text{ bytes}
\]

Because all threads read from the same large array (different sections), performance becomes **memory-bandwidth bound**, not compute-bound.

This explains why speedup stops increasing at higher thread counts.

---

# 📌 Part 2 — Computing a Volume (`sdf.cpp`)

The program uses **Monte-Carlo integration** inside the unit cube and removes points inside a sphere of radius 0.5.

## ✔ Analytical Volume for Comparison

\[
V_{\text{cube}} = 1
\]

\[
V_{\text{sphere}} = \frac{4\pi(0.5)^3}{3} = 0.5235987756
\]

\[
V = 1 - V_{\text{sphere}} = 0.4764012244
\]

The program’s computed volume closely matches this theoretical value.

---

# 📈 Volume Calculation Speedup Graph

![Volume Speedup](volume_speedup.png)

### ✔ Observations

- Speedup shows strong improvement from **1 → 4 → 8 threads**.
- The curve begins flattening for the same reasons as Part 1:
  - Random number generator overhead  
  - Memory effects  
  - Barrier synchronization  

### ✔ Maximum Speedup

The highest observed speedup is approximately **10.4×**, similar to the mean calculation.

---

# 📌 Conclusion

- Both programs show **significant performance gains** from threading.  
- **Memory bandwidth** and **serial overhead** limit maximum speedup.  
- Amdahl’s Law accurately predicts the shape of the speedup curve.  
- The Monte-Carlo estimator matches the analytical volume.  
- Speedup graphs (`mean_speedup.png`, `volume_speedup.png`) are included for analysis.

---

# ✔ Files Included

- `mean.cpp`  
- `threaded.cpp`  
- `sdf.cpp`  
- `Makefile`  
- `trials.sh`  
- `mean_speedup.png`  
- `volume_speedup.png`  
- Timing result files  

---

# ✅ End of Report
