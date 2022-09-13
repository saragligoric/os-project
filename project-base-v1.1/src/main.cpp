//
// Created by os on 8/31/22.
//

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.h"
#include "../h/_thread.hpp"
#include "../h/syscall_c.h"
#include "../h/print.hpp"
#include "../lib/mem.h"

extern void userMain();

void user_wrapper(void*){
    userMain();
    _thread::running->setFinished(true);
    _thread::yield();
}

void main(){
    MemoryAllocator::init();
//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
//    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    //pravljenje main i user main niti
    _thread *threads[2];

    //thread_create(&threads[0], nullptr, nullptr);
    threads[0] = _thread::createThread(nullptr, nullptr, nullptr);
    _thread::main = _thread::running = threads[0];
    _thread::running->setFlag(true);
    printString("Main thread created\n");

    //void* stack = mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    void* stack = __mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    //thread_create(&threads[1], user_wrapper, nullptr);
    threads[1] = _thread::createThread(&user_wrapper, nullptr, (uint64*)stack);
    printString("User main thread created\n");

//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
//    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    //stavlja userMain u scheduler
    threads[1]->start();

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    while(!threads[1]->isFinished()){
        //_thread::yield();
        thread_dispatch();
    }
    printString("User main thread finished\n");

    Riscv::mc_sstatus(Riscv::SSTATUS_SIE);

//    for (auto &thread: threads){
//        delete thread;
//    }

    //ovde nesto baguje
    //delete threads[1];
    delete threads[0];
}

//
// Created by marko on 20.4.22..
//

//#include "../h/tcb.hpp"
//#include "../h/workers.hpp"
//#include "../h/print.hpp"
//#include "../h/riscv.hpp"
//
//int main()
//{
//    TCB *threads[5];
//
//    threads[0] = TCB::createThread(nullptr);
//    TCB::running = threads[0];
//
//    threads[1] = TCB::createThread(workerBodyA);
//    printString("ThreadA created\n");
//    threads[2] = TCB::createThread(workerBodyB);
//    printString("ThreadB created\n");
//    threads[3] = TCB::createThread(workerBodyC);
//    printString("ThreadC created\n");
//    threads[4] = TCB::createThread(workerBodyD);
//    printString("ThreadD created\n");
//
//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
//    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);
//
//    while (!(threads[1]->isFinished() &&
//             threads[2]->isFinished() &&
//             threads[3]->isFinished() &&
//             threads[4]->isFinished()))
//    {
//        TCB::yield();
//    }
//
//    for (auto &thread: threads)
//    {
//        delete thread;
//    }
//    printString("Finished\n");
//
//    return 0;
//}