//
// Created by os on 8/24/22.
//

#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"

//void checkNullptr(void* p) {
//    static int x = 0;
//    if(p == nullptr) {
//        __putc('?');
//        __putc('0' + x);
//    }
//    x++;
//}
//
//void checkStatus(int status) {
//    static int y = 0;
//    if(status) {
//        __putc('0' + y);
//        __putc('?');
//    }
//    y++;
//}

//int main() {

    //MemoryAllocator:: init();

    //TEST 1
//    int n = 10;
//    char* niz = (char*)MemoryAllocator::mem_alloc(10*sizeof(char));
//    if(niz == nullptr) {
//        __putc('?');
//    }
//
//    for(int i = 0; i < n; i++) {
//        niz[i] = 'k';
//    }
//
//    for(int i = 0; i < n; i++) {
//        __putc(niz[i]);
//        __putc(' ');
//    }
//
//    int status = MemoryAllocator::mem_free(niz);
//    if(status != 0) {
//        __putc('?');
//    }
//
//    return 0;

    //TEST 2 - nisam koristila, trebalo bi da ga izmenim da bih mogla da istestiram
//    int velicinaZaglavlja = sizeof(Segment); // meni je ovoliko
//
//    const size_t maxMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
//    char* niz = (char*)MemoryAllocator::mem_alloc(maxMemorija); // celokupan prostor
//    if(niz == nullptr) {
//        __putc('?');
//    }
//
//    int n = 10;
//    char* niz2 = (char*)MemoryAllocator::mem_alloc(n*sizeof(char));
//    if(niz2 == nullptr) {
//        __putc('k');
//        __putc(' ');
//    }
//
//    int status = MemoryAllocator::mem_free(niz);
//    if(status) {
//        __putc('?');
//    }
//    niz2 = (char*)MemoryAllocator::mem_alloc(n*sizeof(char));
//    if(niz2 == nullptr) {
//        __putc('?');
//    }
//
//    return 0;

    //TEST 3
//    char *p = nullptr;
//    int status = MemoryAllocator::mem_free(p);
//    if(status) {
//        __putc('k');
//        __putc(' ');
//    }
//
//    return 0;

    //TEST 4
//    int velicinaZaglavlja = sizeof(Segment); // meni je ovoliko
//
//    int *p1 = (int*)MemoryAllocator::mem_alloc(15*sizeof(int)); // trebalo bi da predje jedan blok od 64
//    checkNullptr(p1);
//    int *p2 = (int*)MemoryAllocator::mem_alloc(30*sizeof(int));
//    checkNullptr(p2);
//
//    int *p3 = (int*)MemoryAllocator::mem_alloc(30*sizeof(int));
//    checkNullptr(p3);
//
//    checkStatus(MemoryAllocator::mem_free(p1));
//    checkStatus(MemoryAllocator::mem_free(p3));
//    checkStatus(MemoryAllocator::mem_free(p2)); // p2 treba da se spoji sa p1 i p3
//
//    const size_t maxMemorija = (((size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - velicinaZaglavlja)/MEM_BLOCK_SIZE - 1)*MEM_BLOCK_SIZE ;
//    int *celaMemorija = (int*)MemoryAllocator::mem_alloc(maxMemorija);
//    checkNullptr(celaMemorija);
//
//    checkStatus(MemoryAllocator::mem_free(celaMemorija));
//
//
//    return 0;

    //TEST 5
//    int n = 4;
//    char** matrix = (char**)MemoryAllocator::mem_alloc(n*sizeof(char*));
//    checkNullptr(matrix);
//    for(int i = 0; i < n; i++) {
//        matrix[i] = (char *) MemoryAllocator::mem_alloc(n * sizeof(char));
//        checkNullptr(matrix[i]);
//    }
//
//    for(int i = 0; i < n; i++) {
//        for(int j = 0; j < n; j++) {
//            matrix[i][j] = 'k';
//        }
//    }
//
//    for(int i = 0; i < n; i++) {
//        for(int j = 0; j < n; j++) {
//            __putc(matrix[i][j]);
//            __putc(' ');
//        }
//        __putc('\n');
//    }
//
//
//    for(int i = 0; i < n; i++) {
//        int status = MemoryAllocator::mem_free(matrix[i]);
//        checkStatus(status);
//    }
//    int status = MemoryAllocator::mem_free(matrix);
//    checkStatus(status);
//
//    return 0;
//}
