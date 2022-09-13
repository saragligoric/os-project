//
// Created by marko on 20.4.22..
//

#ifndef OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_LIST_HPP
#define OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_LIST_HPP

#include "../lib/mem.h"
#include "MemoryAllocator.h"

class _thread; //

template<typename T>
class List
{
private:
    struct Elem
    {
        T *data;
        //_thread *data;//
        Elem *next;

        Elem(T *data, Elem *next) : data(data), next(next) {}
        //Elem(_thread *data, Elem *next) : data(data), next(next) {} //

        //fedjica:
        void *operator new(size_t size) { return __mem_alloc(size); }
        void operator delete(void *ptr) { __mem_free(ptr); }

//Andrijana:
//        Elem(_thread *data){ //
//            this->data = data;
//            this->next = nullptr;
//        }
    };

    Elem *head, *tail;

public:

    List() : head(0), tail(0) {};   //???

//Andrijana:
//    List(const List &) = delete;
//
//    List &operator=(const List &) = delete;

    List(const List<T> &) = delete;

    List<T> &operator=(const List<T> &) = delete;

//    void addFirst(T *data)
//    {
//        Elem *elem = new Elem(data, head);
//        head = elem;
//        if (!tail) { tail = head; }
//    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
        if (tail)
        {
            tail->next = elem;
            tail = elem;
        } else
        {
            head = tail = elem;
        }
    }

    //prepravljeno - andrijana
//    void addLast(_thread *data){
//        //saljes velicinu u bajtovima ali zaokruzenu na cele blokove
//        size_t size = sizeof (Elem);
//        size = (size % MEM_BLOCK_SIZE == 0) ? size : (size / MEM_BLOCK_SIZE + 1) * MEM_BLOCK_SIZE;
//
//        size_t sizeToAllocate = size+sizeof(Segment);
//        sizeToAllocate = (sizeToAllocate % MEM_BLOCK_SIZE == 0) ?
//                         sizeToAllocate :
//                         (sizeToAllocate / MEM_BLOCK_SIZE + 1) * MEM_BLOCK_SIZE;
//        Elem  *elem = (Elem*) MemoryAllocator::mem_alloc(size);
//        elem->data = data;
//        elem->next = nullptr;
//        if (tail)
//        {
//            tail->next = elem;
//            tail = elem;
//        } else
//        {
//            head = tail = elem;
//        }
//    }

    //ostavljeno originalno - kod andrijane prepravljeno
    T *removeFirst()
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }

        T *ret = elem->data;
        delete elem;
        return ret;
    }

//    T *removeLast()
//    {
//        if (!head) { return 0; }
//
//        Elem *prev = 0;
//        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
//        {
//            prev = curr;
//        }
//
//        Elem *elem = tail;
//        if (prev) { prev->next = 0; }
//        else { head = 0; }
//        tail = prev;
//
//        T *ret = elem->data;
//        delete elem;
//        return ret;
//    }

//    T *peekFirst()
//    {
//        if (!head) { return 0; }
//        return head->data;
//    }
//
//    T *peekLast()
//    {
//        if (!tail) { return 0; }
//        return tail->data;
//    }
};

#endif //OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_LIST_HPP