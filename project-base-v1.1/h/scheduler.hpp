//
// Created by marko on 20.4.22..
//

#ifndef OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_SCHEDULER_HPP
#define OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_SCHEDULER_HPP

#include "list.hpp"
#include "../lib/mem.h"

class _thread;

//treba da bude singleton

class Scheduler
{
private:
    static List<_thread> readyThreadQueue;
    //static List readyThreadQueue; //

public:
    static _thread *get();

    static void put(_thread *ccb);

};

#endif //OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_SCHEDULER_HPP
