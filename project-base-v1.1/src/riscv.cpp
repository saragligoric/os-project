//
// Created by marko on 20.4.22..
//

#include "../h/riscv.hpp"
#include "../lib/console.h"
#include "../h/print.hpp"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.h"
#include "../h/abi_codes.h"
#include "../h/_thread.hpp"

//ovo nzm kako tacno treba da izgleda (Andrijana ima dodatno jos jednu liniju koda izmedju)
void Riscv::popSppSpie()
{
    __asm__ volatile("csrw sepc, ra");
    //ms_sstatus(SSTATUS_SPP); //???
    ms_sstatus(SSTATUS_SPIE);
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap()
{
    using Body = void (*)(void*);
    //uzimanje prosledjenih argumenata iz registara da se ne bi izmenili
    uint64 args[5];
    __asm__ volatile ("mv %0, a0" : "=r" (args[0]));
    __asm__ volatile ("mv %0, a1" : "=r" (args[1]));
    __asm__ volatile ("mv %0, a2" : "=r" (args[2]));
    __asm__ volatile ("mv %0, a3" : "=r" (args[3]));
    __asm__ volatile ("mv %0, a4" : "=r" (args[4]));

    uint64 scause = r_scause();
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)   //ECALL_USER || ECALL_SUPER
    {
        // interrupt: no; cause code: environment call from U-mode(8) or S-mode(9)
        uint64 volatile sepc = r_sepc() + 4;
        uint64 volatile sstatus = r_sstatus();

//        TCB::timeSliceCounter = 0;
//        ovo je meni u THREAD_DISPATCH jer je njemu jedini tip prekida to bio
//        TCB::dispatch();

        //obrada samog prekida:
        //mozda vracanje value moze da ti izazove problem
        switch(args[0]){
            uint64 value;
            thread_t* handle;
            Body body;
            void* arg;
            uint64 *stack;

            //dodatno
            thread_t handle2;
            case MEM_ALLOC:
                //velicina size je prosledjena da izrazava velicinu prostora u blokovima
                //size koji se prosledi u mem_alloc iz Memory Allocator-a se pretvori da iskazuje velicinu u bajtovima
                value = (uint64)MemoryAllocator::mem_alloc(args[1]*MEM_BLOCK_SIZE);
                //__asm__ volatile ("mv a0, %0"::"r"(value)); //
                __asm__ volatile ("sd a0, 10*8(fp)");
                //mem_alloc vraca void* a to je mesto u memoriji gde je alociran prostor
                break;
            case MEM_FREE:
                value = (uint64)MemoryAllocator::mem_free((void*)args[1]);
                __asm__ volatile ("mv a0, %0"::"r"(value));
                break;
                //donji case provereno radi, nemoj menjati
            case THREAD_CREATE:
                //thread_t* handle;
                handle = (thread_t*)args[1];
                //Body body;
                body=(Body)args[2];
                //void* arg;
                arg = (void*)args[3];
                //uint64 *stack;
                stack = (uint64*)args[4];

                *handle = _thread::createThread(body, arg, stack);

                //startovanje niti i povratna vrednost
                value = (uint64)((*handle)->start());
                __asm__ volatile ("mv a0, %0"::"r"(value));
                break;
            case THREAD_CREATE_DONT_START:
                //thread_t* handle;
                handle = (thread_t*)args[1];
                //Body body;
                body=(Body)args[2];
                //void* arg;
                arg = (void*)args[3];
                //uint64 *stack;
                stack = (uint64*)args[4];



                //ovo zakomentarisano
                //*handle = _thread::createThread(body, arg, stack);
                *handle = _thread::createThreadSecondApi(body, arg,stack); //ovo je dodato
                //dovde se lepo izvrsi


                //povratna vrednost
                if (*handle == nullptr){
                    value = -1;
                }else{
                    value = 0;
                }
                __asm__ volatile ("mv a0, %0"::"r"(value));
                break;
            case THREAD_START:
                  //fedjica
//                thread_t handle = (thread_t)args[1];
//                retval = handle->start();

                //prepravljeno po uzoru na fedjicu
                handle2 = (thread_t)args[1];
                value = (uint64)(handle2->start());
                __asm__ volatile ("mv a0, %0"::"r"(value));

                //moje originalno
//                handle = (thread_t*)args[1];
//                value = (uint64)((*handle)->start());
//                __asm__ volatile ("mv a0, %0"::"r"(value));

                break;
            case THREAD_EXIT:
                value = (uint64)_thread::exit();
                __asm__ volatile ("mv a0, %0"::"r"(value));
                break;
            case THREAD_DISPATCH:
                _thread::dispatch();
                //nema povratne vrednosti jer dispatch nema povratnu vrednost
                break;
        }

        w_sstatus(sstatus);
        w_sepc(sepc);
    }
    else if (scause == 0x8000000000000001UL)    //software
    {
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
        mc_sip(SIP_SSIP);
//        TCB::timeSliceCounter++;
//        if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
//        {
//            uint64 volatile sepc = r_sepc();
//            uint64 volatile sstatus = r_sstatus();
//            TCB::timeSliceCounter = 0;
//            TCB::dispatch();
//            w_sstatus(sstatus);
//            w_sepc(sepc);
//        }
    }
    else if (scause == 0x8000000000000009UL) //hardware
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    }
    else
    {
        // unexpected trap cause

        //obrada neplaniranog ulaska u prekidnu rutinu
        uint64 scause = r_scause();
        uint64 stval = r_stval();
        uint64 stvec = r_stvec();
        uint64 sepc = r_sepc();

        printString("\n Scause: ");
        printInt(scause);

        printString("\n Stval: ");
        printInt(stval);

        printString("\n Stvec: ");
        printInt(stvec);

        printString("\n Sepc: ");
        printInt(sepc);
    }
}