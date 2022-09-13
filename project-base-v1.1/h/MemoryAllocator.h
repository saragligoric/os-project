//
// Created by os on 8/10/22.
//

#ifndef PROJECT_BASE_V1_1_MEMORYALLOCATOR_H
#define PROJECT_BASE_V1_1_MEMORYALLOCATOR_H

#include "Structure.hpp"

//treba da bude singleton
class MemoryAllocator {
private:
    static Segment *freeSegs, *takenSegs;
public:
    static void *mem_alloc(size_t);
    static int mem_free(void*);

    static void init();
    static void insert(Segment **head_ptr, Segment *node);
    static void remove(Segment **head_ptr, Segment *node);
    static int tryToJoin (Segment* cur);
};


#endif //PROJECT_BASE_V1_1_MEMORYALLOCATOR_H
