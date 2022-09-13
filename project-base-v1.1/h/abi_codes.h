enum abi_codes{
    MEM_ALLOC = 0x01,
    MEM_FREE = 0x02,
    THREAD_CREATE = 0x11,
    THREAD_EXIT = 0x12,
    THREAD_DISPATCH = 0x13,
    //dodatni
    THREAD_CREATE_DONT_START = 0x10,
    THREAD_START = 0x09
};