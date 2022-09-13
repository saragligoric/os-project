#include "../lib/hw.h"
#include "../h/syscall_c.h"
#include "../h/abi_codes.h"

//proveri da li treba lepse da vracas value

//mem_alloc iz C API-a treba da zadatu vrednost u bajtovima zaokruži na cele blokove (tako da zahtevani prostor stane u te blokove)
//i izrazi u blokovima pre nego što izvrši sistemski poziv ABI-a.
void *mem_alloc(size_t size){
    //s se postavlja tako da izrazava velicinu prostora u blokovima
    size_t s = 0;
    if (size % MEM_BLOCK_SIZE == 0){
        s=size/MEM_BLOCK_SIZE;
    }else{
        s=size/MEM_BLOCK_SIZE + 1;
    }

    __asm__ volatile ("mv a1, %0"::"r"((uint64)s));
    __asm__ volatile ("mv a0, %0"::"r"(MEM_ALLOC));
    __asm__ volatile ("ecall");

    //ovde je stajalo da je volatile
    uint64 value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    return (void*)value;
}

int mem_free(void *ptr){
    __asm__ volatile ("mv a1, %0"::"r"(ptr));
    __asm__ volatile ("mv a0, %0"::"r"(MEM_FREE));
    __asm__ volatile ("ecall");

    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    return (int)value;
}

//-----------------metode za niti---------------------
//dodatne metode
int thread_create_dont_start(thread_t *handle, void (*start_routine)(void*), void *arg){
    if (!handle) return -1;
    if (!start_routine) return -2;
    //postavka kaze da C api treba da alocira stek i da ga salje u abi
    void* stack = mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    if (!stack) return -3;
    //ovde je bila helper funkcija, vidi mozes li bez nje:
    //return thread_create_helper(handle, start_routine, arg, stack);

    //ucitavanje argumenata i invoke
    __asm__ volatile ("mv a1, %0"::"r"(handle));
    __asm__ volatile ("mv a2, %0"::"r"(start_routine));
    __asm__ volatile ("mv a3, %0"::"r"(arg));
    __asm__ volatile ("mv a4, %0"::"r"(stack));
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_CREATE_DONT_START));
    __asm__ volatile ("ecall");

    //vracanje povratne vrednosti
    //ovde nije toliko bitno sta vraca
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    return (int) value;
}

int thread_start(thread_t handle){
    if (!handle) return -1;

    //pakovanje argumenata i invoke
    __asm__ volatile ("mv a1, %0"::"r"(handle));
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_START));
    __asm__ volatile ("ecall");

    //povratna vrednost
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    return (int)value;
}

//date postavkom
int thread_create(thread_t *handle, void (*start_routine)(void*), void *arg){
    //odmah i kreira i pokrece nit, za pozivanje iz C apija

    if (!handle) return -1;
    //ako se kao start_routine prosledin null, nit ti je main
    //postavka kaze da C api treba da alocira stek i da ga salje u abi
    void* stack = mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    if (!stack) return -3;


    //ucitavanje argumenata i invoke
    __asm__ volatile ("mv a1, %0"::"r"(handle));
    __asm__ volatile ("mv a2, %0"::"r"(start_routine));
    __asm__ volatile ("mv a3, %0"::"r"(arg));
    __asm__ volatile ("mv a4, %0"::"r"(stack));
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_CREATE));
    __asm__ volatile ("ecall");

    //vracanje povratne vrednosti
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    return (int)value;
}

int thread_exit(){
    //treba da napakuje argumente (koje nema) i uradi invoke
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_EXIT));
    __asm__ volatile ("ecall");
    //vracanje povratne vrednosti
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    return (int)value;
}

void thread_dispatch(){
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_DISPATCH));
    __asm__ volatile ("ecall");
    //povratna vrednost je void
}
