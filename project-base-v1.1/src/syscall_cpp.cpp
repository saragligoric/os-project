#include "../lib/hw.h"
#include "../h/syscall_c.h"
#include "../h/syscall_cpp.h"

void *operator new(size_t n)
{
    return mem_alloc(n);
}

void *operator new[](size_t n)
{
    return mem_alloc(n);
}

void operator delete(void *p)
{
    mem_free(p);
}

void operator delete[](void *p)
{
    mem_free(p);
}


//class Thread
Thread::Thread(void (*body)(void*), void *arg){
    thread_create_dont_start(&myHandle, body, arg);
    //mislim da je ovo nepotrebno al neka ga za svaki slucaj, mislim da ne moze da skodi
    //this->myHandle = myHandle;
}

Thread::Thread(){
    thread_create_dont_start(&myHandle, Thread::wrapper, this);
    //mislim da je ovo nepotrebno al neka ga za svaki slucaj, mislim da ne moze da skodi
    //this->myHandle = myHandle;
}

Thread::~Thread(){
    //nisam sigurna sta tacno ovo treba da pozove
    mem_free((void*)myHandle);
}

int Thread::start(){
    return thread_start(myHandle);
}

void Thread::dispatch(){
    thread_dispatch();
}

int Thread::sleep(time_t time){
    return 0;
    //...
}

void Thread::wrapper(void *thr){
    ((Thread*)thr)->run();
}

