#!/bin/bash

echo "Testing mean.out (serial)..."
/usr/bin/time -f "%e" ./mean.out million.bin 2>&1

echo "Testing threaded.out with 1 thread..."
/usr/bin/time -f "%e" ./threaded.out -f million.bin -t 1 2>&1

echo "Testing threaded.out with 2 threads..."
/usr/bin/time -f "%e" ./threaded.out -f million.bin -t 2 2>&1

echo "Testing threaded.out with 4 threads..."
/usr/bin/time -f "%e" ./threaded.out -f million.bin -t 4 2>&1

echo "Testing sdf.out with 1 thread..."
/usr/bin/time -f "%e" ./sdf.out -t 1 -n 1000000 2>&1

echo "Testing sdf.out with 2 threads..."
/usr/bin/time -f "%e" ./sdf.out -t 2 -n 1000000 2>&1

echo "Testing sdf.out with 4 threads..."
/usr/bin/time -f "%e" ./sdf.out -t 4 -n 1000000 2>&1
