//
// Created by marko on 20.4.22..
//

#ifndef OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_TCB_HPP
#define OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_TCB_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"
#include "../lib/mem.h"

//Thread Control Block
class _thread
{


public:
//nzm dal je ovo pametno da bude u thread klasi
void *operator new(size_t n)
{
    return __mem_alloc(n);
}

void *operator new[](size_t n)
{
    return __mem_alloc(n);
}

void operator delete(void *p)
{
__mem_free(p);
}

void operator delete[](void *p)
{
__mem_free(p);
}


    using Body = void (*)(void*);

    ~_thread() { delete[] stack; }

    bool isFinished() const { return finished; }
    void setFinished(bool value) { finished = value; }
    bool isFlag() const {return flag;}
    void setFlag(bool flag) {this->flag = flag;}

    //dodatno - nzm dal je sve ovo potrebno
    Body getBody() const {return body;}
    void setBody(Body body) {this->body = body;}
    void* getArg() const {return arg;}
    void setArg(void *arg) {this->arg = arg;}
    uint64* getStack() const {return stack;}
    void setStack(uint64 *stack) {this->stack = stack;}

    //uint64 getTimeSlice() const { return timeSlice; }

    //on je slao samo body; ja dobijam body, arg i stack
    //static _thread *createThread(Body body);

    //ovo je dodatno
    static _thread* createThreadSecondApi(Body, void*, uint64*);


    //poziva konstruktor klase _thread
    //koristi se u THREAD_CREATE i u THREAD_CREATE_DONT_START
    static _thread *createThread(Body, void*, uint64*);
    //pokrece nit
    //koristi se u THREAD_START i u THREAD_CREATE
    int start();
    //gasi tekucu nit
    //koristi se u THREAD_EXIT
    static int exit();

    //samo poziva dispatch
    static void yield();

    static _thread *running;
    static _thread *main;

private:
    friend class Riscv;

//    _thread(Body body, uint64 timeSlice) :
//            body(body),
//            stack(body != nullptr ? new uint64[STACK_SIZE] : nullptr),

//            on na vezbama i za main niti stavlja da je ra = &threadWrapper
//            context({(uint64) &threadWrapper,
//                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
//                    }),

//            //timeSlice(timeSlice)
//            finished(false)
//    {
//        if (body != nullptr) { Scheduler::put(this); }
//    }

    _thread(Body body, void* arg, uint64* stack) :
            body(body),
            arg(arg),
            stack(stack),
            finished(false),
            flag(false)
    {
        if (body!=nullptr){
            context={(uint64) &threadWrapper,(uint64)&stack[STACK_SIZE]};  //STACK_SIZE ili DEFAULT_STACK_SIZE?
        }else{
            context={0,0};
        }
    }

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };

    Body body;
    void *arg;
    uint64 *stack;
    Context context;
    //uint64 timeSlice;
    bool finished;
    bool flag;


    static void threadWrapper();
    static void dispatch();
    static void contextSwitch(Context *oldContext, Context *runningContext);

    //static uint64 timeSliceCounter;
    //static uint64 constexpr TIME_SLICE = 2;
    static uint64 constexpr STACK_SIZE = 1024;
};

#endif //OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_TCB_HPP
