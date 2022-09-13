//
// Created by os on 8/10/22.
//

#ifndef PROJECT_BASE_V1_1_STRUCTURE_HPP
#define PROJECT_BASE_V1_1_STRUCTURE_HPP

#include "../lib/hw.h"

typedef struct Segment{
    size_t size;
    struct Segment *next, *prev;
} Segment;

#endif //PROJECT_BASE_V1_1_STRUCTURE_HPP
