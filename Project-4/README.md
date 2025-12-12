# Project 6 – CUDA Applications (Project-4 directory)

This project contains two CUDA applications:
1) A CUDA implementation of an `iota`-style fill (CPU vs GPU timing comparison)
2) A CUDA-accelerated Julia/Mandelbrot set generator that outputs a PPM image

---

## Files

### iota.cpp (CPU)
Baseline CPU implementation that fills an array with increasing values starting at `startValue`.

### iota.cu (GPU)
CUDA implementation where each GPU thread computes one element of the output array.

**Discussion:** CUDA is not a great solution for this problem because the work per element is extremely small, so kernel launch overhead and host↔device memory transfer overhead can dominate total runtime versus the CPU.

### julia.cpp (CPU)
CPU version that computes a Julia/Mandelbrot-style fractal per pixel and writes a `P6` PPM image.

### julia.cu (GPU)
CUDA version where each GPU thread computes the color of one pixel independently, which is well-suited to GPU parallelism.

---

## Generated Image

The CUDA Julia program generates:

![Julia/Mandelbrot output](julia.ppm)

