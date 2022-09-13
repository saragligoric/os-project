#ifndef _syscall_c
#define _syscall_c

#include "../lib/hw.h"

void *mem_alloc(size_t size);
int mem_free(void*);

//-------------metode za niti zadate postavkom--------------

class _thread;
typedef _thread* thread_t;

//kreira i odmah i pokrece nit, sluzi za C api
int thread_create ( //0x11
        thread_t* handle,
        void(*start_routine)(void*),
        void* arg
);

int thread_exit (); //0x12

void thread_dispatch ();    //0x13

//-----------------dodatne metode za niti---------------------

//samo kreira nit i ne pokrece je, sluzi za C++ api
int thread_create_dont_start(
        thread_t *handle,
        void(*start_routine)(void*),
        void *arg
);

//pokrece nit nakon sto je ona kreirana, sluzi za C++ api
int thread_start(thread_t handle);

#endif //_syscall_c