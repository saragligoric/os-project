//
// Created by marko on 20.4.22..
//

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"


_thread *_thread::running = nullptr;
_thread *_thread::main = nullptr;

//uint64 TCB::timeSliceCounter = 0;

//_thread *_thread::createThread(Body body)
//{
//    return new TCB(body, //TIME_SLICE);
//}

_thread *_thread::createThread(Body body, void* arg, uint64* stack)
{
    return new _thread(body, arg, stack);
}


//ovo je dodatno
_thread *_thread::createThreadSecondApi(Body body, void* arg, uint64* stack){
    //fedjica - initThread
    //return new _thread(body, arg, stack);

    //Andrijana
    //velicina koju saljes alokatoru treba da bude u bajtovima, ali zaokruzena na cele blokove
    //proveri da li si lepo prosledila velicinu
    size_t wantedSize = (sizeof(_thread)+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    _thread* t = (_thread*)MemoryAllocator::mem_alloc(wantedSize*MEM_BLOCK_SIZE);

    t->setBody(body);
    //t->body =body;
    t->setArg(arg);
    //t->arg=arg;
    t->setStack(stack);
    //t->stack=stack;
    t->setFinished(false);
    //t->finished=false;
    t->setFlag(false);
    //t->flag = false;

    if (body!=nullptr){
        t->context={(uint64) &threadWrapper,(uint64) &(t->stack[STACK_SIZE])};  //STACK_SIZE ili DEFAULT_STACK_SIZE?
    }else{
        t->context={0,0};
    }

    return t;

}


int _thread::start(){
    if (this!=main){
        Scheduler::put(this);
    }
    return 0;
}

//void _thread::yield()
//{
//    __asm__ volatile ("ecall");
//}

void _thread::yield()
{
    dispatch();
}

//void _thread::dispatch()
//{
//    _thread *old = running;
//    if (!old->isFinished()) { Scheduler::put(old); }
//    running = Scheduler::get();
//
//    _thread::contextSwitch(&old->context, &running->context);
//}

void _thread::dispatch()
{
    _thread *old = running;
    if (!old->isFinished() && !old->flag) { Scheduler::put(old); }
    running = Scheduler::get();
    //running = Scheduler::get();

    if (running == nullptr){
        running = main;
    }

    if (running == main){
        running->setFinished(true);
    }else{
        //ne vidim sto je ovo potrebno
        //Riscv::ms_sstatus(Riscv::SSTATUS_SIE);
    }

    contextSwitch(&old->context, &running->context);
}

//void _thread::threadWrapper()
//{
//    Riscv::popSppSpie();
//    running->body();

//    running->setFinished(true);
//    _thread::yield();
//}

void _thread::threadWrapper(){
    Riscv::popSppSpie();
    running->body(running->arg);
    //iz njegovog gornjeg wrappera sledi da bi exit trebalo da setuje finished status i da uradi dispatch
    thread_exit();
}

int _thread::exit(){
    running->setFinished(true);
    yield();
    return 0;
}






