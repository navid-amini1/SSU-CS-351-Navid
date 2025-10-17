# CS 351 Project #3
## Remote GitHub Development and Performance Monitoring 
### Test done on blue server 

## Setup 
- All tests were done on the blue server
- All programs had same hash 483775828799384508

  ## Analysis Questions

  ### Performance 
  **Which program is fastest? Is it always the fastest?**

  I observed : ** With Default Build (-g optimization):**
- **Fastest**: `malloc.out` (0.057s real time)
- **Second**: `alloca.out` (0.069s real time) 
- **Third**: `new.out` (0.188s real time)
- **Slowest**: `list.out` (0.201s real time)

  **When Compiler Optimizations was enabled (-O2):**
  - **Fastest**: `malloc.out` (0.031s real time)
  - **Second**: `list.out` and `new.out` (sane 0.039s real time)
- **`alloca.out`**: Crashed with segmentation fault


**Conclusion**: Malloc was much faster at all times. Alloc crashes with optomized build

### 2. Performance Trend

**Was there a trend in program execution time based on the size of data in each Node? If so, what, and why?**

When testing with larger size data 1000 Bytes at Min `alloca.out` crashed with segmentation fault. Other program showed increased ecxecution time for obvoius reasons. More data longer execution time.

**Trend**: When we increased the data size, execution time for all programs increased becuse the actual hasing function has to process more data in the linked list node. Performance ramined consistent for all programs. There was no drastic increase when whe increased the data size for each node.

**Was there a trend in program execution time based on the length of the block chain?**
Programs with longer nodes ( chains ) their execution time increased in a linear fashion for all the programs.


### 3. Memory Analysis

**Consider heap breaks, what's noticeable? Does increasing the stack size affect the heap? Speculate on any similarities and differences in programs?**

From `make breaks` command the  output are the following :
alloca.out: 1
list.out: 1
malloc.out: 1
new.out: 1

With all programs showing 1 heap break there was little heap expansion indicating that allocation was very efficent and effective when requesting memory from the Operatin System 

**Does increasing the stack size affect the heap? Speculate on any similarities and differences in programs?**
increasing the stack size  affects alloca.cpp only because it uses stack allocation.
alloca uses stack memory so when we increase the stack size it is affected
malloc , new use heap memory so increasing the stack size has no affect on it.

## Considering either the malloc.cpp or alloca.cpp versions of the program, generate a diagram showing two Nodes. Include in the diagram
the relationship of the head, tail, and Node next pointers.

## Node Relationships:
- HEAD → Node 1
- Node 1 → Node 2  
- Node 2 → NULL
- Tail → Node 2

  In a typical linked list, we will have the head node pointing the first node. The tail will point to the last node. This is known as singly linked list with tail feature impelmentation. Useful if we need to access the last element fast without having to go thorugh the entire linked list.

  ## Node structure
  A node in a typical imeplmentation can have varies size. It will definitely have a pointer to the next node,and some data. Data can be complex including other objects.
We can summarize : 
next` pointer: 8 bytes
- `numBytes`: 4 bytes  
- `bytes` pointer: 8 bytes
- `data[6]`: 6 bytes
**Total**: 20 bytes for Node header + 6 bytes data = 26 bytes

  ## overhead
  Allocating memory was different for all programs ( tasks )
  list.cpp it uses std :: list the object itself will manage memory internally. It provides an intereface so we don't think about it.
  new.cpp uses the new operator to allocate memory to each node
  malloc.cpp uses c style malloc() function for memory allocation
  alloca.cpp utializes stack no heap invovled.
  
 ## Data initialization 
 same for all programs we use std::iota(bytes, bytes + numBytes, 1)
 same sequentional pattern
 ## hashing
 Hasing algorithm is the same for all programs. Same loop same calulation, etc.

 # As the size of data in a Node increases, does the significance of allocating the node increase or decrease?
 The signifiance of allocating memory to the node decreses. The reason for this is because when the data is small allocating memory is the larger task. When teh data is large then allocating memory is the smalelr task. 
 
  
