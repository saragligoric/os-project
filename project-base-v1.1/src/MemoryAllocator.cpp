//
// Created by os on 8/10/22.
//

#include "../h/MemoryAllocator.h"

Segment *MemoryAllocator::freeSegs = nullptr;
Segment *MemoryAllocator::takenSegs = nullptr;

void MemoryAllocator::init() {
    freeSegs = (Segment*)HEAP_START_ADDR;
    freeSegs->prev = freeSegs->next = nullptr;
    //mora da se alocira i prostor za header
    freeSegs->size = (size_t)((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR); //ovde bilo MEM_BLOCK_SIZE
    //takenSegs ostaje nullptr jer inicijalno nista nije zauzeto
}

//napisano je tako da mem_alloc dobija velicinu prostora u bajtovima (ali zaokruzeno na cele blokove)
void *MemoryAllocator::mem_alloc(size_t size) {
    //treba da dodas velicinu header-a (sizeof())
    size_t sizeToAllocate = size+sizeof(Segment);
    sizeToAllocate = (sizeToAllocate % MEM_BLOCK_SIZE == 0) ?
         sizeToAllocate :
         (sizeToAllocate / MEM_BLOCK_SIZE + 1) * MEM_BLOCK_SIZE;

    //trazis slobodan fragment dovoljne velicine iz kog ces da alociras prostor
    for(Segment* cur = freeSegs; cur; cur=cur->next){
        //prvi slucaj: ceo cur se alocira
        //izbaci ga iz liste slobodnih i prebaci u listu zauzetih
        if (cur->size-sizeToAllocate <=sizeof(Segment)){
            //no remaining fragment
            remove(&freeSegs, cur);
            insert(&takenSegs, cur);
            return (void*)((char*)(cur) + sizeof(Segment));
        }

        //drugi slucaj: alocira se deo cur
        //iznaci cur iz liste slobodnih. napravi dva nova segmenta, jedan ide u listu zauzetih, drugi u listu slobodnih
        else{
            remove(&freeSegs, cur);
            //napravis nov slobodan segment i ubacis u listu slobodnih
            Segment *newSeg = (Segment*)((char*)cur + sizeToAllocate);
            newSeg->size = (cur->size - sizeToAllocate);
            newSeg->next = newSeg->prev = nullptr;
            insert(&freeSegs, newSeg);
            //azuriras velicinu novog slobodnog segmenta (cur) i dodas ga u listu slobodnih
            cur->size = sizeToAllocate;
            insert(&takenSegs, cur);
            return (void*)((char*)(cur) + sizeof(Segment));
        }
    }

    //ne postoji segment dovoljne velicine
    return nullptr;
}

int MemoryAllocator::mem_free(void *ptr){
    if (!ptr) return -1;
    Segment *s = (Segment*)((char*)ptr - sizeof(Segment));
    //segment koji se izbacuje se izbaci iz liste zauzetih i stavi u listu slobodnih segmenata
    remove(&takenSegs, s);
    insert(&freeSegs, s);

    //pokusaj spajanja sa segmentima pre i posle izbacenog (segment s se sada nalazi u listi slobodnih segmenata

    //segment koji prethodi izbacenom
    Segment* previous = s->prev;
    tryToJoin(previous);
    tryToJoin(s);

    return 0;
}

//trebalo bi da izmenis ovu metodu tako da nema slicnosti
void MemoryAllocator::insert(Segment **head_ptr, Segment *node)
{
    // ako je node=NULL, odmah se vrati
    if (!node) return;

    // ako je head=NULL (odnosno ako nije bilo čvorova u listi do sad), head postaje node
    if (!(*head_ptr)) {
        *head_ptr = node;
        return;
    }

    // ako node treba da stoji ispred head-a, preveži ih i node postaje head
    Segment *head = *head_ptr;
    if (node < head) {
        node->next = head;
        head->prev = node;

        *head_ptr = node;
        return;
    }

    // ako node treba da stoji negde u sred liste:
    Segment *prev = head;
    for (Segment *curr = head->next; curr; curr = curr->next) {
        if (node < curr) {
            prev->next = node;
            node->prev = prev;

            curr->prev = node;
            node->next = curr;
            return;
        }
        prev = curr;
    }

    // ako node treba da stoji na kraju liste:
    prev->next = node;
    node->prev = prev;
}

//trebalo bi da izmenis ovu metodu tako da nema slicnosti
void MemoryAllocator::remove(Segment **head_ptr, Segment *node)
{
    if (!head_ptr || !node) // ako ne postoji lista u pitanju ili ako ne postoji node u pitanju
        return;

    Segment *head = *head_ptr;
    if (head == node) {     // ako je node koji se briše početni u listi, njegov sledbenik postaje početni
        *head_ptr = head->next;
        if (*head_ptr) {
            (*head_ptr)->prev = nullptr;
        }
        node->next = node->prev = nullptr;
        return;
    }



        Segment *prev = node->prev;
        Segment *next = node->next;

        // ako je na bilo kom drugom mestu u listi, samo preveži članove
        prev->next = next;  //ovde zabode
        if (next) {
            next->prev = prev;
        }

        // resetovanje pointera
        node->next = node->prev = nullptr;
}

//iz zbirke:
//try to join cur with the cur->next free segment
int MemoryAllocator::tryToJoin (Segment* cur){
    if (!cur) return 0;
    if (cur->next && (char*)cur+cur->size == (char*)(cur->next)){
        //ako je uslov ispunjen, ukloni cur->next segment (spoji ih)
        cur->size += cur->next->size;
        cur->next = cur->next->next;
        if (cur->next) cur->next->prev=cur;
        return 1;
    }else
        return 0;
}
