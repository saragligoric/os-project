
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	0a013103          	ld	sp,160(sp) # 800060a0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	359020ef          	jal	ra,80002b74 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	2e8010ef          	jal	ra,8000238c <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256

    8000112c:	10200073          	sret

0000000080001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <_Z9mem_allocm>:

//proveri da li treba lepse da vracas value

//mem_alloc iz C API-a treba da zadatu vrednost u bajtovima zaokruži na cele blokove (tako da zahtevani prostor stane u te blokove)
//i izrazi u blokovima pre nego što izvrši sistemski poziv ABI-a.
void *mem_alloc(size_t size){
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00813423          	sd	s0,8(sp)
    8000114c:	01010413          	addi	s0,sp,16
    //s se postavlja tako da izrazava velicinu prostora u blokovima
    size_t s = 0;
    if (size % MEM_BLOCK_SIZE == 0){
    80001150:	03f57793          	andi	a5,a0,63
    80001154:	02079463          	bnez	a5,8000117c <_Z9mem_allocm+0x38>
        s=size/MEM_BLOCK_SIZE;
    80001158:	00655513          	srli	a0,a0,0x6
    }else{
        s=size/MEM_BLOCK_SIZE + 1;
    }

    __asm__ volatile ("mv a1, %0"::"r"((uint64)s));
    8000115c:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0"::"r"(MEM_ALLOC));
    80001160:	00100793          	li	a5,1
    80001164:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001168:	00000073          	ecall

    //ovde je stajalo da je volatile
    uint64 value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    8000116c:	00050513          	mv	a0,a0
    return (void*)value;
}
    80001170:	00813403          	ld	s0,8(sp)
    80001174:	01010113          	addi	sp,sp,16
    80001178:	00008067          	ret
        s=size/MEM_BLOCK_SIZE + 1;
    8000117c:	00655513          	srli	a0,a0,0x6
    80001180:	00150513          	addi	a0,a0,1
    80001184:	fd9ff06f          	j	8000115c <_Z9mem_allocm+0x18>

0000000080001188 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001188:	fe010113          	addi	sp,sp,-32
    8000118c:	00813c23          	sd	s0,24(sp)
    80001190:	02010413          	addi	s0,sp,32
    __asm__ volatile ("mv a1, %0"::"r"(ptr));
    80001194:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0"::"r"(MEM_FREE));
    80001198:	00200793          	li	a5,2
    8000119c:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800011a0:	00000073          	ecall

    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    800011a4:	00050793          	mv	a5,a0
    800011a8:	fef43423          	sd	a5,-24(s0)
    return (int)value;
    800011ac:	fe843503          	ld	a0,-24(s0)
}
    800011b0:	0005051b          	sext.w	a0,a0
    800011b4:	01813403          	ld	s0,24(sp)
    800011b8:	02010113          	addi	sp,sp,32
    800011bc:	00008067          	ret

00000000800011c0 <_Z24thread_create_dont_startPP7_threadPFvPvES2_>:

//-----------------metode za niti---------------------
//dodatne metode
int thread_create_dont_start(thread_t *handle, void (*start_routine)(void*), void *arg){
    if (!handle) return -1;
    800011c0:	08050463          	beqz	a0,80001248 <_Z24thread_create_dont_startPP7_threadPFvPvES2_+0x88>
int thread_create_dont_start(thread_t *handle, void (*start_routine)(void*), void *arg){
    800011c4:	fc010113          	addi	sp,sp,-64
    800011c8:	02113c23          	sd	ra,56(sp)
    800011cc:	02813823          	sd	s0,48(sp)
    800011d0:	02913423          	sd	s1,40(sp)
    800011d4:	03213023          	sd	s2,32(sp)
    800011d8:	01313c23          	sd	s3,24(sp)
    800011dc:	04010413          	addi	s0,sp,64
    800011e0:	00050493          	mv	s1,a0
    800011e4:	00058913          	mv	s2,a1
    800011e8:	00060993          	mv	s3,a2
    if (!start_routine) return -2;
    800011ec:	06058263          	beqz	a1,80001250 <_Z24thread_create_dont_startPP7_threadPFvPvES2_+0x90>
    //postavka kaze da C api treba da alocira stek i da ga salje u abi
    void* stack = mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    800011f0:	00008537          	lui	a0,0x8
    800011f4:	00000097          	auipc	ra,0x0
    800011f8:	f50080e7          	jalr	-176(ra) # 80001144 <_Z9mem_allocm>
    if (!stack) return -3;
    800011fc:	04050e63          	beqz	a0,80001258 <_Z24thread_create_dont_startPP7_threadPFvPvES2_+0x98>
    //ovde je bila helper funkcija, vidi mozes li bez nje:
    //return thread_create_helper(handle, start_routine, arg, stack);

    //ucitavanje argumenata i invoke
    __asm__ volatile ("mv a1, %0"::"r"(handle));
    80001200:	00048593          	mv	a1,s1
    __asm__ volatile ("mv a2, %0"::"r"(start_routine));
    80001204:	00090613          	mv	a2,s2
    __asm__ volatile ("mv a3, %0"::"r"(arg));
    80001208:	00098693          	mv	a3,s3
    __asm__ volatile ("mv a4, %0"::"r"(stack));
    8000120c:	00050713          	mv	a4,a0
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_CREATE_DONT_START));
    80001210:	01000793          	li	a5,16
    80001214:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001218:	00000073          	ecall

    //vracanje povratne vrednosti
    //ovde nije toliko bitno sta vraca
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    8000121c:	00050793          	mv	a5,a0
    80001220:	fcf43423          	sd	a5,-56(s0)
    return (int) value;
    80001224:	fc843503          	ld	a0,-56(s0)
    80001228:	0005051b          	sext.w	a0,a0
}
    8000122c:	03813083          	ld	ra,56(sp)
    80001230:	03013403          	ld	s0,48(sp)
    80001234:	02813483          	ld	s1,40(sp)
    80001238:	02013903          	ld	s2,32(sp)
    8000123c:	01813983          	ld	s3,24(sp)
    80001240:	04010113          	addi	sp,sp,64
    80001244:	00008067          	ret
    if (!handle) return -1;
    80001248:	fff00513          	li	a0,-1
}
    8000124c:	00008067          	ret
    if (!start_routine) return -2;
    80001250:	ffe00513          	li	a0,-2
    80001254:	fd9ff06f          	j	8000122c <_Z24thread_create_dont_startPP7_threadPFvPvES2_+0x6c>
    if (!stack) return -3;
    80001258:	ffd00513          	li	a0,-3
    8000125c:	fd1ff06f          	j	8000122c <_Z24thread_create_dont_startPP7_threadPFvPvES2_+0x6c>

0000000080001260 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    if (!handle) return -1;
    80001260:	02050e63          	beqz	a0,8000129c <_Z12thread_startP7_thread+0x3c>
int thread_start(thread_t handle){
    80001264:	fe010113          	addi	sp,sp,-32
    80001268:	00813c23          	sd	s0,24(sp)
    8000126c:	02010413          	addi	s0,sp,32

    //pakovanje argumenata i invoke
    __asm__ volatile ("mv a1, %0"::"r"(handle));
    80001270:	00050593          	mv	a1,a0
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_START));
    80001274:	00900793          	li	a5,9
    80001278:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000127c:	00000073          	ecall

    //povratna vrednost
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    80001280:	00050793          	mv	a5,a0
    80001284:	fef43423          	sd	a5,-24(s0)
    return (int)value;
    80001288:	fe843503          	ld	a0,-24(s0)
    8000128c:	0005051b          	sext.w	a0,a0
}
    80001290:	01813403          	ld	s0,24(sp)
    80001294:	02010113          	addi	sp,sp,32
    80001298:	00008067          	ret
    if (!handle) return -1;
    8000129c:	fff00513          	li	a0,-1
}
    800012a0:	00008067          	ret

00000000800012a4 <_Z13thread_createPP7_threadPFvPvES2_>:

//date postavkom
int thread_create(thread_t *handle, void (*start_routine)(void*), void *arg){
    //odmah i kreira i pokrece nit, za pozivanje iz C apija

    if (!handle) return -1;
    800012a4:	08050263          	beqz	a0,80001328 <_Z13thread_createPP7_threadPFvPvES2_+0x84>
int thread_create(thread_t *handle, void (*start_routine)(void*), void *arg){
    800012a8:	fc010113          	addi	sp,sp,-64
    800012ac:	02113c23          	sd	ra,56(sp)
    800012b0:	02813823          	sd	s0,48(sp)
    800012b4:	02913423          	sd	s1,40(sp)
    800012b8:	03213023          	sd	s2,32(sp)
    800012bc:	01313c23          	sd	s3,24(sp)
    800012c0:	04010413          	addi	s0,sp,64
    800012c4:	00050493          	mv	s1,a0
    800012c8:	00058993          	mv	s3,a1
    800012cc:	00060913          	mv	s2,a2
    //ako se kao start_routine prosledin null, nit ti je main
    //postavka kaze da C api treba da alocira stek i da ga salje u abi
    void* stack = mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    800012d0:	00008537          	lui	a0,0x8
    800012d4:	00000097          	auipc	ra,0x0
    800012d8:	e70080e7          	jalr	-400(ra) # 80001144 <_Z9mem_allocm>
    if (!stack) return -3;
    800012dc:	04050a63          	beqz	a0,80001330 <_Z13thread_createPP7_threadPFvPvES2_+0x8c>


    //ucitavanje argumenata i invoke
    __asm__ volatile ("mv a1, %0"::"r"(handle));
    800012e0:	00048593          	mv	a1,s1
    __asm__ volatile ("mv a2, %0"::"r"(start_routine));
    800012e4:	00098613          	mv	a2,s3
    __asm__ volatile ("mv a3, %0"::"r"(arg));
    800012e8:	00090693          	mv	a3,s2
    __asm__ volatile ("mv a4, %0"::"r"(stack));
    800012ec:	00050713          	mv	a4,a0
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_CREATE));
    800012f0:	01100793          	li	a5,17
    800012f4:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    800012f8:	00000073          	ecall

    //vracanje povratne vrednosti
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    800012fc:	00050793          	mv	a5,a0
    80001300:	fcf43423          	sd	a5,-56(s0)
    return (int)value;
    80001304:	fc843503          	ld	a0,-56(s0)
    80001308:	0005051b          	sext.w	a0,a0
}
    8000130c:	03813083          	ld	ra,56(sp)
    80001310:	03013403          	ld	s0,48(sp)
    80001314:	02813483          	ld	s1,40(sp)
    80001318:	02013903          	ld	s2,32(sp)
    8000131c:	01813983          	ld	s3,24(sp)
    80001320:	04010113          	addi	sp,sp,64
    80001324:	00008067          	ret
    if (!handle) return -1;
    80001328:	fff00513          	li	a0,-1
}
    8000132c:	00008067          	ret
    if (!stack) return -3;
    80001330:	ffd00513          	li	a0,-3
    80001334:	fd9ff06f          	j	8000130c <_Z13thread_createPP7_threadPFvPvES2_+0x68>

0000000080001338 <_Z11thread_exitv>:

int thread_exit(){
    80001338:	fe010113          	addi	sp,sp,-32
    8000133c:	00813c23          	sd	s0,24(sp)
    80001340:	02010413          	addi	s0,sp,32
    //treba da napakuje argumente (koje nema) i uradi invoke
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_EXIT));
    80001344:	01200793          	li	a5,18
    80001348:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    8000134c:	00000073          	ecall
    //vracanje povratne vrednosti
    uint64 volatile value;
    __asm__ volatile("mv %0, a0" : "=r" (value));
    80001350:	00050793          	mv	a5,a0
    80001354:	fef43423          	sd	a5,-24(s0)
    return (int)value;
    80001358:	fe843503          	ld	a0,-24(s0)
}
    8000135c:	0005051b          	sext.w	a0,a0
    80001360:	01813403          	ld	s0,24(sp)
    80001364:	02010113          	addi	sp,sp,32
    80001368:	00008067          	ret

000000008000136c <_Z15thread_dispatchv>:

void thread_dispatch(){
    8000136c:	ff010113          	addi	sp,sp,-16
    80001370:	00813423          	sd	s0,8(sp)
    80001374:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a0, %0"::"r"(THREAD_DISPATCH));
    80001378:	01300793          	li	a5,19
    8000137c:	00078513          	mv	a0,a5
    __asm__ volatile ("ecall");
    80001380:	00000073          	ecall
    //povratna vrednost je void
}
    80001384:	00813403          	ld	s0,8(sp)
    80001388:	01010113          	addi	sp,sp,16
    8000138c:	00008067          	ret

0000000080001390 <_ZN7_thread13threadWrapperEv>:

//    running->setFinished(true);
//    _thread::yield();
//}

void _thread::threadWrapper(){
    80001390:	ff010113          	addi	sp,sp,-16
    80001394:	00113423          	sd	ra,8(sp)
    80001398:	00813023          	sd	s0,0(sp)
    8000139c:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    800013a0:	00001097          	auipc	ra,0x1
    800013a4:	fc4080e7          	jalr	-60(ra) # 80002364 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    800013a8:	00005797          	auipc	a5,0x5
    800013ac:	d587b783          	ld	a5,-680(a5) # 80006100 <_ZN7_thread7runningE>
    800013b0:	0007b703          	ld	a4,0(a5)
    800013b4:	0087b503          	ld	a0,8(a5)
    800013b8:	000700e7          	jalr	a4
    //iz njegovog gornjeg wrappera sledi da bi exit trebalo da setuje finished status i da uradi dispatch
    thread_exit();
    800013bc:	00000097          	auipc	ra,0x0
    800013c0:	f7c080e7          	jalr	-132(ra) # 80001338 <_Z11thread_exitv>
}
    800013c4:	00813083          	ld	ra,8(sp)
    800013c8:	00013403          	ld	s0,0(sp)
    800013cc:	01010113          	addi	sp,sp,16
    800013d0:	00008067          	ret

00000000800013d4 <_ZN7_thread12createThreadEPFvPvES0_Pm>:
{
    800013d4:	fd010113          	addi	sp,sp,-48
    800013d8:	02113423          	sd	ra,40(sp)
    800013dc:	02813023          	sd	s0,32(sp)
    800013e0:	00913c23          	sd	s1,24(sp)
    800013e4:	01213823          	sd	s2,16(sp)
    800013e8:	01313423          	sd	s3,8(sp)
    800013ec:	03010413          	addi	s0,sp,48
    800013f0:	00050913          	mv	s2,a0
    800013f4:	00058993          	mv	s3,a1
    800013f8:	00060493          	mv	s1,a2

public:
//nzm dal je ovo pametno da bude u thread klasi
void *operator new(size_t n)
{
    return __mem_alloc(n);
    800013fc:	03000513          	li	a0,48
    80001400:	00004097          	auipc	ra,0x4
    80001404:	a28080e7          	jalr	-1496(ra) # 80004e28 <__mem_alloc>
    _thread(Body body, void* arg, uint64* stack) :
            body(body),
            arg(arg),
            stack(stack),
            finished(false),
            flag(false)
    80001408:	01253023          	sd	s2,0(a0) # 8000 <_entry-0x7fff8000>
    8000140c:	01353423          	sd	s3,8(a0)
    80001410:	00953823          	sd	s1,16(a0)
    80001414:	02050423          	sb	zero,40(a0)
    80001418:	020504a3          	sb	zero,41(a0)
    {
        if (body!=nullptr){
    8000141c:	02090c63          	beqz	s2,80001454 <_ZN7_thread12createThreadEPFvPvES0_Pm+0x80>
            context={(uint64) &threadWrapper,(uint64)&stack[STACK_SIZE]};  //STACK_SIZE ili DEFAULT_STACK_SIZE?
    80001420:	00002637          	lui	a2,0x2
    80001424:	00c484b3          	add	s1,s1,a2
    80001428:	00000797          	auipc	a5,0x0
    8000142c:	f6878793          	addi	a5,a5,-152 # 80001390 <_ZN7_thread13threadWrapperEv>
    80001430:	00f53c23          	sd	a5,24(a0)
    80001434:	02953023          	sd	s1,32(a0)
}
    80001438:	02813083          	ld	ra,40(sp)
    8000143c:	02013403          	ld	s0,32(sp)
    80001440:	01813483          	ld	s1,24(sp)
    80001444:	01013903          	ld	s2,16(sp)
    80001448:	00813983          	ld	s3,8(sp)
    8000144c:	03010113          	addi	sp,sp,48
    80001450:	00008067          	ret
        }else{
            context={0,0};
    80001454:	00053c23          	sd	zero,24(a0)
    80001458:	02053023          	sd	zero,32(a0)
    return new _thread(body, arg, stack);
    8000145c:	fddff06f          	j	80001438 <_ZN7_thread12createThreadEPFvPvES0_Pm+0x64>

0000000080001460 <_ZN7_thread21createThreadSecondApiEPFvPvES0_Pm>:
_thread *_thread::createThreadSecondApi(Body body, void* arg, uint64* stack){
    80001460:	fd010113          	addi	sp,sp,-48
    80001464:	02113423          	sd	ra,40(sp)
    80001468:	02813023          	sd	s0,32(sp)
    8000146c:	00913c23          	sd	s1,24(sp)
    80001470:	01213823          	sd	s2,16(sp)
    80001474:	01313423          	sd	s3,8(sp)
    80001478:	03010413          	addi	s0,sp,48
    8000147c:	00050913          	mv	s2,a0
    80001480:	00058993          	mv	s3,a1
    80001484:	00060493          	mv	s1,a2
    _thread* t = (_thread*)MemoryAllocator::mem_alloc(wantedSize*MEM_BLOCK_SIZE);
    80001488:	04000513          	li	a0,64
    8000148c:	00001097          	auipc	ra,0x1
    80001490:	3d4080e7          	jalr	980(ra) # 80002860 <_ZN15MemoryAllocator9mem_allocEm>
    void setBody(Body body) {this->body = body;}
    80001494:	01253023          	sd	s2,0(a0)
    void setArg(void *arg) {this->arg = arg;}
    80001498:	01353423          	sd	s3,8(a0)
    void setStack(uint64 *stack) {this->stack = stack;}
    8000149c:	00953823          	sd	s1,16(a0)
    void setFinished(bool value) { finished = value; }
    800014a0:	02050423          	sb	zero,40(a0)
    void setFlag(bool flag) {this->flag = flag;}
    800014a4:	020504a3          	sb	zero,41(a0)
    if (body!=nullptr){
    800014a8:	02090c63          	beqz	s2,800014e0 <_ZN7_thread21createThreadSecondApiEPFvPvES0_Pm+0x80>
        t->context={(uint64) &threadWrapper,(uint64) &(t->stack[STACK_SIZE])};  //STACK_SIZE ili DEFAULT_STACK_SIZE?
    800014ac:	00002637          	lui	a2,0x2
    800014b0:	00c484b3          	add	s1,s1,a2
    800014b4:	00000797          	auipc	a5,0x0
    800014b8:	edc78793          	addi	a5,a5,-292 # 80001390 <_ZN7_thread13threadWrapperEv>
    800014bc:	00f53c23          	sd	a5,24(a0)
    800014c0:	02953023          	sd	s1,32(a0)
}
    800014c4:	02813083          	ld	ra,40(sp)
    800014c8:	02013403          	ld	s0,32(sp)
    800014cc:	01813483          	ld	s1,24(sp)
    800014d0:	01013903          	ld	s2,16(sp)
    800014d4:	00813983          	ld	s3,8(sp)
    800014d8:	03010113          	addi	sp,sp,48
    800014dc:	00008067          	ret
        t->context={0,0};
    800014e0:	00053c23          	sd	zero,24(a0)
    800014e4:	02053023          	sd	zero,32(a0)
    return t;
    800014e8:	fddff06f          	j	800014c4 <_ZN7_thread21createThreadSecondApiEPFvPvES0_Pm+0x64>

00000000800014ec <_ZN7_thread5startEv>:
    if (this!=main){
    800014ec:	00005797          	auipc	a5,0x5
    800014f0:	c1c7b783          	ld	a5,-996(a5) # 80006108 <_ZN7_thread4mainE>
    800014f4:	02a78863          	beq	a5,a0,80001524 <_ZN7_thread5startEv+0x38>
int _thread::start(){
    800014f8:	ff010113          	addi	sp,sp,-16
    800014fc:	00113423          	sd	ra,8(sp)
    80001500:	00813023          	sd	s0,0(sp)
    80001504:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    80001508:	00001097          	auipc	ra,0x1
    8000150c:	19c080e7          	jalr	412(ra) # 800026a4 <_ZN9Scheduler3putEP7_thread>
}
    80001510:	00000513          	li	a0,0
    80001514:	00813083          	ld	ra,8(sp)
    80001518:	00013403          	ld	s0,0(sp)
    8000151c:	01010113          	addi	sp,sp,16
    80001520:	00008067          	ret
    80001524:	00000513          	li	a0,0
    80001528:	00008067          	ret

000000008000152c <_ZN7_thread8dispatchEv>:
{
    8000152c:	fe010113          	addi	sp,sp,-32
    80001530:	00113c23          	sd	ra,24(sp)
    80001534:	00813823          	sd	s0,16(sp)
    80001538:	00913423          	sd	s1,8(sp)
    8000153c:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001540:	00005497          	auipc	s1,0x5
    80001544:	bc04b483          	ld	s1,-1088(s1) # 80006100 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001548:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->flag) { Scheduler::put(old); }
    8000154c:	00079663          	bnez	a5,80001558 <_ZN7_thread8dispatchEv+0x2c>
    80001550:	0294c783          	lbu	a5,41(s1)
    80001554:	04078863          	beqz	a5,800015a4 <_ZN7_thread8dispatchEv+0x78>
    running = Scheduler::get();
    80001558:	00001097          	auipc	ra,0x1
    8000155c:	0e4080e7          	jalr	228(ra) # 8000263c <_ZN9Scheduler3getEv>
    80001560:	00005797          	auipc	a5,0x5
    80001564:	baa7b023          	sd	a0,-1120(a5) # 80006100 <_ZN7_thread7runningE>
    if (running == nullptr){
    80001568:	04050663          	beqz	a0,800015b4 <_ZN7_thread8dispatchEv+0x88>
    if (running == main){
    8000156c:	00005797          	auipc	a5,0x5
    80001570:	b9478793          	addi	a5,a5,-1132 # 80006100 <_ZN7_thread7runningE>
    80001574:	0007b583          	ld	a1,0(a5)
    80001578:	0087b783          	ld	a5,8(a5)
    8000157c:	04f58663          	beq	a1,a5,800015c8 <_ZN7_thread8dispatchEv+0x9c>
    contextSwitch(&old->context, &running->context);
    80001580:	01858593          	addi	a1,a1,24
    80001584:	01848513          	addi	a0,s1,24
    80001588:	00000097          	auipc	ra,0x0
    8000158c:	ba8080e7          	jalr	-1112(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001590:	01813083          	ld	ra,24(sp)
    80001594:	01013403          	ld	s0,16(sp)
    80001598:	00813483          	ld	s1,8(sp)
    8000159c:	02010113          	addi	sp,sp,32
    800015a0:	00008067          	ret
    if (!old->isFinished() && !old->flag) { Scheduler::put(old); }
    800015a4:	00048513          	mv	a0,s1
    800015a8:	00001097          	auipc	ra,0x1
    800015ac:	0fc080e7          	jalr	252(ra) # 800026a4 <_ZN9Scheduler3putEP7_thread>
    800015b0:	fa9ff06f          	j	80001558 <_ZN7_thread8dispatchEv+0x2c>
        running = main;
    800015b4:	00005797          	auipc	a5,0x5
    800015b8:	b4c78793          	addi	a5,a5,-1204 # 80006100 <_ZN7_thread7runningE>
    800015bc:	0087b703          	ld	a4,8(a5)
    800015c0:	00e7b023          	sd	a4,0(a5)
    800015c4:	fa9ff06f          	j	8000156c <_ZN7_thread8dispatchEv+0x40>
    void setFinished(bool value) { finished = value; }
    800015c8:	00100793          	li	a5,1
    800015cc:	02f58423          	sb	a5,40(a1)
    800015d0:	fb1ff06f          	j	80001580 <_ZN7_thread8dispatchEv+0x54>

00000000800015d4 <_ZN7_thread5yieldEv>:
{
    800015d4:	ff010113          	addi	sp,sp,-16
    800015d8:	00113423          	sd	ra,8(sp)
    800015dc:	00813023          	sd	s0,0(sp)
    800015e0:	01010413          	addi	s0,sp,16
    dispatch();
    800015e4:	00000097          	auipc	ra,0x0
    800015e8:	f48080e7          	jalr	-184(ra) # 8000152c <_ZN7_thread8dispatchEv>
}
    800015ec:	00813083          	ld	ra,8(sp)
    800015f0:	00013403          	ld	s0,0(sp)
    800015f4:	01010113          	addi	sp,sp,16
    800015f8:	00008067          	ret

00000000800015fc <_ZN7_thread4exitEv>:

int _thread::exit(){
    800015fc:	ff010113          	addi	sp,sp,-16
    80001600:	00113423          	sd	ra,8(sp)
    80001604:	00813023          	sd	s0,0(sp)
    80001608:	01010413          	addi	s0,sp,16
    8000160c:	00005797          	auipc	a5,0x5
    80001610:	af47b783          	ld	a5,-1292(a5) # 80006100 <_ZN7_thread7runningE>
    80001614:	00100713          	li	a4,1
    80001618:	02e78423          	sb	a4,40(a5)
    running->setFinished(true);
    yield();
    8000161c:	00000097          	auipc	ra,0x0
    80001620:	fb8080e7          	jalr	-72(ra) # 800015d4 <_ZN7_thread5yieldEv>
    return 0;
}
    80001624:	00000513          	li	a0,0
    80001628:	00813083          	ld	ra,8(sp)
    8000162c:	00013403          	ld	s0,0(sp)
    80001630:	01010113          	addi	sp,sp,16
    80001634:	00008067          	ret

0000000080001638 <_Z9fibonaccim>:
bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    80001638:	fe010113          	addi	sp,sp,-32
    8000163c:	00113c23          	sd	ra,24(sp)
    80001640:	00813823          	sd	s0,16(sp)
    80001644:	00913423          	sd	s1,8(sp)
    80001648:	01213023          	sd	s2,0(sp)
    8000164c:	02010413          	addi	s0,sp,32
    80001650:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001654:	00100793          	li	a5,1
    80001658:	02a7f863          	bgeu	a5,a0,80001688 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000165c:	00a00793          	li	a5,10
    80001660:	02f577b3          	remu	a5,a0,a5
    80001664:	02078e63          	beqz	a5,800016a0 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001668:	fff48513          	addi	a0,s1,-1
    8000166c:	00000097          	auipc	ra,0x0
    80001670:	fcc080e7          	jalr	-52(ra) # 80001638 <_Z9fibonaccim>
    80001674:	00050913          	mv	s2,a0
    80001678:	ffe48513          	addi	a0,s1,-2
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	fbc080e7          	jalr	-68(ra) # 80001638 <_Z9fibonaccim>
    80001684:	00a90533          	add	a0,s2,a0
}
    80001688:	01813083          	ld	ra,24(sp)
    8000168c:	01013403          	ld	s0,16(sp)
    80001690:	00813483          	ld	s1,8(sp)
    80001694:	00013903          	ld	s2,0(sp)
    80001698:	02010113          	addi	sp,sp,32
    8000169c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800016a0:	00000097          	auipc	ra,0x0
    800016a4:	ccc080e7          	jalr	-820(ra) # 8000136c <_Z15thread_dispatchv>
    800016a8:	fc1ff06f          	j	80001668 <_Z9fibonaccim+0x30>

00000000800016ac <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800016ac:	fe010113          	addi	sp,sp,-32
    800016b0:	00113c23          	sd	ra,24(sp)
    800016b4:	00813823          	sd	s0,16(sp)
    800016b8:	00913423          	sd	s1,8(sp)
    800016bc:	01213023          	sd	s2,0(sp)
    800016c0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800016c4:	00000913          	li	s2,0
    800016c8:	0380006f          	j	80001700 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800016cc:	00000097          	auipc	ra,0x0
    800016d0:	ca0080e7          	jalr	-864(ra) # 8000136c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800016d4:	00148493          	addi	s1,s1,1
    800016d8:	000027b7          	lui	a5,0x2
    800016dc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800016e0:	0097ee63          	bltu	a5,s1,800016fc <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800016e4:	00000713          	li	a4,0
    800016e8:	000077b7          	lui	a5,0x7
    800016ec:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800016f0:	fce7eee3          	bltu	a5,a4,800016cc <_ZN7WorkerA11workerBodyAEPv+0x20>
    800016f4:	00170713          	addi	a4,a4,1
    800016f8:	ff1ff06f          	j	800016e8 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800016fc:	00190913          	addi	s2,s2,1
    80001700:	00900793          	li	a5,9
    80001704:	0327ec63          	bltu	a5,s2,8000173c <_ZN7WorkerA11workerBodyAEPv+0x90>
        printString("A: i="); printInt(i); printString("\n");
    80001708:	00004517          	auipc	a0,0x4
    8000170c:	91850513          	addi	a0,a0,-1768 # 80005020 <CONSOLE_STATUS+0x10>
    80001710:	00001097          	auipc	ra,0x1
    80001714:	338080e7          	jalr	824(ra) # 80002a48 <_Z11printStringPKc>
    80001718:	00090513          	mv	a0,s2
    8000171c:	00001097          	auipc	ra,0x1
    80001720:	39c080e7          	jalr	924(ra) # 80002ab8 <_Z8printIntm>
    80001724:	00004517          	auipc	a0,0x4
    80001728:	a2450513          	addi	a0,a0,-1500 # 80005148 <CONSOLE_STATUS+0x138>
    8000172c:	00001097          	auipc	ra,0x1
    80001730:	31c080e7          	jalr	796(ra) # 80002a48 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001734:	00000493          	li	s1,0
    80001738:	fa1ff06f          	j	800016d8 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000173c:	00004517          	auipc	a0,0x4
    80001740:	8ec50513          	addi	a0,a0,-1812 # 80005028 <CONSOLE_STATUS+0x18>
    80001744:	00001097          	auipc	ra,0x1
    80001748:	304080e7          	jalr	772(ra) # 80002a48 <_Z11printStringPKc>
    finishedA = true;
    8000174c:	00100793          	li	a5,1
    80001750:	00005717          	auipc	a4,0x5
    80001754:	9cf70023          	sb	a5,-1600(a4) # 80006110 <finishedA>
}
    80001758:	01813083          	ld	ra,24(sp)
    8000175c:	01013403          	ld	s0,16(sp)
    80001760:	00813483          	ld	s1,8(sp)
    80001764:	00013903          	ld	s2,0(sp)
    80001768:	02010113          	addi	sp,sp,32
    8000176c:	00008067          	ret

0000000080001770 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001770:	fe010113          	addi	sp,sp,-32
    80001774:	00113c23          	sd	ra,24(sp)
    80001778:	00813823          	sd	s0,16(sp)
    8000177c:	00913423          	sd	s1,8(sp)
    80001780:	01213023          	sd	s2,0(sp)
    80001784:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001788:	00000913          	li	s2,0
    8000178c:	0380006f          	j	800017c4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001790:	00000097          	auipc	ra,0x0
    80001794:	bdc080e7          	jalr	-1060(ra) # 8000136c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001798:	00148493          	addi	s1,s1,1
    8000179c:	000027b7          	lui	a5,0x2
    800017a0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800017a4:	0097ee63          	bltu	a5,s1,800017c0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800017a8:	00000713          	li	a4,0
    800017ac:	000077b7          	lui	a5,0x7
    800017b0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800017b4:	fce7eee3          	bltu	a5,a4,80001790 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800017b8:	00170713          	addi	a4,a4,1
    800017bc:	ff1ff06f          	j	800017ac <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800017c0:	00190913          	addi	s2,s2,1
    800017c4:	00f00793          	li	a5,15
    800017c8:	0327ec63          	bltu	a5,s2,80001800 <_ZN7WorkerB11workerBodyBEPv+0x90>
        printString("B: i="); printInt(i); printString("\n");
    800017cc:	00004517          	auipc	a0,0x4
    800017d0:	86c50513          	addi	a0,a0,-1940 # 80005038 <CONSOLE_STATUS+0x28>
    800017d4:	00001097          	auipc	ra,0x1
    800017d8:	274080e7          	jalr	628(ra) # 80002a48 <_Z11printStringPKc>
    800017dc:	00090513          	mv	a0,s2
    800017e0:	00001097          	auipc	ra,0x1
    800017e4:	2d8080e7          	jalr	728(ra) # 80002ab8 <_Z8printIntm>
    800017e8:	00004517          	auipc	a0,0x4
    800017ec:	96050513          	addi	a0,a0,-1696 # 80005148 <CONSOLE_STATUS+0x138>
    800017f0:	00001097          	auipc	ra,0x1
    800017f4:	258080e7          	jalr	600(ra) # 80002a48 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800017f8:	00000493          	li	s1,0
    800017fc:	fa1ff06f          	j	8000179c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80001800:	00004517          	auipc	a0,0x4
    80001804:	84050513          	addi	a0,a0,-1984 # 80005040 <CONSOLE_STATUS+0x30>
    80001808:	00001097          	auipc	ra,0x1
    8000180c:	240080e7          	jalr	576(ra) # 80002a48 <_Z11printStringPKc>
    finishedB = true;
    80001810:	00100793          	li	a5,1
    80001814:	00005717          	auipc	a4,0x5
    80001818:	8ef70ea3          	sb	a5,-1795(a4) # 80006111 <finishedB>
    thread_dispatch();
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	b50080e7          	jalr	-1200(ra) # 8000136c <_Z15thread_dispatchv>
}
    80001824:	01813083          	ld	ra,24(sp)
    80001828:	01013403          	ld	s0,16(sp)
    8000182c:	00813483          	ld	s1,8(sp)
    80001830:	00013903          	ld	s2,0(sp)
    80001834:	02010113          	addi	sp,sp,32
    80001838:	00008067          	ret

000000008000183c <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    8000183c:	fe010113          	addi	sp,sp,-32
    80001840:	00113c23          	sd	ra,24(sp)
    80001844:	00813823          	sd	s0,16(sp)
    80001848:	00913423          	sd	s1,8(sp)
    8000184c:	01213023          	sd	s2,0(sp)
    80001850:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001854:	00000493          	li	s1,0
    80001858:	0380006f          	j	80001890 <_ZN7WorkerC11workerBodyCEPv+0x54>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000185c:	00003517          	auipc	a0,0x3
    80001860:	7f450513          	addi	a0,a0,2036 # 80005050 <CONSOLE_STATUS+0x40>
    80001864:	00001097          	auipc	ra,0x1
    80001868:	1e4080e7          	jalr	484(ra) # 80002a48 <_Z11printStringPKc>
    8000186c:	00048513          	mv	a0,s1
    80001870:	00001097          	auipc	ra,0x1
    80001874:	248080e7          	jalr	584(ra) # 80002ab8 <_Z8printIntm>
    80001878:	00004517          	auipc	a0,0x4
    8000187c:	8d050513          	addi	a0,a0,-1840 # 80005148 <CONSOLE_STATUS+0x138>
    80001880:	00001097          	auipc	ra,0x1
    80001884:	1c8080e7          	jalr	456(ra) # 80002a48 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001888:	0014849b          	addiw	s1,s1,1
    8000188c:	0ff4f493          	andi	s1,s1,255
    80001890:	00200793          	li	a5,2
    80001894:	fc97f4e3          	bgeu	a5,s1,8000185c <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80001898:	00003517          	auipc	a0,0x3
    8000189c:	7c050513          	addi	a0,a0,1984 # 80005058 <CONSOLE_STATUS+0x48>
    800018a0:	00001097          	auipc	ra,0x1
    800018a4:	1a8080e7          	jalr	424(ra) # 80002a48 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800018a8:	00700313          	li	t1,7
    thread_dispatch();
    800018ac:	00000097          	auipc	ra,0x0
    800018b0:	ac0080e7          	jalr	-1344(ra) # 8000136c <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800018b4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800018b8:	00003517          	auipc	a0,0x3
    800018bc:	7b050513          	addi	a0,a0,1968 # 80005068 <CONSOLE_STATUS+0x58>
    800018c0:	00001097          	auipc	ra,0x1
    800018c4:	188080e7          	jalr	392(ra) # 80002a48 <_Z11printStringPKc>
    800018c8:	00090513          	mv	a0,s2
    800018cc:	00001097          	auipc	ra,0x1
    800018d0:	1ec080e7          	jalr	492(ra) # 80002ab8 <_Z8printIntm>
    800018d4:	00004517          	auipc	a0,0x4
    800018d8:	87450513          	addi	a0,a0,-1932 # 80005148 <CONSOLE_STATUS+0x138>
    800018dc:	00001097          	auipc	ra,0x1
    800018e0:	16c080e7          	jalr	364(ra) # 80002a48 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800018e4:	00c00513          	li	a0,12
    800018e8:	00000097          	auipc	ra,0x0
    800018ec:	d50080e7          	jalr	-688(ra) # 80001638 <_Z9fibonaccim>
    800018f0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800018f4:	00003517          	auipc	a0,0x3
    800018f8:	77c50513          	addi	a0,a0,1916 # 80005070 <CONSOLE_STATUS+0x60>
    800018fc:	00001097          	auipc	ra,0x1
    80001900:	14c080e7          	jalr	332(ra) # 80002a48 <_Z11printStringPKc>
    80001904:	00090513          	mv	a0,s2
    80001908:	00001097          	auipc	ra,0x1
    8000190c:	1b0080e7          	jalr	432(ra) # 80002ab8 <_Z8printIntm>
    80001910:	00004517          	auipc	a0,0x4
    80001914:	83850513          	addi	a0,a0,-1992 # 80005148 <CONSOLE_STATUS+0x138>
    80001918:	00001097          	auipc	ra,0x1
    8000191c:	130080e7          	jalr	304(ra) # 80002a48 <_Z11printStringPKc>
    80001920:	0380006f          	j	80001958 <_ZN7WorkerC11workerBodyCEPv+0x11c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001924:	00003517          	auipc	a0,0x3
    80001928:	72c50513          	addi	a0,a0,1836 # 80005050 <CONSOLE_STATUS+0x40>
    8000192c:	00001097          	auipc	ra,0x1
    80001930:	11c080e7          	jalr	284(ra) # 80002a48 <_Z11printStringPKc>
    80001934:	00048513          	mv	a0,s1
    80001938:	00001097          	auipc	ra,0x1
    8000193c:	180080e7          	jalr	384(ra) # 80002ab8 <_Z8printIntm>
    80001940:	00004517          	auipc	a0,0x4
    80001944:	80850513          	addi	a0,a0,-2040 # 80005148 <CONSOLE_STATUS+0x138>
    80001948:	00001097          	auipc	ra,0x1
    8000194c:	100080e7          	jalr	256(ra) # 80002a48 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001950:	0014849b          	addiw	s1,s1,1
    80001954:	0ff4f493          	andi	s1,s1,255
    80001958:	00500793          	li	a5,5
    8000195c:	fc97f4e3          	bgeu	a5,s1,80001924 <_ZN7WorkerC11workerBodyCEPv+0xe8>
    }

    printString("A finished!\n");
    80001960:	00003517          	auipc	a0,0x3
    80001964:	6c850513          	addi	a0,a0,1736 # 80005028 <CONSOLE_STATUS+0x18>
    80001968:	00001097          	auipc	ra,0x1
    8000196c:	0e0080e7          	jalr	224(ra) # 80002a48 <_Z11printStringPKc>
    finishedC = true;
    80001970:	00100793          	li	a5,1
    80001974:	00004717          	auipc	a4,0x4
    80001978:	78f70f23          	sb	a5,1950(a4) # 80006112 <finishedC>
    thread_dispatch();
    8000197c:	00000097          	auipc	ra,0x0
    80001980:	9f0080e7          	jalr	-1552(ra) # 8000136c <_Z15thread_dispatchv>
}
    80001984:	01813083          	ld	ra,24(sp)
    80001988:	01013403          	ld	s0,16(sp)
    8000198c:	00813483          	ld	s1,8(sp)
    80001990:	00013903          	ld	s2,0(sp)
    80001994:	02010113          	addi	sp,sp,32
    80001998:	00008067          	ret

000000008000199c <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    8000199c:	fe010113          	addi	sp,sp,-32
    800019a0:	00113c23          	sd	ra,24(sp)
    800019a4:	00813823          	sd	s0,16(sp)
    800019a8:	00913423          	sd	s1,8(sp)
    800019ac:	01213023          	sd	s2,0(sp)
    800019b0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800019b4:	00a00493          	li	s1,10
    800019b8:	0380006f          	j	800019f0 <_ZN7WorkerD11workerBodyDEPv+0x54>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800019bc:	00003517          	auipc	a0,0x3
    800019c0:	6c450513          	addi	a0,a0,1732 # 80005080 <CONSOLE_STATUS+0x70>
    800019c4:	00001097          	auipc	ra,0x1
    800019c8:	084080e7          	jalr	132(ra) # 80002a48 <_Z11printStringPKc>
    800019cc:	00048513          	mv	a0,s1
    800019d0:	00001097          	auipc	ra,0x1
    800019d4:	0e8080e7          	jalr	232(ra) # 80002ab8 <_Z8printIntm>
    800019d8:	00003517          	auipc	a0,0x3
    800019dc:	77050513          	addi	a0,a0,1904 # 80005148 <CONSOLE_STATUS+0x138>
    800019e0:	00001097          	auipc	ra,0x1
    800019e4:	068080e7          	jalr	104(ra) # 80002a48 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800019e8:	0014849b          	addiw	s1,s1,1
    800019ec:	0ff4f493          	andi	s1,s1,255
    800019f0:	00c00793          	li	a5,12
    800019f4:	fc97f4e3          	bgeu	a5,s1,800019bc <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800019f8:	00003517          	auipc	a0,0x3
    800019fc:	69050513          	addi	a0,a0,1680 # 80005088 <CONSOLE_STATUS+0x78>
    80001a00:	00001097          	auipc	ra,0x1
    80001a04:	048080e7          	jalr	72(ra) # 80002a48 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001a08:	00500313          	li	t1,5
    thread_dispatch();
    80001a0c:	00000097          	auipc	ra,0x0
    80001a10:	960080e7          	jalr	-1696(ra) # 8000136c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001a14:	01000513          	li	a0,16
    80001a18:	00000097          	auipc	ra,0x0
    80001a1c:	c20080e7          	jalr	-992(ra) # 80001638 <_Z9fibonaccim>
    80001a20:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001a24:	00003517          	auipc	a0,0x3
    80001a28:	67450513          	addi	a0,a0,1652 # 80005098 <CONSOLE_STATUS+0x88>
    80001a2c:	00001097          	auipc	ra,0x1
    80001a30:	01c080e7          	jalr	28(ra) # 80002a48 <_Z11printStringPKc>
    80001a34:	00090513          	mv	a0,s2
    80001a38:	00001097          	auipc	ra,0x1
    80001a3c:	080080e7          	jalr	128(ra) # 80002ab8 <_Z8printIntm>
    80001a40:	00003517          	auipc	a0,0x3
    80001a44:	70850513          	addi	a0,a0,1800 # 80005148 <CONSOLE_STATUS+0x138>
    80001a48:	00001097          	auipc	ra,0x1
    80001a4c:	000080e7          	jalr	ra # 80002a48 <_Z11printStringPKc>
    80001a50:	0380006f          	j	80001a88 <_ZN7WorkerD11workerBodyDEPv+0xec>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001a54:	00003517          	auipc	a0,0x3
    80001a58:	62c50513          	addi	a0,a0,1580 # 80005080 <CONSOLE_STATUS+0x70>
    80001a5c:	00001097          	auipc	ra,0x1
    80001a60:	fec080e7          	jalr	-20(ra) # 80002a48 <_Z11printStringPKc>
    80001a64:	00048513          	mv	a0,s1
    80001a68:	00001097          	auipc	ra,0x1
    80001a6c:	050080e7          	jalr	80(ra) # 80002ab8 <_Z8printIntm>
    80001a70:	00003517          	auipc	a0,0x3
    80001a74:	6d850513          	addi	a0,a0,1752 # 80005148 <CONSOLE_STATUS+0x138>
    80001a78:	00001097          	auipc	ra,0x1
    80001a7c:	fd0080e7          	jalr	-48(ra) # 80002a48 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001a80:	0014849b          	addiw	s1,s1,1
    80001a84:	0ff4f493          	andi	s1,s1,255
    80001a88:	00f00793          	li	a5,15
    80001a8c:	fc97f4e3          	bgeu	a5,s1,80001a54 <_ZN7WorkerD11workerBodyDEPv+0xb8>
    }

    printString("D finished!\n");
    80001a90:	00003517          	auipc	a0,0x3
    80001a94:	61850513          	addi	a0,a0,1560 # 800050a8 <CONSOLE_STATUS+0x98>
    80001a98:	00001097          	auipc	ra,0x1
    80001a9c:	fb0080e7          	jalr	-80(ra) # 80002a48 <_Z11printStringPKc>
    finishedD = true;
    80001aa0:	00100793          	li	a5,1
    80001aa4:	00004717          	auipc	a4,0x4
    80001aa8:	66f707a3          	sb	a5,1647(a4) # 80006113 <finishedD>
    thread_dispatch();
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	8c0080e7          	jalr	-1856(ra) # 8000136c <_Z15thread_dispatchv>
}
    80001ab4:	01813083          	ld	ra,24(sp)
    80001ab8:	01013403          	ld	s0,16(sp)
    80001abc:	00813483          	ld	s1,8(sp)
    80001ac0:	00013903          	ld	s2,0(sp)
    80001ac4:	02010113          	addi	sp,sp,32
    80001ac8:	00008067          	ret

0000000080001acc <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80001acc:	fc010113          	addi	sp,sp,-64
    80001ad0:	02113c23          	sd	ra,56(sp)
    80001ad4:	02813823          	sd	s0,48(sp)
    80001ad8:	02913423          	sd	s1,40(sp)
    80001adc:	03213023          	sd	s2,32(sp)
    80001ae0:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80001ae4:	01000513          	li	a0,16
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	698080e7          	jalr	1688(ra) # 80002180 <_Znwm>
    80001af0:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80001af4:	00000097          	auipc	ra,0x0
    80001af8:	7a4080e7          	jalr	1956(ra) # 80002298 <_ZN6ThreadC1Ev>
    80001afc:	00004797          	auipc	a5,0x4
    80001b00:	4c478793          	addi	a5,a5,1220 # 80005fc0 <_ZTV7WorkerA+0x10>
    80001b04:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80001b08:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80001b0c:	00003517          	auipc	a0,0x3
    80001b10:	5ac50513          	addi	a0,a0,1452 # 800050b8 <CONSOLE_STATUS+0xa8>
    80001b14:	00001097          	auipc	ra,0x1
    80001b18:	f34080e7          	jalr	-204(ra) # 80002a48 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80001b1c:	01000513          	li	a0,16
    80001b20:	00000097          	auipc	ra,0x0
    80001b24:	660080e7          	jalr	1632(ra) # 80002180 <_Znwm>
    80001b28:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80001b2c:	00000097          	auipc	ra,0x0
    80001b30:	76c080e7          	jalr	1900(ra) # 80002298 <_ZN6ThreadC1Ev>
    80001b34:	00004797          	auipc	a5,0x4
    80001b38:	4b478793          	addi	a5,a5,1204 # 80005fe8 <_ZTV7WorkerB+0x10>
    80001b3c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80001b40:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80001b44:	00003517          	auipc	a0,0x3
    80001b48:	58c50513          	addi	a0,a0,1420 # 800050d0 <CONSOLE_STATUS+0xc0>
    80001b4c:	00001097          	auipc	ra,0x1
    80001b50:	efc080e7          	jalr	-260(ra) # 80002a48 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80001b54:	01000513          	li	a0,16
    80001b58:	00000097          	auipc	ra,0x0
    80001b5c:	628080e7          	jalr	1576(ra) # 80002180 <_Znwm>
    80001b60:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80001b64:	00000097          	auipc	ra,0x0
    80001b68:	734080e7          	jalr	1844(ra) # 80002298 <_ZN6ThreadC1Ev>
    80001b6c:	00004797          	auipc	a5,0x4
    80001b70:	4a478793          	addi	a5,a5,1188 # 80006010 <_ZTV7WorkerC+0x10>
    80001b74:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80001b78:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80001b7c:	00003517          	auipc	a0,0x3
    80001b80:	56c50513          	addi	a0,a0,1388 # 800050e8 <CONSOLE_STATUS+0xd8>
    80001b84:	00001097          	auipc	ra,0x1
    80001b88:	ec4080e7          	jalr	-316(ra) # 80002a48 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80001b8c:	01000513          	li	a0,16
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	5f0080e7          	jalr	1520(ra) # 80002180 <_Znwm>
    80001b98:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80001b9c:	00000097          	auipc	ra,0x0
    80001ba0:	6fc080e7          	jalr	1788(ra) # 80002298 <_ZN6ThreadC1Ev>
    80001ba4:	00004797          	auipc	a5,0x4
    80001ba8:	49478793          	addi	a5,a5,1172 # 80006038 <_ZTV7WorkerD+0x10>
    80001bac:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80001bb0:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80001bb4:	00003517          	auipc	a0,0x3
    80001bb8:	54c50513          	addi	a0,a0,1356 # 80005100 <CONSOLE_STATUS+0xf0>
    80001bbc:	00001097          	auipc	ra,0x1
    80001bc0:	e8c080e7          	jalr	-372(ra) # 80002a48 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80001bc4:	00000493          	li	s1,0
    80001bc8:	00300793          	li	a5,3
    80001bcc:	0297c663          	blt	a5,s1,80001bf8 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80001bd0:	00349793          	slli	a5,s1,0x3
    80001bd4:	fe040713          	addi	a4,s0,-32
    80001bd8:	00f707b3          	add	a5,a4,a5
    80001bdc:	fe07b503          	ld	a0,-32(a5)
    80001be0:	00000097          	auipc	ra,0x0
    80001be4:	6fc080e7          	jalr	1788(ra) # 800022dc <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80001be8:	0014849b          	addiw	s1,s1,1
    80001bec:	fddff06f          	j	80001bc8 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80001bf0:	00000097          	auipc	ra,0x0
    80001bf4:	718080e7          	jalr	1816(ra) # 80002308 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80001bf8:	00004797          	auipc	a5,0x4
    80001bfc:	5187c783          	lbu	a5,1304(a5) # 80006110 <finishedA>
    80001c00:	fe0788e3          	beqz	a5,80001bf0 <_Z20Threads_CPP_API_testv+0x124>
    80001c04:	00004797          	auipc	a5,0x4
    80001c08:	50d7c783          	lbu	a5,1293(a5) # 80006111 <finishedB>
    80001c0c:	fe0782e3          	beqz	a5,80001bf0 <_Z20Threads_CPP_API_testv+0x124>
    80001c10:	00004797          	auipc	a5,0x4
    80001c14:	5027c783          	lbu	a5,1282(a5) # 80006112 <finishedC>
    80001c18:	fc078ce3          	beqz	a5,80001bf0 <_Z20Threads_CPP_API_testv+0x124>
    80001c1c:	00004797          	auipc	a5,0x4
    80001c20:	4f77c783          	lbu	a5,1271(a5) # 80006113 <finishedD>
    80001c24:	fc0786e3          	beqz	a5,80001bf0 <_Z20Threads_CPP_API_testv+0x124>
    }

    //dovde se ispravno izvrsava
    for (auto thread: threads) { delete thread; }
    80001c28:	fc040493          	addi	s1,s0,-64
    80001c2c:	0080006f          	j	80001c34 <_Z20Threads_CPP_API_testv+0x168>
    80001c30:	00848493          	addi	s1,s1,8
    80001c34:	fe040793          	addi	a5,s0,-32
    80001c38:	08f48663          	beq	s1,a5,80001cc4 <_Z20Threads_CPP_API_testv+0x1f8>
    80001c3c:	0004b503          	ld	a0,0(s1)
    80001c40:	fe0508e3          	beqz	a0,80001c30 <_Z20Threads_CPP_API_testv+0x164>
    80001c44:	00053783          	ld	a5,0(a0)
    80001c48:	0087b783          	ld	a5,8(a5)
    80001c4c:	000780e7          	jalr	a5
    80001c50:	fe1ff06f          	j	80001c30 <_Z20Threads_CPP_API_testv+0x164>
    80001c54:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80001c58:	00048513          	mv	a0,s1
    80001c5c:	00000097          	auipc	ra,0x0
    80001c60:	574080e7          	jalr	1396(ra) # 800021d0 <_ZdlPv>
    80001c64:	00090513          	mv	a0,s2
    80001c68:	00005097          	auipc	ra,0x5
    80001c6c:	5a0080e7          	jalr	1440(ra) # 80007208 <_Unwind_Resume>
    80001c70:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80001c74:	00048513          	mv	a0,s1
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	558080e7          	jalr	1368(ra) # 800021d0 <_ZdlPv>
    80001c80:	00090513          	mv	a0,s2
    80001c84:	00005097          	auipc	ra,0x5
    80001c88:	584080e7          	jalr	1412(ra) # 80007208 <_Unwind_Resume>
    80001c8c:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80001c90:	00048513          	mv	a0,s1
    80001c94:	00000097          	auipc	ra,0x0
    80001c98:	53c080e7          	jalr	1340(ra) # 800021d0 <_ZdlPv>
    80001c9c:	00090513          	mv	a0,s2
    80001ca0:	00005097          	auipc	ra,0x5
    80001ca4:	568080e7          	jalr	1384(ra) # 80007208 <_Unwind_Resume>
    80001ca8:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80001cac:	00048513          	mv	a0,s1
    80001cb0:	00000097          	auipc	ra,0x0
    80001cb4:	520080e7          	jalr	1312(ra) # 800021d0 <_ZdlPv>
    80001cb8:	00090513          	mv	a0,s2
    80001cbc:	00005097          	auipc	ra,0x5
    80001cc0:	54c080e7          	jalr	1356(ra) # 80007208 <_Unwind_Resume>
}
    80001cc4:	03813083          	ld	ra,56(sp)
    80001cc8:	03013403          	ld	s0,48(sp)
    80001ccc:	02813483          	ld	s1,40(sp)
    80001cd0:	02013903          	ld	s2,32(sp)
    80001cd4:	04010113          	addi	sp,sp,64
    80001cd8:	00008067          	ret

0000000080001cdc <_Z8userMainv>:
//#include "../test/ConsumerProducer_CPP_Sync_API_test.hpp" // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//#include "../test/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "../test/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta

void userMain() {
    80001cdc:	ff010113          	addi	sp,sp,-16
    80001ce0:	00113423          	sd	ra,8(sp)
    80001ce4:	00813023          	sd	s0,0(sp)
    80001ce8:	01010413          	addi	s0,sp,16
    //Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    Threads_CPP_API_test(); // zadatak 2., niti CPP API i sinhrona promena konteksta
    80001cec:	00000097          	auipc	ra,0x0
    80001cf0:	de0080e7          	jalr	-544(ra) # 80001acc <_Z20Threads_CPP_API_testv>
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    80001cf4:	00813083          	ld	ra,8(sp)
    80001cf8:	00013403          	ld	s0,0(sp)
    80001cfc:	01010113          	addi	sp,sp,16
    80001d00:	00008067          	ret

0000000080001d04 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80001d04:	ff010113          	addi	sp,sp,-16
    80001d08:	00113423          	sd	ra,8(sp)
    80001d0c:	00813023          	sd	s0,0(sp)
    80001d10:	01010413          	addi	s0,sp,16
    80001d14:	00004797          	auipc	a5,0x4
    80001d18:	2ac78793          	addi	a5,a5,684 # 80005fc0 <_ZTV7WorkerA+0x10>
    80001d1c:	00f53023          	sd	a5,0(a0)
    80001d20:	00000097          	auipc	ra,0x0
    80001d24:	428080e7          	jalr	1064(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001d28:	00813083          	ld	ra,8(sp)
    80001d2c:	00013403          	ld	s0,0(sp)
    80001d30:	01010113          	addi	sp,sp,16
    80001d34:	00008067          	ret

0000000080001d38 <_ZN7WorkerAD0Ev>:
    80001d38:	fe010113          	addi	sp,sp,-32
    80001d3c:	00113c23          	sd	ra,24(sp)
    80001d40:	00813823          	sd	s0,16(sp)
    80001d44:	00913423          	sd	s1,8(sp)
    80001d48:	02010413          	addi	s0,sp,32
    80001d4c:	00050493          	mv	s1,a0
    80001d50:	00004797          	auipc	a5,0x4
    80001d54:	27078793          	addi	a5,a5,624 # 80005fc0 <_ZTV7WorkerA+0x10>
    80001d58:	00f53023          	sd	a5,0(a0)
    80001d5c:	00000097          	auipc	ra,0x0
    80001d60:	3ec080e7          	jalr	1004(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001d64:	00048513          	mv	a0,s1
    80001d68:	00000097          	auipc	ra,0x0
    80001d6c:	468080e7          	jalr	1128(ra) # 800021d0 <_ZdlPv>
    80001d70:	01813083          	ld	ra,24(sp)
    80001d74:	01013403          	ld	s0,16(sp)
    80001d78:	00813483          	ld	s1,8(sp)
    80001d7c:	02010113          	addi	sp,sp,32
    80001d80:	00008067          	ret

0000000080001d84 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80001d84:	ff010113          	addi	sp,sp,-16
    80001d88:	00113423          	sd	ra,8(sp)
    80001d8c:	00813023          	sd	s0,0(sp)
    80001d90:	01010413          	addi	s0,sp,16
    80001d94:	00004797          	auipc	a5,0x4
    80001d98:	25478793          	addi	a5,a5,596 # 80005fe8 <_ZTV7WorkerB+0x10>
    80001d9c:	00f53023          	sd	a5,0(a0)
    80001da0:	00000097          	auipc	ra,0x0
    80001da4:	3a8080e7          	jalr	936(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001da8:	00813083          	ld	ra,8(sp)
    80001dac:	00013403          	ld	s0,0(sp)
    80001db0:	01010113          	addi	sp,sp,16
    80001db4:	00008067          	ret

0000000080001db8 <_ZN7WorkerBD0Ev>:
    80001db8:	fe010113          	addi	sp,sp,-32
    80001dbc:	00113c23          	sd	ra,24(sp)
    80001dc0:	00813823          	sd	s0,16(sp)
    80001dc4:	00913423          	sd	s1,8(sp)
    80001dc8:	02010413          	addi	s0,sp,32
    80001dcc:	00050493          	mv	s1,a0
    80001dd0:	00004797          	auipc	a5,0x4
    80001dd4:	21878793          	addi	a5,a5,536 # 80005fe8 <_ZTV7WorkerB+0x10>
    80001dd8:	00f53023          	sd	a5,0(a0)
    80001ddc:	00000097          	auipc	ra,0x0
    80001de0:	36c080e7          	jalr	876(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001de4:	00048513          	mv	a0,s1
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	3e8080e7          	jalr	1000(ra) # 800021d0 <_ZdlPv>
    80001df0:	01813083          	ld	ra,24(sp)
    80001df4:	01013403          	ld	s0,16(sp)
    80001df8:	00813483          	ld	s1,8(sp)
    80001dfc:	02010113          	addi	sp,sp,32
    80001e00:	00008067          	ret

0000000080001e04 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80001e04:	ff010113          	addi	sp,sp,-16
    80001e08:	00113423          	sd	ra,8(sp)
    80001e0c:	00813023          	sd	s0,0(sp)
    80001e10:	01010413          	addi	s0,sp,16
    80001e14:	00004797          	auipc	a5,0x4
    80001e18:	1fc78793          	addi	a5,a5,508 # 80006010 <_ZTV7WorkerC+0x10>
    80001e1c:	00f53023          	sd	a5,0(a0)
    80001e20:	00000097          	auipc	ra,0x0
    80001e24:	328080e7          	jalr	808(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001e28:	00813083          	ld	ra,8(sp)
    80001e2c:	00013403          	ld	s0,0(sp)
    80001e30:	01010113          	addi	sp,sp,16
    80001e34:	00008067          	ret

0000000080001e38 <_ZN7WorkerCD0Ev>:
    80001e38:	fe010113          	addi	sp,sp,-32
    80001e3c:	00113c23          	sd	ra,24(sp)
    80001e40:	00813823          	sd	s0,16(sp)
    80001e44:	00913423          	sd	s1,8(sp)
    80001e48:	02010413          	addi	s0,sp,32
    80001e4c:	00050493          	mv	s1,a0
    80001e50:	00004797          	auipc	a5,0x4
    80001e54:	1c078793          	addi	a5,a5,448 # 80006010 <_ZTV7WorkerC+0x10>
    80001e58:	00f53023          	sd	a5,0(a0)
    80001e5c:	00000097          	auipc	ra,0x0
    80001e60:	2ec080e7          	jalr	748(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001e64:	00048513          	mv	a0,s1
    80001e68:	00000097          	auipc	ra,0x0
    80001e6c:	368080e7          	jalr	872(ra) # 800021d0 <_ZdlPv>
    80001e70:	01813083          	ld	ra,24(sp)
    80001e74:	01013403          	ld	s0,16(sp)
    80001e78:	00813483          	ld	s1,8(sp)
    80001e7c:	02010113          	addi	sp,sp,32
    80001e80:	00008067          	ret

0000000080001e84 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80001e84:	ff010113          	addi	sp,sp,-16
    80001e88:	00113423          	sd	ra,8(sp)
    80001e8c:	00813023          	sd	s0,0(sp)
    80001e90:	01010413          	addi	s0,sp,16
    80001e94:	00004797          	auipc	a5,0x4
    80001e98:	1a478793          	addi	a5,a5,420 # 80006038 <_ZTV7WorkerD+0x10>
    80001e9c:	00f53023          	sd	a5,0(a0)
    80001ea0:	00000097          	auipc	ra,0x0
    80001ea4:	2a8080e7          	jalr	680(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001ea8:	00813083          	ld	ra,8(sp)
    80001eac:	00013403          	ld	s0,0(sp)
    80001eb0:	01010113          	addi	sp,sp,16
    80001eb4:	00008067          	ret

0000000080001eb8 <_ZN7WorkerDD0Ev>:
    80001eb8:	fe010113          	addi	sp,sp,-32
    80001ebc:	00113c23          	sd	ra,24(sp)
    80001ec0:	00813823          	sd	s0,16(sp)
    80001ec4:	00913423          	sd	s1,8(sp)
    80001ec8:	02010413          	addi	s0,sp,32
    80001ecc:	00050493          	mv	s1,a0
    80001ed0:	00004797          	auipc	a5,0x4
    80001ed4:	16878793          	addi	a5,a5,360 # 80006038 <_ZTV7WorkerD+0x10>
    80001ed8:	00f53023          	sd	a5,0(a0)
    80001edc:	00000097          	auipc	ra,0x0
    80001ee0:	26c080e7          	jalr	620(ra) # 80002148 <_ZN6ThreadD1Ev>
    80001ee4:	00048513          	mv	a0,s1
    80001ee8:	00000097          	auipc	ra,0x0
    80001eec:	2e8080e7          	jalr	744(ra) # 800021d0 <_ZdlPv>
    80001ef0:	01813083          	ld	ra,24(sp)
    80001ef4:	01013403          	ld	s0,16(sp)
    80001ef8:	00813483          	ld	s1,8(sp)
    80001efc:	02010113          	addi	sp,sp,32
    80001f00:	00008067          	ret

0000000080001f04 <_ZN7WorkerA3runEv>:
    void run() override {
    80001f04:	ff010113          	addi	sp,sp,-16
    80001f08:	00113423          	sd	ra,8(sp)
    80001f0c:	00813023          	sd	s0,0(sp)
    80001f10:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80001f14:	00000593          	li	a1,0
    80001f18:	fffff097          	auipc	ra,0xfffff
    80001f1c:	794080e7          	jalr	1940(ra) # 800016ac <_ZN7WorkerA11workerBodyAEPv>
    }
    80001f20:	00813083          	ld	ra,8(sp)
    80001f24:	00013403          	ld	s0,0(sp)
    80001f28:	01010113          	addi	sp,sp,16
    80001f2c:	00008067          	ret

0000000080001f30 <_ZN7WorkerB3runEv>:
    void run() override {
    80001f30:	ff010113          	addi	sp,sp,-16
    80001f34:	00113423          	sd	ra,8(sp)
    80001f38:	00813023          	sd	s0,0(sp)
    80001f3c:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80001f40:	00000593          	li	a1,0
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	82c080e7          	jalr	-2004(ra) # 80001770 <_ZN7WorkerB11workerBodyBEPv>
    }
    80001f4c:	00813083          	ld	ra,8(sp)
    80001f50:	00013403          	ld	s0,0(sp)
    80001f54:	01010113          	addi	sp,sp,16
    80001f58:	00008067          	ret

0000000080001f5c <_ZN7WorkerC3runEv>:
    void run() override {
    80001f5c:	ff010113          	addi	sp,sp,-16
    80001f60:	00113423          	sd	ra,8(sp)
    80001f64:	00813023          	sd	s0,0(sp)
    80001f68:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80001f6c:	00000593          	li	a1,0
    80001f70:	00000097          	auipc	ra,0x0
    80001f74:	8cc080e7          	jalr	-1844(ra) # 8000183c <_ZN7WorkerC11workerBodyCEPv>
    }
    80001f78:	00813083          	ld	ra,8(sp)
    80001f7c:	00013403          	ld	s0,0(sp)
    80001f80:	01010113          	addi	sp,sp,16
    80001f84:	00008067          	ret

0000000080001f88 <_ZN7WorkerD3runEv>:
    void run() override {
    80001f88:	ff010113          	addi	sp,sp,-16
    80001f8c:	00113423          	sd	ra,8(sp)
    80001f90:	00813023          	sd	s0,0(sp)
    80001f94:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80001f98:	00000593          	li	a1,0
    80001f9c:	00000097          	auipc	ra,0x0
    80001fa0:	a00080e7          	jalr	-1536(ra) # 8000199c <_ZN7WorkerD11workerBodyDEPv>
    }
    80001fa4:	00813083          	ld	ra,8(sp)
    80001fa8:	00013403          	ld	s0,0(sp)
    80001fac:	01010113          	addi	sp,sp,16
    80001fb0:	00008067          	ret

0000000080001fb4 <_Z12user_wrapperPv>:
#include "../h/print.hpp"
#include "../lib/mem.h"

extern void userMain();

void user_wrapper(void*){
    80001fb4:	ff010113          	addi	sp,sp,-16
    80001fb8:	00113423          	sd	ra,8(sp)
    80001fbc:	00813023          	sd	s0,0(sp)
    80001fc0:	01010413          	addi	s0,sp,16
    userMain();
    80001fc4:	00000097          	auipc	ra,0x0
    80001fc8:	d18080e7          	jalr	-744(ra) # 80001cdc <_Z8userMainv>
    _thread::running->setFinished(true);
    80001fcc:	00004797          	auipc	a5,0x4
    80001fd0:	0c47b783          	ld	a5,196(a5) # 80006090 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001fd4:	0007b783          	ld	a5,0(a5)
    80001fd8:	00100713          	li	a4,1
    80001fdc:	02e78423          	sb	a4,40(a5)
    _thread::yield();
    80001fe0:	fffff097          	auipc	ra,0xfffff
    80001fe4:	5f4080e7          	jalr	1524(ra) # 800015d4 <_ZN7_thread5yieldEv>
}
    80001fe8:	00813083          	ld	ra,8(sp)
    80001fec:	00013403          	ld	s0,0(sp)
    80001ff0:	01010113          	addi	sp,sp,16
    80001ff4:	00008067          	ret

0000000080001ff8 <main>:

void main(){
    80001ff8:	fe010113          	addi	sp,sp,-32
    80001ffc:	00113c23          	sd	ra,24(sp)
    80002000:	00813823          	sd	s0,16(sp)
    80002004:	00913423          	sd	s1,8(sp)
    80002008:	01213023          	sd	s2,0(sp)
    8000200c:	02010413          	addi	s0,sp,32
    MemoryAllocator::init();
    80002010:	00000097          	auipc	ra,0x0
    80002014:	734080e7          	jalr	1844(ra) # 80002744 <_ZN15MemoryAllocator4initEv>

    //pravljenje main i user main niti
    _thread *threads[2];

    //thread_create(&threads[0], nullptr, nullptr);
    threads[0] = _thread::createThread(nullptr, nullptr, nullptr);
    80002018:	00000613          	li	a2,0
    8000201c:	00000593          	li	a1,0
    80002020:	00000513          	li	a0,0
    80002024:	fffff097          	auipc	ra,0xfffff
    80002028:	3b0080e7          	jalr	944(ra) # 800013d4 <_ZN7_thread12createThreadEPFvPvES0_Pm>
    8000202c:	00050913          	mv	s2,a0
    _thread::main = _thread::running = threads[0];
    80002030:	00004797          	auipc	a5,0x4
    80002034:	0607b783          	ld	a5,96(a5) # 80006090 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002038:	00a7b023          	sd	a0,0(a5)
    8000203c:	00004797          	auipc	a5,0x4
    80002040:	06c7b783          	ld	a5,108(a5) # 800060a8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002044:	00a7b023          	sd	a0,0(a5)
    void setFlag(bool flag) {this->flag = flag;}
    80002048:	00100793          	li	a5,1
    8000204c:	02f504a3          	sb	a5,41(a0)
    _thread::running->setFlag(true);
    printString("Main thread created\n");
    80002050:	00003517          	auipc	a0,0x3
    80002054:	0c850513          	addi	a0,a0,200 # 80005118 <CONSOLE_STATUS+0x108>
    80002058:	00001097          	auipc	ra,0x1
    8000205c:	9f0080e7          	jalr	-1552(ra) # 80002a48 <_Z11printStringPKc>

    //void* stack = mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    void* stack = __mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
    80002060:	00008537          	lui	a0,0x8
    80002064:	00003097          	auipc	ra,0x3
    80002068:	dc4080e7          	jalr	-572(ra) # 80004e28 <__mem_alloc>
    8000206c:	00050613          	mv	a2,a0
    //thread_create(&threads[1], user_wrapper, nullptr);
    threads[1] = _thread::createThread(&user_wrapper, nullptr, (uint64*)stack);
    80002070:	00000593          	li	a1,0
    80002074:	00000517          	auipc	a0,0x0
    80002078:	f4050513          	addi	a0,a0,-192 # 80001fb4 <_Z12user_wrapperPv>
    8000207c:	fffff097          	auipc	ra,0xfffff
    80002080:	358080e7          	jalr	856(ra) # 800013d4 <_ZN7_thread12createThreadEPFvPvES0_Pm>
    80002084:	00050493          	mv	s1,a0
    printString("User main thread created\n");
    80002088:	00003517          	auipc	a0,0x3
    8000208c:	0a850513          	addi	a0,a0,168 # 80005130 <CONSOLE_STATUS+0x120>
    80002090:	00001097          	auipc	ra,0x1
    80002094:	9b8080e7          	jalr	-1608(ra) # 80002a48 <_Z11printStringPKc>

//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
//    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    //stavlja userMain u scheduler
    threads[1]->start();
    80002098:	00048513          	mv	a0,s1
    8000209c:	fffff097          	auipc	ra,0xfffff
    800020a0:	450080e7          	jalr	1104(ra) # 800014ec <_ZN7_thread5startEv>

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800020a4:	00004797          	auipc	a5,0x4
    800020a8:	ff47b783          	ld	a5,-12(a5) # 80006098 <_GLOBAL_OFFSET_TABLE_+0x18>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800020ac:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800020b0:	00200793          	li	a5,2
    800020b4:	1007a073          	csrs	sstatus,a5
    bool isFinished() const { return finished; }
    800020b8:	0284c783          	lbu	a5,40(s1)
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    while(!threads[1]->isFinished()){
    800020bc:	00079863          	bnez	a5,800020cc <main+0xd4>
        //_thread::yield();
        thread_dispatch();
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	2ac080e7          	jalr	684(ra) # 8000136c <_Z15thread_dispatchv>
    800020c8:	ff1ff06f          	j	800020b8 <main+0xc0>
    }
    printString("User main thread finished\n");
    800020cc:	00003517          	auipc	a0,0x3
    800020d0:	08450513          	addi	a0,a0,132 # 80005150 <CONSOLE_STATUS+0x140>
    800020d4:	00001097          	auipc	ra,0x1
    800020d8:	974080e7          	jalr	-1676(ra) # 80002a48 <_Z11printStringPKc>
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800020dc:	00200793          	li	a5,2
    800020e0:	1007b073          	csrc	sstatus,a5
//        delete thread;
//    }

    //ovde nesto baguje
    //delete threads[1];
    delete threads[0];
    800020e4:	02090063          	beqz	s2,80002104 <main+0x10c>
    ~_thread() { delete[] stack; }
    800020e8:	01093503          	ld	a0,16(s2)
    800020ec:	00050663          	beqz	a0,800020f8 <main+0x100>
    800020f0:	00000097          	auipc	ra,0x0
    800020f4:	148080e7          	jalr	328(ra) # 80002238 <_ZdaPv>
__mem_free(p);
    800020f8:	00090513          	mv	a0,s2
    800020fc:	00003097          	auipc	ra,0x3
    80002100:	c60080e7          	jalr	-928(ra) # 80004d5c <__mem_free>
}
    80002104:	01813083          	ld	ra,24(sp)
    80002108:	01013403          	ld	s0,16(sp)
    8000210c:	00813483          	ld	s1,8(sp)
    80002110:	00013903          	ld	s2,0(sp)
    80002114:	02010113          	addi	sp,sp,32
    80002118:	00008067          	ret

000000008000211c <_ZN6Thread7wrapperEPv>:
int Thread::sleep(time_t time){
    return 0;
    //...
}

void Thread::wrapper(void *thr){
    8000211c:	ff010113          	addi	sp,sp,-16
    80002120:	00113423          	sd	ra,8(sp)
    80002124:	00813023          	sd	s0,0(sp)
    80002128:	01010413          	addi	s0,sp,16
    ((Thread*)thr)->run();
    8000212c:	00053783          	ld	a5,0(a0)
    80002130:	0107b783          	ld	a5,16(a5)
    80002134:	000780e7          	jalr	a5
}
    80002138:	00813083          	ld	ra,8(sp)
    8000213c:	00013403          	ld	s0,0(sp)
    80002140:	01010113          	addi	sp,sp,16
    80002144:	00008067          	ret

0000000080002148 <_ZN6ThreadD1Ev>:
Thread::~Thread(){
    80002148:	ff010113          	addi	sp,sp,-16
    8000214c:	00113423          	sd	ra,8(sp)
    80002150:	00813023          	sd	s0,0(sp)
    80002154:	01010413          	addi	s0,sp,16
    80002158:	00004797          	auipc	a5,0x4
    8000215c:	f1078793          	addi	a5,a5,-240 # 80006068 <_ZTV6Thread+0x10>
    80002160:	00f53023          	sd	a5,0(a0)
    mem_free((void*)myHandle);
    80002164:	00853503          	ld	a0,8(a0)
    80002168:	fffff097          	auipc	ra,0xfffff
    8000216c:	020080e7          	jalr	32(ra) # 80001188 <_Z8mem_freePv>
}
    80002170:	00813083          	ld	ra,8(sp)
    80002174:	00013403          	ld	s0,0(sp)
    80002178:	01010113          	addi	sp,sp,16
    8000217c:	00008067          	ret

0000000080002180 <_Znwm>:
{
    80002180:	ff010113          	addi	sp,sp,-16
    80002184:	00113423          	sd	ra,8(sp)
    80002188:	00813023          	sd	s0,0(sp)
    8000218c:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80002190:	fffff097          	auipc	ra,0xfffff
    80002194:	fb4080e7          	jalr	-76(ra) # 80001144 <_Z9mem_allocm>
}
    80002198:	00813083          	ld	ra,8(sp)
    8000219c:	00013403          	ld	s0,0(sp)
    800021a0:	01010113          	addi	sp,sp,16
    800021a4:	00008067          	ret

00000000800021a8 <_Znam>:
{
    800021a8:	ff010113          	addi	sp,sp,-16
    800021ac:	00113423          	sd	ra,8(sp)
    800021b0:	00813023          	sd	s0,0(sp)
    800021b4:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	f8c080e7          	jalr	-116(ra) # 80001144 <_Z9mem_allocm>
}
    800021c0:	00813083          	ld	ra,8(sp)
    800021c4:	00013403          	ld	s0,0(sp)
    800021c8:	01010113          	addi	sp,sp,16
    800021cc:	00008067          	ret

00000000800021d0 <_ZdlPv>:
{
    800021d0:	ff010113          	addi	sp,sp,-16
    800021d4:	00113423          	sd	ra,8(sp)
    800021d8:	00813023          	sd	s0,0(sp)
    800021dc:	01010413          	addi	s0,sp,16
    mem_free(p);
    800021e0:	fffff097          	auipc	ra,0xfffff
    800021e4:	fa8080e7          	jalr	-88(ra) # 80001188 <_Z8mem_freePv>
}
    800021e8:	00813083          	ld	ra,8(sp)
    800021ec:	00013403          	ld	s0,0(sp)
    800021f0:	01010113          	addi	sp,sp,16
    800021f4:	00008067          	ret

00000000800021f8 <_ZN6ThreadD0Ev>:
Thread::~Thread(){
    800021f8:	fe010113          	addi	sp,sp,-32
    800021fc:	00113c23          	sd	ra,24(sp)
    80002200:	00813823          	sd	s0,16(sp)
    80002204:	00913423          	sd	s1,8(sp)
    80002208:	02010413          	addi	s0,sp,32
    8000220c:	00050493          	mv	s1,a0
}
    80002210:	00000097          	auipc	ra,0x0
    80002214:	f38080e7          	jalr	-200(ra) # 80002148 <_ZN6ThreadD1Ev>
    80002218:	00048513          	mv	a0,s1
    8000221c:	00000097          	auipc	ra,0x0
    80002220:	fb4080e7          	jalr	-76(ra) # 800021d0 <_ZdlPv>
    80002224:	01813083          	ld	ra,24(sp)
    80002228:	01013403          	ld	s0,16(sp)
    8000222c:	00813483          	ld	s1,8(sp)
    80002230:	02010113          	addi	sp,sp,32
    80002234:	00008067          	ret

0000000080002238 <_ZdaPv>:
{
    80002238:	ff010113          	addi	sp,sp,-16
    8000223c:	00113423          	sd	ra,8(sp)
    80002240:	00813023          	sd	s0,0(sp)
    80002244:	01010413          	addi	s0,sp,16
    mem_free(p);
    80002248:	fffff097          	auipc	ra,0xfffff
    8000224c:	f40080e7          	jalr	-192(ra) # 80001188 <_Z8mem_freePv>
}
    80002250:	00813083          	ld	ra,8(sp)
    80002254:	00013403          	ld	s0,0(sp)
    80002258:	01010113          	addi	sp,sp,16
    8000225c:	00008067          	ret

0000000080002260 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg){
    80002260:	ff010113          	addi	sp,sp,-16
    80002264:	00113423          	sd	ra,8(sp)
    80002268:	00813023          	sd	s0,0(sp)
    8000226c:	01010413          	addi	s0,sp,16
    80002270:	00004797          	auipc	a5,0x4
    80002274:	df878793          	addi	a5,a5,-520 # 80006068 <_ZTV6Thread+0x10>
    80002278:	00f53023          	sd	a5,0(a0)
    thread_create_dont_start(&myHandle, body, arg);
    8000227c:	00850513          	addi	a0,a0,8
    80002280:	fffff097          	auipc	ra,0xfffff
    80002284:	f40080e7          	jalr	-192(ra) # 800011c0 <_Z24thread_create_dont_startPP7_threadPFvPvES2_>
}
    80002288:	00813083          	ld	ra,8(sp)
    8000228c:	00013403          	ld	s0,0(sp)
    80002290:	01010113          	addi	sp,sp,16
    80002294:	00008067          	ret

0000000080002298 <_ZN6ThreadC1Ev>:
Thread::Thread(){
    80002298:	ff010113          	addi	sp,sp,-16
    8000229c:	00113423          	sd	ra,8(sp)
    800022a0:	00813023          	sd	s0,0(sp)
    800022a4:	01010413          	addi	s0,sp,16
    800022a8:	00004797          	auipc	a5,0x4
    800022ac:	dc078793          	addi	a5,a5,-576 # 80006068 <_ZTV6Thread+0x10>
    800022b0:	00f53023          	sd	a5,0(a0)
    thread_create_dont_start(&myHandle, Thread::wrapper, this);
    800022b4:	00050613          	mv	a2,a0
    800022b8:	00000597          	auipc	a1,0x0
    800022bc:	e6458593          	addi	a1,a1,-412 # 8000211c <_ZN6Thread7wrapperEPv>
    800022c0:	00850513          	addi	a0,a0,8
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	efc080e7          	jalr	-260(ra) # 800011c0 <_Z24thread_create_dont_startPP7_threadPFvPvES2_>
}
    800022cc:	00813083          	ld	ra,8(sp)
    800022d0:	00013403          	ld	s0,0(sp)
    800022d4:	01010113          	addi	sp,sp,16
    800022d8:	00008067          	ret

00000000800022dc <_ZN6Thread5startEv>:
int Thread::start(){
    800022dc:	ff010113          	addi	sp,sp,-16
    800022e0:	00113423          	sd	ra,8(sp)
    800022e4:	00813023          	sd	s0,0(sp)
    800022e8:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    800022ec:	00853503          	ld	a0,8(a0)
    800022f0:	fffff097          	auipc	ra,0xfffff
    800022f4:	f70080e7          	jalr	-144(ra) # 80001260 <_Z12thread_startP7_thread>
}
    800022f8:	00813083          	ld	ra,8(sp)
    800022fc:	00013403          	ld	s0,0(sp)
    80002300:	01010113          	addi	sp,sp,16
    80002304:	00008067          	ret

0000000080002308 <_ZN6Thread8dispatchEv>:
void Thread::dispatch(){
    80002308:	ff010113          	addi	sp,sp,-16
    8000230c:	00113423          	sd	ra,8(sp)
    80002310:	00813023          	sd	s0,0(sp)
    80002314:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002318:	fffff097          	auipc	ra,0xfffff
    8000231c:	054080e7          	jalr	84(ra) # 8000136c <_Z15thread_dispatchv>
}
    80002320:	00813083          	ld	ra,8(sp)
    80002324:	00013403          	ld	s0,0(sp)
    80002328:	01010113          	addi	sp,sp,16
    8000232c:	00008067          	ret

0000000080002330 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time){
    80002330:	ff010113          	addi	sp,sp,-16
    80002334:	00813423          	sd	s0,8(sp)
    80002338:	01010413          	addi	s0,sp,16
}
    8000233c:	00000513          	li	a0,0
    80002340:	00813403          	ld	s0,8(sp)
    80002344:	01010113          	addi	sp,sp,16
    80002348:	00008067          	ret

000000008000234c <_ZN6Thread3runEv>:
    static int sleep(time_t);
    static void wrapper(void*);

protected:
    Thread();
    virtual void run() {}
    8000234c:	ff010113          	addi	sp,sp,-16
    80002350:	00813423          	sd	s0,8(sp)
    80002354:	01010413          	addi	s0,sp,16
    80002358:	00813403          	ld	s0,8(sp)
    8000235c:	01010113          	addi	sp,sp,16
    80002360:	00008067          	ret

0000000080002364 <_ZN5Riscv10popSppSpieEv>:
#include "../h/abi_codes.h"
#include "../h/_thread.hpp"

//ovo nzm kako tacno treba da izgleda (Andrijana ima dodatno jos jednu liniju koda izmedju)
void Riscv::popSppSpie()
{
    80002364:	ff010113          	addi	sp,sp,-16
    80002368:	00813423          	sd	s0,8(sp)
    8000236c:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80002370:	14109073          	csrw	sepc,ra
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002374:	02000793          	li	a5,32
    80002378:	1007a073          	csrs	sstatus,a5
    //ms_sstatus(SSTATUS_SPP); //???
    ms_sstatus(SSTATUS_SPIE);
    __asm__ volatile("sret");
    8000237c:	10200073          	sret
}
    80002380:	00813403          	ld	s0,8(sp)
    80002384:	01010113          	addi	sp,sp,16
    80002388:	00008067          	ret

000000008000238c <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap()
{
    8000238c:	f6010113          	addi	sp,sp,-160
    80002390:	08113c23          	sd	ra,152(sp)
    80002394:	08813823          	sd	s0,144(sp)
    80002398:	08913423          	sd	s1,136(sp)
    8000239c:	09213023          	sd	s2,128(sp)
    800023a0:	07313c23          	sd	s3,120(sp)
    800023a4:	07413823          	sd	s4,112(sp)
    800023a8:	0a010413          	addi	s0,sp,160
    using Body = void (*)(void*);
    //uzimanje prosledjenih argumenata iz registara da se ne bi izmenili
    uint64 args[5];
    __asm__ volatile ("mv %0, a0" : "=r" (args[0]));
    800023ac:	00050793          	mv	a5,a0
    800023b0:	faf43423          	sd	a5,-88(s0)
    __asm__ volatile ("mv %0, a1" : "=r" (args[1]));
    800023b4:	00058793          	mv	a5,a1
    800023b8:	faf43823          	sd	a5,-80(s0)
    __asm__ volatile ("mv %0, a2" : "=r" (args[2]));
    800023bc:	00060793          	mv	a5,a2
    800023c0:	faf43c23          	sd	a5,-72(s0)
    __asm__ volatile ("mv %0, a3" : "=r" (args[3]));
    800023c4:	00068793          	mv	a5,a3
    800023c8:	fcf43023          	sd	a5,-64(s0)
    __asm__ volatile ("mv %0, a4" : "=r" (args[4]));
    800023cc:	00070793          	mv	a5,a4
    800023d0:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800023d4:	142027f3          	csrr	a5,scause
    800023d8:	f6f43823          	sd	a5,-144(s0)
    return scause;
    800023dc:	f7043703          	ld	a4,-144(s0)

    uint64 scause = r_scause();
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)   //ECALL_USER || ECALL_SUPER
    800023e0:	ff870693          	addi	a3,a4,-8
    800023e4:	00100793          	li	a5,1
    800023e8:	0cd7f463          	bgeu	a5,a3,800024b0 <_ZN5Riscv20handleSupervisorTrapEv+0x124>
        }

        w_sstatus(sstatus);
        w_sepc(sepc);
    }
    else if (scause == 0x8000000000000001UL)    //software
    800023ec:	fff00793          	li	a5,-1
    800023f0:	03f79793          	slli	a5,a5,0x3f
    800023f4:	00178793          	addi	a5,a5,1
    800023f8:	1ef70663          	beq	a4,a5,800025e4 <_ZN5Riscv20handleSupervisorTrapEv+0x258>
//            TCB::dispatch();
//            w_sstatus(sstatus);
//            w_sepc(sepc);
//        }
    }
    else if (scause == 0x8000000000000009UL) //hardware
    800023fc:	fff00793          	li	a5,-1
    80002400:	03f79793          	slli	a5,a5,0x3f
    80002404:	00978793          	addi	a5,a5,9
    80002408:	1ef70463          	beq	a4,a5,800025f0 <_ZN5Riscv20handleSupervisorTrapEv+0x264>
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    8000240c:	142027f3          	csrr	a5,scause
    80002410:	faf43023          	sd	a5,-96(s0)
    return scause;
    80002414:	fa043a03          	ld	s4,-96(s0)
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80002418:	143027f3          	csrr	a5,stval
    8000241c:	f8f43c23          	sd	a5,-104(s0)
    return stval;
    80002420:	f9843983          	ld	s3,-104(s0)
    __asm__ volatile ("csrr %[stvec], stvec" : [stvec] "=r"(stvec));
    80002424:	105027f3          	csrr	a5,stvec
    80002428:	f8f43823          	sd	a5,-112(s0)
    return stvec;
    8000242c:	f9043903          	ld	s2,-112(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002430:	141027f3          	csrr	a5,sepc
    80002434:	f8f43423          	sd	a5,-120(s0)
    return sepc;
    80002438:	f8843483          	ld	s1,-120(s0)
        uint64 scause = r_scause();
        uint64 stval = r_stval();
        uint64 stvec = r_stvec();
        uint64 sepc = r_sepc();

        printString("\n Scause: ");
    8000243c:	00003517          	auipc	a0,0x3
    80002440:	d3450513          	addi	a0,a0,-716 # 80005170 <CONSOLE_STATUS+0x160>
    80002444:	00000097          	auipc	ra,0x0
    80002448:	604080e7          	jalr	1540(ra) # 80002a48 <_Z11printStringPKc>
        printInt(scause);
    8000244c:	000a0513          	mv	a0,s4
    80002450:	00000097          	auipc	ra,0x0
    80002454:	668080e7          	jalr	1640(ra) # 80002ab8 <_Z8printIntm>

        printString("\n Stval: ");
    80002458:	00003517          	auipc	a0,0x3
    8000245c:	d2850513          	addi	a0,a0,-728 # 80005180 <CONSOLE_STATUS+0x170>
    80002460:	00000097          	auipc	ra,0x0
    80002464:	5e8080e7          	jalr	1512(ra) # 80002a48 <_Z11printStringPKc>
        printInt(stval);
    80002468:	00098513          	mv	a0,s3
    8000246c:	00000097          	auipc	ra,0x0
    80002470:	64c080e7          	jalr	1612(ra) # 80002ab8 <_Z8printIntm>

        printString("\n Stvec: ");
    80002474:	00003517          	auipc	a0,0x3
    80002478:	d1c50513          	addi	a0,a0,-740 # 80005190 <CONSOLE_STATUS+0x180>
    8000247c:	00000097          	auipc	ra,0x0
    80002480:	5cc080e7          	jalr	1484(ra) # 80002a48 <_Z11printStringPKc>
        printInt(stvec);
    80002484:	00090513          	mv	a0,s2
    80002488:	00000097          	auipc	ra,0x0
    8000248c:	630080e7          	jalr	1584(ra) # 80002ab8 <_Z8printIntm>

        printString("\n Sepc: ");
    80002490:	00003517          	auipc	a0,0x3
    80002494:	d1050513          	addi	a0,a0,-752 # 800051a0 <CONSOLE_STATUS+0x190>
    80002498:	00000097          	auipc	ra,0x0
    8000249c:	5b0080e7          	jalr	1456(ra) # 80002a48 <_Z11printStringPKc>
        printInt(sepc);
    800024a0:	00048513          	mv	a0,s1
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	614080e7          	jalr	1556(ra) # 80002ab8 <_Z8printIntm>
    }
    800024ac:	0740006f          	j	80002520 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800024b0:	141027f3          	csrr	a5,sepc
    800024b4:	f8f43023          	sd	a5,-128(s0)
    return sepc;
    800024b8:	f8043783          	ld	a5,-128(s0)
        uint64 volatile sepc = r_sepc() + 4;
    800024bc:	00478793          	addi	a5,a5,4
    800024c0:	f6f43023          	sd	a5,-160(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800024c4:	100027f3          	csrr	a5,sstatus
    800024c8:	f6f43c23          	sd	a5,-136(s0)
    return sstatus;
    800024cc:	f7843783          	ld	a5,-136(s0)
        uint64 volatile sstatus = r_sstatus();
    800024d0:	f6f43423          	sd	a5,-152(s0)
        switch(args[0]){
    800024d4:	fa843783          	ld	a5,-88(s0)
    800024d8:	01300713          	li	a4,19
    800024dc:	02f76a63          	bltu	a4,a5,80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
    800024e0:	00279793          	slli	a5,a5,0x2
    800024e4:	00003717          	auipc	a4,0x3
    800024e8:	cc870713          	addi	a4,a4,-824 # 800051ac <CONSOLE_STATUS+0x19c>
    800024ec:	00e787b3          	add	a5,a5,a4
    800024f0:	0007a783          	lw	a5,0(a5)
    800024f4:	00e787b3          	add	a5,a5,a4
    800024f8:	00078067          	jr	a5
                value = (uint64)MemoryAllocator::mem_alloc(args[1]*MEM_BLOCK_SIZE);
    800024fc:	fb043503          	ld	a0,-80(s0)
    80002500:	00651513          	slli	a0,a0,0x6
    80002504:	00000097          	auipc	ra,0x0
    80002508:	35c080e7          	jalr	860(ra) # 80002860 <_ZN15MemoryAllocator9mem_allocEm>
                __asm__ volatile ("sd a0, 10*8(fp)");
    8000250c:	04a43823          	sd	a0,80(s0)
        w_sstatus(sstatus);
    80002510:	f6843783          	ld	a5,-152(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002514:	10079073          	csrw	sstatus,a5
        w_sepc(sepc);
    80002518:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000251c:	14179073          	csrw	sepc,a5
    80002520:	09813083          	ld	ra,152(sp)
    80002524:	09013403          	ld	s0,144(sp)
    80002528:	08813483          	ld	s1,136(sp)
    8000252c:	08013903          	ld	s2,128(sp)
    80002530:	07813983          	ld	s3,120(sp)
    80002534:	07013a03          	ld	s4,112(sp)
    80002538:	0a010113          	addi	sp,sp,160
    8000253c:	00008067          	ret
                value = (uint64)MemoryAllocator::mem_free((void*)args[1]);
    80002540:	fb043503          	ld	a0,-80(s0)
    80002544:	00000097          	auipc	ra,0x0
    80002548:	47c080e7          	jalr	1148(ra) # 800029c0 <_ZN15MemoryAllocator8mem_freeEPv>
                __asm__ volatile ("mv a0, %0"::"r"(value));
    8000254c:	00050513          	mv	a0,a0
                break;
    80002550:	fc1ff06f          	j	80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
                handle = (thread_t*)args[1];
    80002554:	fb043483          	ld	s1,-80(s0)
                *handle = _thread::createThread(body, arg, stack);
    80002558:	fc843603          	ld	a2,-56(s0)
    8000255c:	fc043583          	ld	a1,-64(s0)
    80002560:	fb843503          	ld	a0,-72(s0)
    80002564:	fffff097          	auipc	ra,0xfffff
    80002568:	e70080e7          	jalr	-400(ra) # 800013d4 <_ZN7_thread12createThreadEPFvPvES0_Pm>
    8000256c:	00a4b023          	sd	a0,0(s1)
                value = (uint64)((*handle)->start());
    80002570:	fffff097          	auipc	ra,0xfffff
    80002574:	f7c080e7          	jalr	-132(ra) # 800014ec <_ZN7_thread5startEv>
                __asm__ volatile ("mv a0, %0"::"r"(value));
    80002578:	00050513          	mv	a0,a0
                break;
    8000257c:	f95ff06f          	j	80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
                handle = (thread_t*)args[1];
    80002580:	fb043483          	ld	s1,-80(s0)
                *handle = _thread::createThreadSecondApi(body, arg,stack); //ovo je dodato
    80002584:	fc843603          	ld	a2,-56(s0)
    80002588:	fc043583          	ld	a1,-64(s0)
    8000258c:	fb843503          	ld	a0,-72(s0)
    80002590:	fffff097          	auipc	ra,0xfffff
    80002594:	ed0080e7          	jalr	-304(ra) # 80001460 <_ZN7_thread21createThreadSecondApiEPFvPvES0_Pm>
    80002598:	00a4b023          	sd	a0,0(s1)
                if (*handle == nullptr){
    8000259c:	00050863          	beqz	a0,800025ac <_ZN5Riscv20handleSupervisorTrapEv+0x220>
                    value = 0;
    800025a0:	00000793          	li	a5,0
                __asm__ volatile ("mv a0, %0"::"r"(value));
    800025a4:	00078513          	mv	a0,a5
                break;
    800025a8:	f69ff06f          	j	80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
                    value = -1;
    800025ac:	fff00793          	li	a5,-1
    800025b0:	ff5ff06f          	j	800025a4 <_ZN5Riscv20handleSupervisorTrapEv+0x218>
                value = (uint64)(handle2->start());
    800025b4:	fb043503          	ld	a0,-80(s0)
    800025b8:	fffff097          	auipc	ra,0xfffff
    800025bc:	f34080e7          	jalr	-204(ra) # 800014ec <_ZN7_thread5startEv>
                __asm__ volatile ("mv a0, %0"::"r"(value));
    800025c0:	00050513          	mv	a0,a0
                break;
    800025c4:	f4dff06f          	j	80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
                value = (uint64)_thread::exit();
    800025c8:	fffff097          	auipc	ra,0xfffff
    800025cc:	034080e7          	jalr	52(ra) # 800015fc <_ZN7_thread4exitEv>
                __asm__ volatile ("mv a0, %0"::"r"(value));
    800025d0:	00050513          	mv	a0,a0
                break;
    800025d4:	f3dff06f          	j	80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
                _thread::dispatch();
    800025d8:	fffff097          	auipc	ra,0xfffff
    800025dc:	f54080e7          	jalr	-172(ra) # 8000152c <_ZN7_thread8dispatchEv>
    800025e0:	f31ff06f          	j	80002510 <_ZN5Riscv20handleSupervisorTrapEv+0x184>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800025e4:	00200793          	li	a5,2
    800025e8:	1447b073          	csrc	sip,a5
}
    800025ec:	f35ff06f          	j	80002520 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
        console_handler();
    800025f0:	00002097          	auipc	ra,0x2
    800025f4:	6c0080e7          	jalr	1728(ra) # 80004cb0 <console_handler>
    800025f8:	f29ff06f          	j	80002520 <_ZN5Riscv20handleSupervisorTrapEv+0x194>

00000000800025fc <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
}
    800025fc:	ff010113          	addi	sp,sp,-16
    80002600:	00813423          	sd	s0,8(sp)
    80002604:	01010413          	addi	s0,sp,16
    80002608:	00100793          	li	a5,1
    8000260c:	00f50863          	beq	a0,a5,8000261c <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002610:	00813403          	ld	s0,8(sp)
    80002614:	01010113          	addi	sp,sp,16
    80002618:	00008067          	ret
    8000261c:	000107b7          	lui	a5,0x10
    80002620:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002624:	fef596e3          	bne	a1,a5,80002610 <_Z41__static_initialization_and_destruction_0ii+0x14>

    Elem *head, *tail;

public:

    List() : head(0), tail(0) {};   //???
    80002628:	00004797          	auipc	a5,0x4
    8000262c:	af078793          	addi	a5,a5,-1296 # 80006118 <_ZN9Scheduler16readyThreadQueueE>
    80002630:	0007b023          	sd	zero,0(a5)
    80002634:	0007b423          	sd	zero,8(a5)
    80002638:	fd9ff06f          	j	80002610 <_Z41__static_initialization_and_destruction_0ii+0x14>

000000008000263c <_ZN9Scheduler3getEv>:
{
    8000263c:	fe010113          	addi	sp,sp,-32
    80002640:	00113c23          	sd	ra,24(sp)
    80002644:	00813823          	sd	s0,16(sp)
    80002648:	00913423          	sd	s1,8(sp)
    8000264c:	02010413          	addi	s0,sp,32
//    }

    //ostavljeno originalno - kod andrijane prepravljeno
    T *removeFirst()
    {
        if (!head) { return 0; }
    80002650:	00004517          	auipc	a0,0x4
    80002654:	ac853503          	ld	a0,-1336(a0) # 80006118 <_ZN9Scheduler16readyThreadQueueE>
    80002658:	04050263          	beqz	a0,8000269c <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    8000265c:	00853783          	ld	a5,8(a0)
    80002660:	00004717          	auipc	a4,0x4
    80002664:	aaf73c23          	sd	a5,-1352(a4) # 80006118 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80002668:	02078463          	beqz	a5,80002690 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    8000266c:	00053483          	ld	s1,0(a0)
        void operator delete(void *ptr) { __mem_free(ptr); }
    80002670:	00002097          	auipc	ra,0x2
    80002674:	6ec080e7          	jalr	1772(ra) # 80004d5c <__mem_free>
}
    80002678:	00048513          	mv	a0,s1
    8000267c:	01813083          	ld	ra,24(sp)
    80002680:	01013403          	ld	s0,16(sp)
    80002684:	00813483          	ld	s1,8(sp)
    80002688:	02010113          	addi	sp,sp,32
    8000268c:	00008067          	ret
        if (!head) { tail = 0; }
    80002690:	00004797          	auipc	a5,0x4
    80002694:	a807b823          	sd	zero,-1392(a5) # 80006120 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002698:	fd5ff06f          	j	8000266c <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    8000269c:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    800026a0:	fd9ff06f          	j	80002678 <_ZN9Scheduler3getEv+0x3c>

00000000800026a4 <_ZN9Scheduler3putEP7_thread>:
{
    800026a4:	fe010113          	addi	sp,sp,-32
    800026a8:	00113c23          	sd	ra,24(sp)
    800026ac:	00813823          	sd	s0,16(sp)
    800026b0:	00913423          	sd	s1,8(sp)
    800026b4:	02010413          	addi	s0,sp,32
    800026b8:	00050493          	mv	s1,a0
        void *operator new(size_t size) { return __mem_alloc(size); }
    800026bc:	01000513          	li	a0,16
    800026c0:	00002097          	auipc	ra,0x2
    800026c4:	768080e7          	jalr	1896(ra) # 80004e28 <__mem_alloc>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800026c8:	00953023          	sd	s1,0(a0)
    800026cc:	00053423          	sd	zero,8(a0)
        if (tail)
    800026d0:	00004797          	auipc	a5,0x4
    800026d4:	a507b783          	ld	a5,-1456(a5) # 80006120 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800026d8:	02078263          	beqz	a5,800026fc <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800026dc:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800026e0:	00004797          	auipc	a5,0x4
    800026e4:	a4a7b023          	sd	a0,-1472(a5) # 80006120 <_ZN9Scheduler16readyThreadQueueE+0x8>
}
    800026e8:	01813083          	ld	ra,24(sp)
    800026ec:	01013403          	ld	s0,16(sp)
    800026f0:	00813483          	ld	s1,8(sp)
    800026f4:	02010113          	addi	sp,sp,32
    800026f8:	00008067          	ret
            head = tail = elem;
    800026fc:	00004797          	auipc	a5,0x4
    80002700:	a1c78793          	addi	a5,a5,-1508 # 80006118 <_ZN9Scheduler16readyThreadQueueE>
    80002704:	00a7b423          	sd	a0,8(a5)
    80002708:	00a7b023          	sd	a0,0(a5)
    8000270c:	fddff06f          	j	800026e8 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080002710 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80002710:	ff010113          	addi	sp,sp,-16
    80002714:	00113423          	sd	ra,8(sp)
    80002718:	00813023          	sd	s0,0(sp)
    8000271c:	01010413          	addi	s0,sp,16
    80002720:	000105b7          	lui	a1,0x10
    80002724:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002728:	00100513          	li	a0,1
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	ed0080e7          	jalr	-304(ra) # 800025fc <_Z41__static_initialization_and_destruction_0ii>
    80002734:	00813083          	ld	ra,8(sp)
    80002738:	00013403          	ld	s0,0(sp)
    8000273c:	01010113          	addi	sp,sp,16
    80002740:	00008067          	ret

0000000080002744 <_ZN15MemoryAllocator4initEv>:
#include "../h/MemoryAllocator.h"

Segment *MemoryAllocator::freeSegs = nullptr;
Segment *MemoryAllocator::takenSegs = nullptr;

void MemoryAllocator::init() {
    80002744:	ff010113          	addi	sp,sp,-16
    80002748:	00813423          	sd	s0,8(sp)
    8000274c:	01010413          	addi	s0,sp,16
    freeSegs = (Segment*)HEAP_START_ADDR;
    80002750:	00004797          	auipc	a5,0x4
    80002754:	9387b783          	ld	a5,-1736(a5) # 80006088 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002758:	0007b783          	ld	a5,0(a5)
    8000275c:	00004717          	auipc	a4,0x4
    80002760:	9cf73623          	sd	a5,-1588(a4) # 80006128 <_ZN15MemoryAllocator8freeSegsE>
    freeSegs->prev = freeSegs->next = nullptr;
    80002764:	0007b423          	sd	zero,8(a5)
    80002768:	0007b823          	sd	zero,16(a5)
    //mora da se alocira i prostor za header
    freeSegs->size = (size_t)((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR); //ovde bilo MEM_BLOCK_SIZE
    8000276c:	00004717          	auipc	a4,0x4
    80002770:	94473703          	ld	a4,-1724(a4) # 800060b0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002774:	00073703          	ld	a4,0(a4)
    80002778:	40f70733          	sub	a4,a4,a5
    8000277c:	00e7b023          	sd	a4,0(a5)
    //takenSegs ostaje nullptr jer inicijalno nista nije zauzeto
}
    80002780:	00813403          	ld	s0,8(sp)
    80002784:	01010113          	addi	sp,sp,16
    80002788:	00008067          	ret

000000008000278c <_ZN15MemoryAllocator6insertEPP7SegmentS1_>:
    return 0;
}

//trebalo bi da izmenis ovu metodu tako da nema slicnosti
void MemoryAllocator::insert(Segment **head_ptr, Segment *node)
{
    8000278c:	ff010113          	addi	sp,sp,-16
    80002790:	00813423          	sd	s0,8(sp)
    80002794:	01010413          	addi	s0,sp,16
    // ako je node=NULL, odmah se vrati
    if (!node) return;
    80002798:	02058e63          	beqz	a1,800027d4 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x48>

    // ako je head=NULL (odnosno ako nije bilo čvorova u listi do sad), head postaje node
    if (!(*head_ptr)) {
    8000279c:	00053703          	ld	a4,0(a0)
    800027a0:	02070063          	beqz	a4,800027c0 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x34>
        return;
    }

    // ako node treba da stoji ispred head-a, preveži ih i node postaje head
    Segment *head = *head_ptr;
    if (node < head) {
    800027a4:	02e5e263          	bltu	a1,a4,800027c8 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x3c>
        return;
    }

    // ako node treba da stoji negde u sred liste:
    Segment *prev = head;
    for (Segment *curr = head->next; curr; curr = curr->next) {
    800027a8:	00873783          	ld	a5,8(a4)
    800027ac:	04078463          	beqz	a5,800027f4 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x68>
        if (node < curr) {
    800027b0:	02f5e863          	bltu	a1,a5,800027e0 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x54>

            curr->prev = node;
            node->next = curr;
            return;
        }
        prev = curr;
    800027b4:	00078713          	mv	a4,a5
    for (Segment *curr = head->next; curr; curr = curr->next) {
    800027b8:	0087b783          	ld	a5,8(a5)
    800027bc:	ff1ff06f          	j	800027ac <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x20>
        *head_ptr = node;
    800027c0:	00b53023          	sd	a1,0(a0)
        return;
    800027c4:	0100006f          	j	800027d4 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x48>
        node->next = head;
    800027c8:	00e5b423          	sd	a4,8(a1)
        head->prev = node;
    800027cc:	00b73823          	sd	a1,16(a4)
        *head_ptr = node;
    800027d0:	00b53023          	sd	a1,0(a0)
    }

    // ako node treba da stoji na kraju liste:
    prev->next = node;
    node->prev = prev;
}
    800027d4:	00813403          	ld	s0,8(sp)
    800027d8:	01010113          	addi	sp,sp,16
    800027dc:	00008067          	ret
            prev->next = node;
    800027e0:	00b73423          	sd	a1,8(a4)
            node->prev = prev;
    800027e4:	00e5b823          	sd	a4,16(a1)
            curr->prev = node;
    800027e8:	00b7b823          	sd	a1,16(a5)
            node->next = curr;
    800027ec:	00f5b423          	sd	a5,8(a1)
            return;
    800027f0:	fe5ff06f          	j	800027d4 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x48>
    prev->next = node;
    800027f4:	00b73423          	sd	a1,8(a4)
    node->prev = prev;
    800027f8:	00e5b823          	sd	a4,16(a1)
    800027fc:	fd9ff06f          	j	800027d4 <_ZN15MemoryAllocator6insertEPP7SegmentS1_+0x48>

0000000080002800 <_ZN15MemoryAllocator6removeEPP7SegmentS1_>:

//trebalo bi da izmenis ovu metodu tako da nema slicnosti
void MemoryAllocator::remove(Segment **head_ptr, Segment *node)
{
    80002800:	ff010113          	addi	sp,sp,-16
    80002804:	00813423          	sd	s0,8(sp)
    80002808:	01010413          	addi	s0,sp,16
    if (!head_ptr || !node) // ako ne postoji lista u pitanju ili ako ne postoji node u pitanju
    8000280c:	02050663          	beqz	a0,80002838 <_ZN15MemoryAllocator6removeEPP7SegmentS1_+0x38>
    80002810:	02058463          	beqz	a1,80002838 <_ZN15MemoryAllocator6removeEPP7SegmentS1_+0x38>
        return;

    Segment *head = *head_ptr;
    80002814:	00053783          	ld	a5,0(a0)
    if (head == node) {     // ako je node koji se briše početni u listi, njegov sledbenik postaje početni
    80002818:	02f58663          	beq	a1,a5,80002844 <_ZN15MemoryAllocator6removeEPP7SegmentS1_+0x44>
        return;
    }



        Segment *prev = node->prev;
    8000281c:	0105b703          	ld	a4,16(a1)
        Segment *next = node->next;
    80002820:	0085b783          	ld	a5,8(a1)

        // ako je na bilo kom drugom mestu u listi, samo preveži članove
        prev->next = next;  //ovde zabode
    80002824:	00f73423          	sd	a5,8(a4)
        if (next) {
    80002828:	00078463          	beqz	a5,80002830 <_ZN15MemoryAllocator6removeEPP7SegmentS1_+0x30>
            next->prev = prev;
    8000282c:	00e7b823          	sd	a4,16(a5)
        }

        // resetovanje pointera
        node->next = node->prev = nullptr;
    80002830:	0005b823          	sd	zero,16(a1)
    80002834:	0005b423          	sd	zero,8(a1)
}
    80002838:	00813403          	ld	s0,8(sp)
    8000283c:	01010113          	addi	sp,sp,16
    80002840:	00008067          	ret
        *head_ptr = head->next;
    80002844:	0087b783          	ld	a5,8(a5)
    80002848:	00f53023          	sd	a5,0(a0)
        if (*head_ptr) {
    8000284c:	00078463          	beqz	a5,80002854 <_ZN15MemoryAllocator6removeEPP7SegmentS1_+0x54>
            (*head_ptr)->prev = nullptr;
    80002850:	0007b823          	sd	zero,16(a5)
        node->next = node->prev = nullptr;
    80002854:	0005b823          	sd	zero,16(a1)
    80002858:	0005b423          	sd	zero,8(a1)
        return;
    8000285c:	fddff06f          	j	80002838 <_ZN15MemoryAllocator6removeEPP7SegmentS1_+0x38>

0000000080002860 <_ZN15MemoryAllocator9mem_allocEm>:
void *MemoryAllocator::mem_alloc(size_t size) {
    80002860:	fd010113          	addi	sp,sp,-48
    80002864:	02113423          	sd	ra,40(sp)
    80002868:	02813023          	sd	s0,32(sp)
    8000286c:	00913c23          	sd	s1,24(sp)
    80002870:	01213823          	sd	s2,16(sp)
    80002874:	01313423          	sd	s3,8(sp)
    80002878:	03010413          	addi	s0,sp,48
    size_t sizeToAllocate = size+sizeof(Segment);
    8000287c:	01850493          	addi	s1,a0,24
    sizeToAllocate = (sizeToAllocate % MEM_BLOCK_SIZE == 0) ?
    80002880:	03f4f793          	andi	a5,s1,63
    80002884:	00078863          	beqz	a5,80002894 <_ZN15MemoryAllocator9mem_allocEm+0x34>
         (sizeToAllocate / MEM_BLOCK_SIZE + 1) * MEM_BLOCK_SIZE;
    80002888:	0064d493          	srli	s1,s1,0x6
    8000288c:	00148493          	addi	s1,s1,1
    sizeToAllocate = (sizeToAllocate % MEM_BLOCK_SIZE == 0) ?
    80002890:	00649493          	slli	s1,s1,0x6
    for(Segment* cur = freeSegs; cur; cur=cur->next){
    80002894:	00004917          	auipc	s2,0x4
    80002898:	89493903          	ld	s2,-1900(s2) # 80006128 <_ZN15MemoryAllocator8freeSegsE>
    8000289c:	04090063          	beqz	s2,800028dc <_ZN15MemoryAllocator9mem_allocEm+0x7c>
        if (cur->size-sizeToAllocate <=sizeof(Segment)){
    800028a0:	00093783          	ld	a5,0(s2)
    800028a4:	409787b3          	sub	a5,a5,s1
    800028a8:	01800713          	li	a4,24
    800028ac:	04f76863          	bltu	a4,a5,800028fc <_ZN15MemoryAllocator9mem_allocEm+0x9c>
            remove(&freeSegs, cur);
    800028b0:	00090593          	mv	a1,s2
    800028b4:	00004517          	auipc	a0,0x4
    800028b8:	87450513          	addi	a0,a0,-1932 # 80006128 <_ZN15MemoryAllocator8freeSegsE>
    800028bc:	00000097          	auipc	ra,0x0
    800028c0:	f44080e7          	jalr	-188(ra) # 80002800 <_ZN15MemoryAllocator6removeEPP7SegmentS1_>
            insert(&takenSegs, cur);
    800028c4:	00090593          	mv	a1,s2
    800028c8:	00004517          	auipc	a0,0x4
    800028cc:	86850513          	addi	a0,a0,-1944 # 80006130 <_ZN15MemoryAllocator9takenSegsE>
    800028d0:	00000097          	auipc	ra,0x0
    800028d4:	ebc080e7          	jalr	-324(ra) # 8000278c <_ZN15MemoryAllocator6insertEPP7SegmentS1_>
            return (void*)((char*)(cur) + sizeof(Segment));
    800028d8:	01890913          	addi	s2,s2,24
}
    800028dc:	00090513          	mv	a0,s2
    800028e0:	02813083          	ld	ra,40(sp)
    800028e4:	02013403          	ld	s0,32(sp)
    800028e8:	01813483          	ld	s1,24(sp)
    800028ec:	01013903          	ld	s2,16(sp)
    800028f0:	00813983          	ld	s3,8(sp)
    800028f4:	03010113          	addi	sp,sp,48
    800028f8:	00008067          	ret
            remove(&freeSegs, cur);
    800028fc:	00004997          	auipc	s3,0x4
    80002900:	82c98993          	addi	s3,s3,-2004 # 80006128 <_ZN15MemoryAllocator8freeSegsE>
    80002904:	00090593          	mv	a1,s2
    80002908:	00098513          	mv	a0,s3
    8000290c:	00000097          	auipc	ra,0x0
    80002910:	ef4080e7          	jalr	-268(ra) # 80002800 <_ZN15MemoryAllocator6removeEPP7SegmentS1_>
            Segment *newSeg = (Segment*)((char*)cur + sizeToAllocate);
    80002914:	009905b3          	add	a1,s2,s1
            newSeg->size = (cur->size - sizeToAllocate);
    80002918:	00093783          	ld	a5,0(s2)
    8000291c:	409787b3          	sub	a5,a5,s1
    80002920:	00f5b023          	sd	a5,0(a1)
            newSeg->next = newSeg->prev = nullptr;
    80002924:	0005b823          	sd	zero,16(a1)
    80002928:	0005b423          	sd	zero,8(a1)
            insert(&freeSegs, newSeg);
    8000292c:	00098513          	mv	a0,s3
    80002930:	00000097          	auipc	ra,0x0
    80002934:	e5c080e7          	jalr	-420(ra) # 8000278c <_ZN15MemoryAllocator6insertEPP7SegmentS1_>
            cur->size = sizeToAllocate;
    80002938:	00993023          	sd	s1,0(s2)
            insert(&takenSegs, cur);
    8000293c:	00090593          	mv	a1,s2
    80002940:	00003517          	auipc	a0,0x3
    80002944:	7f050513          	addi	a0,a0,2032 # 80006130 <_ZN15MemoryAllocator9takenSegsE>
    80002948:	00000097          	auipc	ra,0x0
    8000294c:	e44080e7          	jalr	-444(ra) # 8000278c <_ZN15MemoryAllocator6insertEPP7SegmentS1_>
            return (void*)((char*)(cur) + sizeof(Segment));
    80002950:	01890913          	addi	s2,s2,24
    80002954:	f89ff06f          	j	800028dc <_ZN15MemoryAllocator9mem_allocEm+0x7c>

0000000080002958 <_ZN15MemoryAllocator9tryToJoinEP7Segment>:

//iz zbirke:
//try to join cur with the cur->next free segment
int MemoryAllocator::tryToJoin (Segment* cur){
    80002958:	ff010113          	addi	sp,sp,-16
    8000295c:	00813423          	sd	s0,8(sp)
    80002960:	01010413          	addi	s0,sp,16
    if (!cur) return 0;
    80002964:	04050663          	beqz	a0,800029b0 <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x58>
    if (cur->next && (char*)cur+cur->size == (char*)(cur->next)){
    80002968:	00853783          	ld	a5,8(a0)
    8000296c:	04078663          	beqz	a5,800029b8 <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x60>
    80002970:	00053703          	ld	a4,0(a0)
    80002974:	00e506b3          	add	a3,a0,a4
    80002978:	00d78a63          	beq	a5,a3,8000298c <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x34>
        cur->size += cur->next->size;
        cur->next = cur->next->next;
        if (cur->next) cur->next->prev=cur;
        return 1;
    }else
        return 0;
    8000297c:	00000513          	li	a0,0
}
    80002980:	00813403          	ld	s0,8(sp)
    80002984:	01010113          	addi	sp,sp,16
    80002988:	00008067          	ret
        cur->size += cur->next->size;
    8000298c:	0007b683          	ld	a3,0(a5)
    80002990:	00d70733          	add	a4,a4,a3
    80002994:	00e53023          	sd	a4,0(a0)
        cur->next = cur->next->next;
    80002998:	0087b783          	ld	a5,8(a5)
    8000299c:	00f53423          	sd	a5,8(a0)
        if (cur->next) cur->next->prev=cur;
    800029a0:	00078463          	beqz	a5,800029a8 <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x50>
    800029a4:	00a7b823          	sd	a0,16(a5)
        return 1;
    800029a8:	00100513          	li	a0,1
    800029ac:	fd5ff06f          	j	80002980 <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x28>
    if (!cur) return 0;
    800029b0:	00000513          	li	a0,0
    800029b4:	fcdff06f          	j	80002980 <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x28>
        return 0;
    800029b8:	00000513          	li	a0,0
    800029bc:	fc5ff06f          	j	80002980 <_ZN15MemoryAllocator9tryToJoinEP7Segment+0x28>

00000000800029c0 <_ZN15MemoryAllocator8mem_freeEPv>:
    if (!ptr) return -1;
    800029c0:	08050063          	beqz	a0,80002a40 <_ZN15MemoryAllocator8mem_freeEPv+0x80>
int MemoryAllocator::mem_free(void *ptr){
    800029c4:	fe010113          	addi	sp,sp,-32
    800029c8:	00113c23          	sd	ra,24(sp)
    800029cc:	00813823          	sd	s0,16(sp)
    800029d0:	00913423          	sd	s1,8(sp)
    800029d4:	01213023          	sd	s2,0(sp)
    800029d8:	02010413          	addi	s0,sp,32
    800029dc:	00050493          	mv	s1,a0
    Segment *s = (Segment*)((char*)ptr - sizeof(Segment));
    800029e0:	fe850913          	addi	s2,a0,-24
    remove(&takenSegs, s);
    800029e4:	00090593          	mv	a1,s2
    800029e8:	00003517          	auipc	a0,0x3
    800029ec:	74850513          	addi	a0,a0,1864 # 80006130 <_ZN15MemoryAllocator9takenSegsE>
    800029f0:	00000097          	auipc	ra,0x0
    800029f4:	e10080e7          	jalr	-496(ra) # 80002800 <_ZN15MemoryAllocator6removeEPP7SegmentS1_>
    insert(&freeSegs, s);
    800029f8:	00090593          	mv	a1,s2
    800029fc:	00003517          	auipc	a0,0x3
    80002a00:	72c50513          	addi	a0,a0,1836 # 80006128 <_ZN15MemoryAllocator8freeSegsE>
    80002a04:	00000097          	auipc	ra,0x0
    80002a08:	d88080e7          	jalr	-632(ra) # 8000278c <_ZN15MemoryAllocator6insertEPP7SegmentS1_>
    tryToJoin(previous);
    80002a0c:	ff84b503          	ld	a0,-8(s1)
    80002a10:	00000097          	auipc	ra,0x0
    80002a14:	f48080e7          	jalr	-184(ra) # 80002958 <_ZN15MemoryAllocator9tryToJoinEP7Segment>
    tryToJoin(s);
    80002a18:	00090513          	mv	a0,s2
    80002a1c:	00000097          	auipc	ra,0x0
    80002a20:	f3c080e7          	jalr	-196(ra) # 80002958 <_ZN15MemoryAllocator9tryToJoinEP7Segment>
    return 0;
    80002a24:	00000513          	li	a0,0
}
    80002a28:	01813083          	ld	ra,24(sp)
    80002a2c:	01013403          	ld	s0,16(sp)
    80002a30:	00813483          	ld	s1,8(sp)
    80002a34:	00013903          	ld	s2,0(sp)
    80002a38:	02010113          	addi	sp,sp,32
    80002a3c:	00008067          	ret
    if (!ptr) return -1;
    80002a40:	fff00513          	li	a0,-1
}
    80002a44:	00008067          	ret

0000000080002a48 <_Z11printStringPKc>:
#include "../h/print.hpp"
#include "../h/riscv.hpp"
#include "../lib/console.h"

void printString(char const *string)
{
    80002a48:	fd010113          	addi	sp,sp,-48
    80002a4c:	02113423          	sd	ra,40(sp)
    80002a50:	02813023          	sd	s0,32(sp)
    80002a54:	00913c23          	sd	s1,24(sp)
    80002a58:	01213823          	sd	s2,16(sp)
    80002a5c:	03010413          	addi	s0,sp,48
    80002a60:	00050493          	mv	s1,a0
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002a64:	100027f3          	csrr	a5,sstatus
    80002a68:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80002a6c:	fd843903          	ld	s2,-40(s0)
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002a70:	00200793          	li	a5,2
    80002a74:	1007b073          	csrc	sstatus,a5
    uint64 sstatus = Riscv::r_sstatus();
    Riscv::mc_sstatus(Riscv::SSTATUS_SIE);
    while (*string != '\0')
    80002a78:	0004c503          	lbu	a0,0(s1)
    80002a7c:	00050a63          	beqz	a0,80002a90 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    80002a80:	00002097          	auipc	ra,0x2
    80002a84:	1bc080e7          	jalr	444(ra) # 80004c3c <__putc>
        string++;
    80002a88:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002a8c:	fedff06f          	j	80002a78 <_Z11printStringPKc+0x30>
    }
    Riscv::ms_sstatus(sstatus & Riscv::SSTATUS_SIE ? Riscv::SSTATUS_SIE : 0);
    80002a90:	0009091b          	sext.w	s2,s2
    80002a94:	00297913          	andi	s2,s2,2
    80002a98:	0009091b          	sext.w	s2,s2
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002a9c:	10092073          	csrs	sstatus,s2
}
    80002aa0:	02813083          	ld	ra,40(sp)
    80002aa4:	02013403          	ld	s0,32(sp)
    80002aa8:	01813483          	ld	s1,24(sp)
    80002aac:	01013903          	ld	s2,16(sp)
    80002ab0:	03010113          	addi	sp,sp,48
    80002ab4:	00008067          	ret

0000000080002ab8 <_Z8printIntm>:

void printInt(uint64 integer)
{
    80002ab8:	fc010113          	addi	sp,sp,-64
    80002abc:	02113c23          	sd	ra,56(sp)
    80002ac0:	02813823          	sd	s0,48(sp)
    80002ac4:	02913423          	sd	s1,40(sp)
    80002ac8:	03213023          	sd	s2,32(sp)
    80002acc:	04010413          	addi	s0,sp,64
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002ad0:	100027f3          	csrr	a5,sstatus
    80002ad4:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80002ad8:	fc843903          	ld	s2,-56(s0)
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002adc:	00200793          	li	a5,2
    80002ae0:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80002ae4:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80002ae8:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80002aec:	00a00613          	li	a2,10
    80002af0:	02c5773b          	remuw	a4,a0,a2
    80002af4:	02071693          	slli	a3,a4,0x20
    80002af8:	0206d693          	srli	a3,a3,0x20
    80002afc:	00002717          	auipc	a4,0x2
    80002b00:	70470713          	addi	a4,a4,1796 # 80005200 <_ZZ8printIntmE6digits>
    80002b04:	00d70733          	add	a4,a4,a3
    80002b08:	00074703          	lbu	a4,0(a4)
    80002b0c:	fe040693          	addi	a3,s0,-32
    80002b10:	009687b3          	add	a5,a3,s1
    80002b14:	0014849b          	addiw	s1,s1,1
    80002b18:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80002b1c:	0005071b          	sext.w	a4,a0
    80002b20:	02c5553b          	divuw	a0,a0,a2
    80002b24:	00900793          	li	a5,9
    80002b28:	fce7e2e3          	bltu	a5,a4,80002aec <_Z8printIntm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80002b2c:	fff4849b          	addiw	s1,s1,-1
    80002b30:	0004ce63          	bltz	s1,80002b4c <_Z8printIntm+0x94>
    80002b34:	fe040793          	addi	a5,s0,-32
    80002b38:	009787b3          	add	a5,a5,s1
    80002b3c:	ff07c503          	lbu	a0,-16(a5)
    80002b40:	00002097          	auipc	ra,0x2
    80002b44:	0fc080e7          	jalr	252(ra) # 80004c3c <__putc>
    80002b48:	fe5ff06f          	j	80002b2c <_Z8printIntm+0x74>
    Riscv::ms_sstatus(sstatus & Riscv::SSTATUS_SIE ? Riscv::SSTATUS_SIE : 0);
    80002b4c:	0009091b          	sext.w	s2,s2
    80002b50:	00297913          	andi	s2,s2,2
    80002b54:	0009091b          	sext.w	s2,s2
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002b58:	10092073          	csrs	sstatus,s2
}
    80002b5c:	03813083          	ld	ra,56(sp)
    80002b60:	03013403          	ld	s0,48(sp)
    80002b64:	02813483          	ld	s1,40(sp)
    80002b68:	02013903          	ld	s2,32(sp)
    80002b6c:	04010113          	addi	sp,sp,64
    80002b70:	00008067          	ret

0000000080002b74 <start>:
    80002b74:	ff010113          	addi	sp,sp,-16
    80002b78:	00813423          	sd	s0,8(sp)
    80002b7c:	01010413          	addi	s0,sp,16
    80002b80:	300027f3          	csrr	a5,mstatus
    80002b84:	ffffe737          	lui	a4,0xffffe
    80002b88:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff744f>
    80002b8c:	00e7f7b3          	and	a5,a5,a4
    80002b90:	00001737          	lui	a4,0x1
    80002b94:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002b98:	00e7e7b3          	or	a5,a5,a4
    80002b9c:	30079073          	csrw	mstatus,a5
    80002ba0:	00000797          	auipc	a5,0x0
    80002ba4:	16078793          	addi	a5,a5,352 # 80002d00 <system_main>
    80002ba8:	34179073          	csrw	mepc,a5
    80002bac:	00000793          	li	a5,0
    80002bb0:	18079073          	csrw	satp,a5
    80002bb4:	000107b7          	lui	a5,0x10
    80002bb8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002bbc:	30279073          	csrw	medeleg,a5
    80002bc0:	30379073          	csrw	mideleg,a5
    80002bc4:	104027f3          	csrr	a5,sie
    80002bc8:	2227e793          	ori	a5,a5,546
    80002bcc:	10479073          	csrw	sie,a5
    80002bd0:	fff00793          	li	a5,-1
    80002bd4:	00a7d793          	srli	a5,a5,0xa
    80002bd8:	3b079073          	csrw	pmpaddr0,a5
    80002bdc:	00f00793          	li	a5,15
    80002be0:	3a079073          	csrw	pmpcfg0,a5
    80002be4:	f14027f3          	csrr	a5,mhartid
    80002be8:	0200c737          	lui	a4,0x200c
    80002bec:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002bf0:	0007869b          	sext.w	a3,a5
    80002bf4:	00269713          	slli	a4,a3,0x2
    80002bf8:	000f4637          	lui	a2,0xf4
    80002bfc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002c00:	00d70733          	add	a4,a4,a3
    80002c04:	0037979b          	slliw	a5,a5,0x3
    80002c08:	020046b7          	lui	a3,0x2004
    80002c0c:	00d787b3          	add	a5,a5,a3
    80002c10:	00c585b3          	add	a1,a1,a2
    80002c14:	00371693          	slli	a3,a4,0x3
    80002c18:	00003717          	auipc	a4,0x3
    80002c1c:	52870713          	addi	a4,a4,1320 # 80006140 <timer_scratch>
    80002c20:	00b7b023          	sd	a1,0(a5)
    80002c24:	00d70733          	add	a4,a4,a3
    80002c28:	00f73c23          	sd	a5,24(a4)
    80002c2c:	02c73023          	sd	a2,32(a4)
    80002c30:	34071073          	csrw	mscratch,a4
    80002c34:	00000797          	auipc	a5,0x0
    80002c38:	6ec78793          	addi	a5,a5,1772 # 80003320 <timervec>
    80002c3c:	30579073          	csrw	mtvec,a5
    80002c40:	300027f3          	csrr	a5,mstatus
    80002c44:	0087e793          	ori	a5,a5,8
    80002c48:	30079073          	csrw	mstatus,a5
    80002c4c:	304027f3          	csrr	a5,mie
    80002c50:	0807e793          	ori	a5,a5,128
    80002c54:	30479073          	csrw	mie,a5
    80002c58:	f14027f3          	csrr	a5,mhartid
    80002c5c:	0007879b          	sext.w	a5,a5
    80002c60:	00078213          	mv	tp,a5
    80002c64:	30200073          	mret
    80002c68:	00813403          	ld	s0,8(sp)
    80002c6c:	01010113          	addi	sp,sp,16
    80002c70:	00008067          	ret

0000000080002c74 <timerinit>:
    80002c74:	ff010113          	addi	sp,sp,-16
    80002c78:	00813423          	sd	s0,8(sp)
    80002c7c:	01010413          	addi	s0,sp,16
    80002c80:	f14027f3          	csrr	a5,mhartid
    80002c84:	0200c737          	lui	a4,0x200c
    80002c88:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002c8c:	0007869b          	sext.w	a3,a5
    80002c90:	00269713          	slli	a4,a3,0x2
    80002c94:	000f4637          	lui	a2,0xf4
    80002c98:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002c9c:	00d70733          	add	a4,a4,a3
    80002ca0:	0037979b          	slliw	a5,a5,0x3
    80002ca4:	020046b7          	lui	a3,0x2004
    80002ca8:	00d787b3          	add	a5,a5,a3
    80002cac:	00c585b3          	add	a1,a1,a2
    80002cb0:	00371693          	slli	a3,a4,0x3
    80002cb4:	00003717          	auipc	a4,0x3
    80002cb8:	48c70713          	addi	a4,a4,1164 # 80006140 <timer_scratch>
    80002cbc:	00b7b023          	sd	a1,0(a5)
    80002cc0:	00d70733          	add	a4,a4,a3
    80002cc4:	00f73c23          	sd	a5,24(a4)
    80002cc8:	02c73023          	sd	a2,32(a4)
    80002ccc:	34071073          	csrw	mscratch,a4
    80002cd0:	00000797          	auipc	a5,0x0
    80002cd4:	65078793          	addi	a5,a5,1616 # 80003320 <timervec>
    80002cd8:	30579073          	csrw	mtvec,a5
    80002cdc:	300027f3          	csrr	a5,mstatus
    80002ce0:	0087e793          	ori	a5,a5,8
    80002ce4:	30079073          	csrw	mstatus,a5
    80002ce8:	304027f3          	csrr	a5,mie
    80002cec:	0807e793          	ori	a5,a5,128
    80002cf0:	30479073          	csrw	mie,a5
    80002cf4:	00813403          	ld	s0,8(sp)
    80002cf8:	01010113          	addi	sp,sp,16
    80002cfc:	00008067          	ret

0000000080002d00 <system_main>:
    80002d00:	fe010113          	addi	sp,sp,-32
    80002d04:	00813823          	sd	s0,16(sp)
    80002d08:	00913423          	sd	s1,8(sp)
    80002d0c:	00113c23          	sd	ra,24(sp)
    80002d10:	02010413          	addi	s0,sp,32
    80002d14:	00000097          	auipc	ra,0x0
    80002d18:	0c4080e7          	jalr	196(ra) # 80002dd8 <cpuid>
    80002d1c:	00003497          	auipc	s1,0x3
    80002d20:	3b448493          	addi	s1,s1,948 # 800060d0 <started>
    80002d24:	02050263          	beqz	a0,80002d48 <system_main+0x48>
    80002d28:	0004a783          	lw	a5,0(s1)
    80002d2c:	0007879b          	sext.w	a5,a5
    80002d30:	fe078ce3          	beqz	a5,80002d28 <system_main+0x28>
    80002d34:	0ff0000f          	fence
    80002d38:	00002517          	auipc	a0,0x2
    80002d3c:	50850513          	addi	a0,a0,1288 # 80005240 <_ZZ8printIntmE6digits+0x40>
    80002d40:	00001097          	auipc	ra,0x1
    80002d44:	a7c080e7          	jalr	-1412(ra) # 800037bc <panic>
    80002d48:	00001097          	auipc	ra,0x1
    80002d4c:	9d0080e7          	jalr	-1584(ra) # 80003718 <consoleinit>
    80002d50:	00001097          	auipc	ra,0x1
    80002d54:	15c080e7          	jalr	348(ra) # 80003eac <printfinit>
    80002d58:	00002517          	auipc	a0,0x2
    80002d5c:	3f050513          	addi	a0,a0,1008 # 80005148 <CONSOLE_STATUS+0x138>
    80002d60:	00001097          	auipc	ra,0x1
    80002d64:	ab8080e7          	jalr	-1352(ra) # 80003818 <__printf>
    80002d68:	00002517          	auipc	a0,0x2
    80002d6c:	4a850513          	addi	a0,a0,1192 # 80005210 <_ZZ8printIntmE6digits+0x10>
    80002d70:	00001097          	auipc	ra,0x1
    80002d74:	aa8080e7          	jalr	-1368(ra) # 80003818 <__printf>
    80002d78:	00002517          	auipc	a0,0x2
    80002d7c:	3d050513          	addi	a0,a0,976 # 80005148 <CONSOLE_STATUS+0x138>
    80002d80:	00001097          	auipc	ra,0x1
    80002d84:	a98080e7          	jalr	-1384(ra) # 80003818 <__printf>
    80002d88:	00001097          	auipc	ra,0x1
    80002d8c:	4b0080e7          	jalr	1200(ra) # 80004238 <kinit>
    80002d90:	00000097          	auipc	ra,0x0
    80002d94:	148080e7          	jalr	328(ra) # 80002ed8 <trapinit>
    80002d98:	00000097          	auipc	ra,0x0
    80002d9c:	16c080e7          	jalr	364(ra) # 80002f04 <trapinithart>
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	5c0080e7          	jalr	1472(ra) # 80003360 <plicinit>
    80002da8:	00000097          	auipc	ra,0x0
    80002dac:	5e0080e7          	jalr	1504(ra) # 80003388 <plicinithart>
    80002db0:	00000097          	auipc	ra,0x0
    80002db4:	078080e7          	jalr	120(ra) # 80002e28 <userinit>
    80002db8:	0ff0000f          	fence
    80002dbc:	00100793          	li	a5,1
    80002dc0:	00002517          	auipc	a0,0x2
    80002dc4:	46850513          	addi	a0,a0,1128 # 80005228 <_ZZ8printIntmE6digits+0x28>
    80002dc8:	00f4a023          	sw	a5,0(s1)
    80002dcc:	00001097          	auipc	ra,0x1
    80002dd0:	a4c080e7          	jalr	-1460(ra) # 80003818 <__printf>
    80002dd4:	0000006f          	j	80002dd4 <system_main+0xd4>

0000000080002dd8 <cpuid>:
    80002dd8:	ff010113          	addi	sp,sp,-16
    80002ddc:	00813423          	sd	s0,8(sp)
    80002de0:	01010413          	addi	s0,sp,16
    80002de4:	00020513          	mv	a0,tp
    80002de8:	00813403          	ld	s0,8(sp)
    80002dec:	0005051b          	sext.w	a0,a0
    80002df0:	01010113          	addi	sp,sp,16
    80002df4:	00008067          	ret

0000000080002df8 <mycpu>:
    80002df8:	ff010113          	addi	sp,sp,-16
    80002dfc:	00813423          	sd	s0,8(sp)
    80002e00:	01010413          	addi	s0,sp,16
    80002e04:	00020793          	mv	a5,tp
    80002e08:	00813403          	ld	s0,8(sp)
    80002e0c:	0007879b          	sext.w	a5,a5
    80002e10:	00779793          	slli	a5,a5,0x7
    80002e14:	00004517          	auipc	a0,0x4
    80002e18:	35c50513          	addi	a0,a0,860 # 80007170 <cpus>
    80002e1c:	00f50533          	add	a0,a0,a5
    80002e20:	01010113          	addi	sp,sp,16
    80002e24:	00008067          	ret

0000000080002e28 <userinit>:
    80002e28:	ff010113          	addi	sp,sp,-16
    80002e2c:	00813423          	sd	s0,8(sp)
    80002e30:	01010413          	addi	s0,sp,16
    80002e34:	00813403          	ld	s0,8(sp)
    80002e38:	01010113          	addi	sp,sp,16
    80002e3c:	fffff317          	auipc	t1,0xfffff
    80002e40:	1bc30067          	jr	444(t1) # 80001ff8 <main>

0000000080002e44 <either_copyout>:
    80002e44:	ff010113          	addi	sp,sp,-16
    80002e48:	00813023          	sd	s0,0(sp)
    80002e4c:	00113423          	sd	ra,8(sp)
    80002e50:	01010413          	addi	s0,sp,16
    80002e54:	02051663          	bnez	a0,80002e80 <either_copyout+0x3c>
    80002e58:	00058513          	mv	a0,a1
    80002e5c:	00060593          	mv	a1,a2
    80002e60:	0006861b          	sext.w	a2,a3
    80002e64:	00002097          	auipc	ra,0x2
    80002e68:	c60080e7          	jalr	-928(ra) # 80004ac4 <__memmove>
    80002e6c:	00813083          	ld	ra,8(sp)
    80002e70:	00013403          	ld	s0,0(sp)
    80002e74:	00000513          	li	a0,0
    80002e78:	01010113          	addi	sp,sp,16
    80002e7c:	00008067          	ret
    80002e80:	00002517          	auipc	a0,0x2
    80002e84:	3e850513          	addi	a0,a0,1000 # 80005268 <_ZZ8printIntmE6digits+0x68>
    80002e88:	00001097          	auipc	ra,0x1
    80002e8c:	934080e7          	jalr	-1740(ra) # 800037bc <panic>

0000000080002e90 <either_copyin>:
    80002e90:	ff010113          	addi	sp,sp,-16
    80002e94:	00813023          	sd	s0,0(sp)
    80002e98:	00113423          	sd	ra,8(sp)
    80002e9c:	01010413          	addi	s0,sp,16
    80002ea0:	02059463          	bnez	a1,80002ec8 <either_copyin+0x38>
    80002ea4:	00060593          	mv	a1,a2
    80002ea8:	0006861b          	sext.w	a2,a3
    80002eac:	00002097          	auipc	ra,0x2
    80002eb0:	c18080e7          	jalr	-1000(ra) # 80004ac4 <__memmove>
    80002eb4:	00813083          	ld	ra,8(sp)
    80002eb8:	00013403          	ld	s0,0(sp)
    80002ebc:	00000513          	li	a0,0
    80002ec0:	01010113          	addi	sp,sp,16
    80002ec4:	00008067          	ret
    80002ec8:	00002517          	auipc	a0,0x2
    80002ecc:	3c850513          	addi	a0,a0,968 # 80005290 <_ZZ8printIntmE6digits+0x90>
    80002ed0:	00001097          	auipc	ra,0x1
    80002ed4:	8ec080e7          	jalr	-1812(ra) # 800037bc <panic>

0000000080002ed8 <trapinit>:
    80002ed8:	ff010113          	addi	sp,sp,-16
    80002edc:	00813423          	sd	s0,8(sp)
    80002ee0:	01010413          	addi	s0,sp,16
    80002ee4:	00813403          	ld	s0,8(sp)
    80002ee8:	00002597          	auipc	a1,0x2
    80002eec:	3d058593          	addi	a1,a1,976 # 800052b8 <_ZZ8printIntmE6digits+0xb8>
    80002ef0:	00004517          	auipc	a0,0x4
    80002ef4:	30050513          	addi	a0,a0,768 # 800071f0 <tickslock>
    80002ef8:	01010113          	addi	sp,sp,16
    80002efc:	00001317          	auipc	t1,0x1
    80002f00:	5cc30067          	jr	1484(t1) # 800044c8 <initlock>

0000000080002f04 <trapinithart>:
    80002f04:	ff010113          	addi	sp,sp,-16
    80002f08:	00813423          	sd	s0,8(sp)
    80002f0c:	01010413          	addi	s0,sp,16
    80002f10:	00000797          	auipc	a5,0x0
    80002f14:	30078793          	addi	a5,a5,768 # 80003210 <kernelvec>
    80002f18:	10579073          	csrw	stvec,a5
    80002f1c:	00813403          	ld	s0,8(sp)
    80002f20:	01010113          	addi	sp,sp,16
    80002f24:	00008067          	ret

0000000080002f28 <usertrap>:
    80002f28:	ff010113          	addi	sp,sp,-16
    80002f2c:	00813423          	sd	s0,8(sp)
    80002f30:	01010413          	addi	s0,sp,16
    80002f34:	00813403          	ld	s0,8(sp)
    80002f38:	01010113          	addi	sp,sp,16
    80002f3c:	00008067          	ret

0000000080002f40 <usertrapret>:
    80002f40:	ff010113          	addi	sp,sp,-16
    80002f44:	00813423          	sd	s0,8(sp)
    80002f48:	01010413          	addi	s0,sp,16
    80002f4c:	00813403          	ld	s0,8(sp)
    80002f50:	01010113          	addi	sp,sp,16
    80002f54:	00008067          	ret

0000000080002f58 <kerneltrap>:
    80002f58:	fe010113          	addi	sp,sp,-32
    80002f5c:	00813823          	sd	s0,16(sp)
    80002f60:	00113c23          	sd	ra,24(sp)
    80002f64:	00913423          	sd	s1,8(sp)
    80002f68:	02010413          	addi	s0,sp,32
    80002f6c:	142025f3          	csrr	a1,scause
    80002f70:	100027f3          	csrr	a5,sstatus
    80002f74:	0027f793          	andi	a5,a5,2
    80002f78:	10079c63          	bnez	a5,80003090 <kerneltrap+0x138>
    80002f7c:	142027f3          	csrr	a5,scause
    80002f80:	0207ce63          	bltz	a5,80002fbc <kerneltrap+0x64>
    80002f84:	00002517          	auipc	a0,0x2
    80002f88:	37c50513          	addi	a0,a0,892 # 80005300 <_ZZ8printIntmE6digits+0x100>
    80002f8c:	00001097          	auipc	ra,0x1
    80002f90:	88c080e7          	jalr	-1908(ra) # 80003818 <__printf>
    80002f94:	141025f3          	csrr	a1,sepc
    80002f98:	14302673          	csrr	a2,stval
    80002f9c:	00002517          	auipc	a0,0x2
    80002fa0:	37450513          	addi	a0,a0,884 # 80005310 <_ZZ8printIntmE6digits+0x110>
    80002fa4:	00001097          	auipc	ra,0x1
    80002fa8:	874080e7          	jalr	-1932(ra) # 80003818 <__printf>
    80002fac:	00002517          	auipc	a0,0x2
    80002fb0:	37c50513          	addi	a0,a0,892 # 80005328 <_ZZ8printIntmE6digits+0x128>
    80002fb4:	00001097          	auipc	ra,0x1
    80002fb8:	808080e7          	jalr	-2040(ra) # 800037bc <panic>
    80002fbc:	0ff7f713          	andi	a4,a5,255
    80002fc0:	00900693          	li	a3,9
    80002fc4:	04d70063          	beq	a4,a3,80003004 <kerneltrap+0xac>
    80002fc8:	fff00713          	li	a4,-1
    80002fcc:	03f71713          	slli	a4,a4,0x3f
    80002fd0:	00170713          	addi	a4,a4,1
    80002fd4:	fae798e3          	bne	a5,a4,80002f84 <kerneltrap+0x2c>
    80002fd8:	00000097          	auipc	ra,0x0
    80002fdc:	e00080e7          	jalr	-512(ra) # 80002dd8 <cpuid>
    80002fe0:	06050663          	beqz	a0,8000304c <kerneltrap+0xf4>
    80002fe4:	144027f3          	csrr	a5,sip
    80002fe8:	ffd7f793          	andi	a5,a5,-3
    80002fec:	14479073          	csrw	sip,a5
    80002ff0:	01813083          	ld	ra,24(sp)
    80002ff4:	01013403          	ld	s0,16(sp)
    80002ff8:	00813483          	ld	s1,8(sp)
    80002ffc:	02010113          	addi	sp,sp,32
    80003000:	00008067          	ret
    80003004:	00000097          	auipc	ra,0x0
    80003008:	3d0080e7          	jalr	976(ra) # 800033d4 <plic_claim>
    8000300c:	00a00793          	li	a5,10
    80003010:	00050493          	mv	s1,a0
    80003014:	06f50863          	beq	a0,a5,80003084 <kerneltrap+0x12c>
    80003018:	fc050ce3          	beqz	a0,80002ff0 <kerneltrap+0x98>
    8000301c:	00050593          	mv	a1,a0
    80003020:	00002517          	auipc	a0,0x2
    80003024:	2c050513          	addi	a0,a0,704 # 800052e0 <_ZZ8printIntmE6digits+0xe0>
    80003028:	00000097          	auipc	ra,0x0
    8000302c:	7f0080e7          	jalr	2032(ra) # 80003818 <__printf>
    80003030:	01013403          	ld	s0,16(sp)
    80003034:	01813083          	ld	ra,24(sp)
    80003038:	00048513          	mv	a0,s1
    8000303c:	00813483          	ld	s1,8(sp)
    80003040:	02010113          	addi	sp,sp,32
    80003044:	00000317          	auipc	t1,0x0
    80003048:	3c830067          	jr	968(t1) # 8000340c <plic_complete>
    8000304c:	00004517          	auipc	a0,0x4
    80003050:	1a450513          	addi	a0,a0,420 # 800071f0 <tickslock>
    80003054:	00001097          	auipc	ra,0x1
    80003058:	498080e7          	jalr	1176(ra) # 800044ec <acquire>
    8000305c:	00003717          	auipc	a4,0x3
    80003060:	07870713          	addi	a4,a4,120 # 800060d4 <ticks>
    80003064:	00072783          	lw	a5,0(a4)
    80003068:	00004517          	auipc	a0,0x4
    8000306c:	18850513          	addi	a0,a0,392 # 800071f0 <tickslock>
    80003070:	0017879b          	addiw	a5,a5,1
    80003074:	00f72023          	sw	a5,0(a4)
    80003078:	00001097          	auipc	ra,0x1
    8000307c:	540080e7          	jalr	1344(ra) # 800045b8 <release>
    80003080:	f65ff06f          	j	80002fe4 <kerneltrap+0x8c>
    80003084:	00001097          	auipc	ra,0x1
    80003088:	09c080e7          	jalr	156(ra) # 80004120 <uartintr>
    8000308c:	fa5ff06f          	j	80003030 <kerneltrap+0xd8>
    80003090:	00002517          	auipc	a0,0x2
    80003094:	23050513          	addi	a0,a0,560 # 800052c0 <_ZZ8printIntmE6digits+0xc0>
    80003098:	00000097          	auipc	ra,0x0
    8000309c:	724080e7          	jalr	1828(ra) # 800037bc <panic>

00000000800030a0 <clockintr>:
    800030a0:	fe010113          	addi	sp,sp,-32
    800030a4:	00813823          	sd	s0,16(sp)
    800030a8:	00913423          	sd	s1,8(sp)
    800030ac:	00113c23          	sd	ra,24(sp)
    800030b0:	02010413          	addi	s0,sp,32
    800030b4:	00004497          	auipc	s1,0x4
    800030b8:	13c48493          	addi	s1,s1,316 # 800071f0 <tickslock>
    800030bc:	00048513          	mv	a0,s1
    800030c0:	00001097          	auipc	ra,0x1
    800030c4:	42c080e7          	jalr	1068(ra) # 800044ec <acquire>
    800030c8:	00003717          	auipc	a4,0x3
    800030cc:	00c70713          	addi	a4,a4,12 # 800060d4 <ticks>
    800030d0:	00072783          	lw	a5,0(a4)
    800030d4:	01013403          	ld	s0,16(sp)
    800030d8:	01813083          	ld	ra,24(sp)
    800030dc:	00048513          	mv	a0,s1
    800030e0:	0017879b          	addiw	a5,a5,1
    800030e4:	00813483          	ld	s1,8(sp)
    800030e8:	00f72023          	sw	a5,0(a4)
    800030ec:	02010113          	addi	sp,sp,32
    800030f0:	00001317          	auipc	t1,0x1
    800030f4:	4c830067          	jr	1224(t1) # 800045b8 <release>

00000000800030f8 <devintr>:
    800030f8:	142027f3          	csrr	a5,scause
    800030fc:	00000513          	li	a0,0
    80003100:	0007c463          	bltz	a5,80003108 <devintr+0x10>
    80003104:	00008067          	ret
    80003108:	fe010113          	addi	sp,sp,-32
    8000310c:	00813823          	sd	s0,16(sp)
    80003110:	00113c23          	sd	ra,24(sp)
    80003114:	00913423          	sd	s1,8(sp)
    80003118:	02010413          	addi	s0,sp,32
    8000311c:	0ff7f713          	andi	a4,a5,255
    80003120:	00900693          	li	a3,9
    80003124:	04d70c63          	beq	a4,a3,8000317c <devintr+0x84>
    80003128:	fff00713          	li	a4,-1
    8000312c:	03f71713          	slli	a4,a4,0x3f
    80003130:	00170713          	addi	a4,a4,1
    80003134:	00e78c63          	beq	a5,a4,8000314c <devintr+0x54>
    80003138:	01813083          	ld	ra,24(sp)
    8000313c:	01013403          	ld	s0,16(sp)
    80003140:	00813483          	ld	s1,8(sp)
    80003144:	02010113          	addi	sp,sp,32
    80003148:	00008067          	ret
    8000314c:	00000097          	auipc	ra,0x0
    80003150:	c8c080e7          	jalr	-884(ra) # 80002dd8 <cpuid>
    80003154:	06050663          	beqz	a0,800031c0 <devintr+0xc8>
    80003158:	144027f3          	csrr	a5,sip
    8000315c:	ffd7f793          	andi	a5,a5,-3
    80003160:	14479073          	csrw	sip,a5
    80003164:	01813083          	ld	ra,24(sp)
    80003168:	01013403          	ld	s0,16(sp)
    8000316c:	00813483          	ld	s1,8(sp)
    80003170:	00200513          	li	a0,2
    80003174:	02010113          	addi	sp,sp,32
    80003178:	00008067          	ret
    8000317c:	00000097          	auipc	ra,0x0
    80003180:	258080e7          	jalr	600(ra) # 800033d4 <plic_claim>
    80003184:	00a00793          	li	a5,10
    80003188:	00050493          	mv	s1,a0
    8000318c:	06f50663          	beq	a0,a5,800031f8 <devintr+0x100>
    80003190:	00100513          	li	a0,1
    80003194:	fa0482e3          	beqz	s1,80003138 <devintr+0x40>
    80003198:	00048593          	mv	a1,s1
    8000319c:	00002517          	auipc	a0,0x2
    800031a0:	14450513          	addi	a0,a0,324 # 800052e0 <_ZZ8printIntmE6digits+0xe0>
    800031a4:	00000097          	auipc	ra,0x0
    800031a8:	674080e7          	jalr	1652(ra) # 80003818 <__printf>
    800031ac:	00048513          	mv	a0,s1
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	25c080e7          	jalr	604(ra) # 8000340c <plic_complete>
    800031b8:	00100513          	li	a0,1
    800031bc:	f7dff06f          	j	80003138 <devintr+0x40>
    800031c0:	00004517          	auipc	a0,0x4
    800031c4:	03050513          	addi	a0,a0,48 # 800071f0 <tickslock>
    800031c8:	00001097          	auipc	ra,0x1
    800031cc:	324080e7          	jalr	804(ra) # 800044ec <acquire>
    800031d0:	00003717          	auipc	a4,0x3
    800031d4:	f0470713          	addi	a4,a4,-252 # 800060d4 <ticks>
    800031d8:	00072783          	lw	a5,0(a4)
    800031dc:	00004517          	auipc	a0,0x4
    800031e0:	01450513          	addi	a0,a0,20 # 800071f0 <tickslock>
    800031e4:	0017879b          	addiw	a5,a5,1
    800031e8:	00f72023          	sw	a5,0(a4)
    800031ec:	00001097          	auipc	ra,0x1
    800031f0:	3cc080e7          	jalr	972(ra) # 800045b8 <release>
    800031f4:	f65ff06f          	j	80003158 <devintr+0x60>
    800031f8:	00001097          	auipc	ra,0x1
    800031fc:	f28080e7          	jalr	-216(ra) # 80004120 <uartintr>
    80003200:	fadff06f          	j	800031ac <devintr+0xb4>
	...

0000000080003210 <kernelvec>:
    80003210:	f0010113          	addi	sp,sp,-256
    80003214:	00113023          	sd	ra,0(sp)
    80003218:	00213423          	sd	sp,8(sp)
    8000321c:	00313823          	sd	gp,16(sp)
    80003220:	00413c23          	sd	tp,24(sp)
    80003224:	02513023          	sd	t0,32(sp)
    80003228:	02613423          	sd	t1,40(sp)
    8000322c:	02713823          	sd	t2,48(sp)
    80003230:	02813c23          	sd	s0,56(sp)
    80003234:	04913023          	sd	s1,64(sp)
    80003238:	04a13423          	sd	a0,72(sp)
    8000323c:	04b13823          	sd	a1,80(sp)
    80003240:	04c13c23          	sd	a2,88(sp)
    80003244:	06d13023          	sd	a3,96(sp)
    80003248:	06e13423          	sd	a4,104(sp)
    8000324c:	06f13823          	sd	a5,112(sp)
    80003250:	07013c23          	sd	a6,120(sp)
    80003254:	09113023          	sd	a7,128(sp)
    80003258:	09213423          	sd	s2,136(sp)
    8000325c:	09313823          	sd	s3,144(sp)
    80003260:	09413c23          	sd	s4,152(sp)
    80003264:	0b513023          	sd	s5,160(sp)
    80003268:	0b613423          	sd	s6,168(sp)
    8000326c:	0b713823          	sd	s7,176(sp)
    80003270:	0b813c23          	sd	s8,184(sp)
    80003274:	0d913023          	sd	s9,192(sp)
    80003278:	0da13423          	sd	s10,200(sp)
    8000327c:	0db13823          	sd	s11,208(sp)
    80003280:	0dc13c23          	sd	t3,216(sp)
    80003284:	0fd13023          	sd	t4,224(sp)
    80003288:	0fe13423          	sd	t5,232(sp)
    8000328c:	0ff13823          	sd	t6,240(sp)
    80003290:	cc9ff0ef          	jal	ra,80002f58 <kerneltrap>
    80003294:	00013083          	ld	ra,0(sp)
    80003298:	00813103          	ld	sp,8(sp)
    8000329c:	01013183          	ld	gp,16(sp)
    800032a0:	02013283          	ld	t0,32(sp)
    800032a4:	02813303          	ld	t1,40(sp)
    800032a8:	03013383          	ld	t2,48(sp)
    800032ac:	03813403          	ld	s0,56(sp)
    800032b0:	04013483          	ld	s1,64(sp)
    800032b4:	04813503          	ld	a0,72(sp)
    800032b8:	05013583          	ld	a1,80(sp)
    800032bc:	05813603          	ld	a2,88(sp)
    800032c0:	06013683          	ld	a3,96(sp)
    800032c4:	06813703          	ld	a4,104(sp)
    800032c8:	07013783          	ld	a5,112(sp)
    800032cc:	07813803          	ld	a6,120(sp)
    800032d0:	08013883          	ld	a7,128(sp)
    800032d4:	08813903          	ld	s2,136(sp)
    800032d8:	09013983          	ld	s3,144(sp)
    800032dc:	09813a03          	ld	s4,152(sp)
    800032e0:	0a013a83          	ld	s5,160(sp)
    800032e4:	0a813b03          	ld	s6,168(sp)
    800032e8:	0b013b83          	ld	s7,176(sp)
    800032ec:	0b813c03          	ld	s8,184(sp)
    800032f0:	0c013c83          	ld	s9,192(sp)
    800032f4:	0c813d03          	ld	s10,200(sp)
    800032f8:	0d013d83          	ld	s11,208(sp)
    800032fc:	0d813e03          	ld	t3,216(sp)
    80003300:	0e013e83          	ld	t4,224(sp)
    80003304:	0e813f03          	ld	t5,232(sp)
    80003308:	0f013f83          	ld	t6,240(sp)
    8000330c:	10010113          	addi	sp,sp,256
    80003310:	10200073          	sret
    80003314:	00000013          	nop
    80003318:	00000013          	nop
    8000331c:	00000013          	nop

0000000080003320 <timervec>:
    80003320:	34051573          	csrrw	a0,mscratch,a0
    80003324:	00b53023          	sd	a1,0(a0)
    80003328:	00c53423          	sd	a2,8(a0)
    8000332c:	00d53823          	sd	a3,16(a0)
    80003330:	01853583          	ld	a1,24(a0)
    80003334:	02053603          	ld	a2,32(a0)
    80003338:	0005b683          	ld	a3,0(a1)
    8000333c:	00c686b3          	add	a3,a3,a2
    80003340:	00d5b023          	sd	a3,0(a1)
    80003344:	00200593          	li	a1,2
    80003348:	14459073          	csrw	sip,a1
    8000334c:	01053683          	ld	a3,16(a0)
    80003350:	00853603          	ld	a2,8(a0)
    80003354:	00053583          	ld	a1,0(a0)
    80003358:	34051573          	csrrw	a0,mscratch,a0
    8000335c:	30200073          	mret

0000000080003360 <plicinit>:
    80003360:	ff010113          	addi	sp,sp,-16
    80003364:	00813423          	sd	s0,8(sp)
    80003368:	01010413          	addi	s0,sp,16
    8000336c:	00813403          	ld	s0,8(sp)
    80003370:	0c0007b7          	lui	a5,0xc000
    80003374:	00100713          	li	a4,1
    80003378:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000337c:	00e7a223          	sw	a4,4(a5)
    80003380:	01010113          	addi	sp,sp,16
    80003384:	00008067          	ret

0000000080003388 <plicinithart>:
    80003388:	ff010113          	addi	sp,sp,-16
    8000338c:	00813023          	sd	s0,0(sp)
    80003390:	00113423          	sd	ra,8(sp)
    80003394:	01010413          	addi	s0,sp,16
    80003398:	00000097          	auipc	ra,0x0
    8000339c:	a40080e7          	jalr	-1472(ra) # 80002dd8 <cpuid>
    800033a0:	0085171b          	slliw	a4,a0,0x8
    800033a4:	0c0027b7          	lui	a5,0xc002
    800033a8:	00e787b3          	add	a5,a5,a4
    800033ac:	40200713          	li	a4,1026
    800033b0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800033b4:	00813083          	ld	ra,8(sp)
    800033b8:	00013403          	ld	s0,0(sp)
    800033bc:	00d5151b          	slliw	a0,a0,0xd
    800033c0:	0c2017b7          	lui	a5,0xc201
    800033c4:	00a78533          	add	a0,a5,a0
    800033c8:	00052023          	sw	zero,0(a0)
    800033cc:	01010113          	addi	sp,sp,16
    800033d0:	00008067          	ret

00000000800033d4 <plic_claim>:
    800033d4:	ff010113          	addi	sp,sp,-16
    800033d8:	00813023          	sd	s0,0(sp)
    800033dc:	00113423          	sd	ra,8(sp)
    800033e0:	01010413          	addi	s0,sp,16
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	9f4080e7          	jalr	-1548(ra) # 80002dd8 <cpuid>
    800033ec:	00813083          	ld	ra,8(sp)
    800033f0:	00013403          	ld	s0,0(sp)
    800033f4:	00d5151b          	slliw	a0,a0,0xd
    800033f8:	0c2017b7          	lui	a5,0xc201
    800033fc:	00a78533          	add	a0,a5,a0
    80003400:	00452503          	lw	a0,4(a0)
    80003404:	01010113          	addi	sp,sp,16
    80003408:	00008067          	ret

000000008000340c <plic_complete>:
    8000340c:	fe010113          	addi	sp,sp,-32
    80003410:	00813823          	sd	s0,16(sp)
    80003414:	00913423          	sd	s1,8(sp)
    80003418:	00113c23          	sd	ra,24(sp)
    8000341c:	02010413          	addi	s0,sp,32
    80003420:	00050493          	mv	s1,a0
    80003424:	00000097          	auipc	ra,0x0
    80003428:	9b4080e7          	jalr	-1612(ra) # 80002dd8 <cpuid>
    8000342c:	01813083          	ld	ra,24(sp)
    80003430:	01013403          	ld	s0,16(sp)
    80003434:	00d5179b          	slliw	a5,a0,0xd
    80003438:	0c201737          	lui	a4,0xc201
    8000343c:	00f707b3          	add	a5,a4,a5
    80003440:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003444:	00813483          	ld	s1,8(sp)
    80003448:	02010113          	addi	sp,sp,32
    8000344c:	00008067          	ret

0000000080003450 <consolewrite>:
    80003450:	fb010113          	addi	sp,sp,-80
    80003454:	04813023          	sd	s0,64(sp)
    80003458:	04113423          	sd	ra,72(sp)
    8000345c:	02913c23          	sd	s1,56(sp)
    80003460:	03213823          	sd	s2,48(sp)
    80003464:	03313423          	sd	s3,40(sp)
    80003468:	03413023          	sd	s4,32(sp)
    8000346c:	01513c23          	sd	s5,24(sp)
    80003470:	05010413          	addi	s0,sp,80
    80003474:	06c05c63          	blez	a2,800034ec <consolewrite+0x9c>
    80003478:	00060993          	mv	s3,a2
    8000347c:	00050a13          	mv	s4,a0
    80003480:	00058493          	mv	s1,a1
    80003484:	00000913          	li	s2,0
    80003488:	fff00a93          	li	s5,-1
    8000348c:	01c0006f          	j	800034a8 <consolewrite+0x58>
    80003490:	fbf44503          	lbu	a0,-65(s0)
    80003494:	0019091b          	addiw	s2,s2,1
    80003498:	00148493          	addi	s1,s1,1
    8000349c:	00001097          	auipc	ra,0x1
    800034a0:	a9c080e7          	jalr	-1380(ra) # 80003f38 <uartputc>
    800034a4:	03298063          	beq	s3,s2,800034c4 <consolewrite+0x74>
    800034a8:	00048613          	mv	a2,s1
    800034ac:	00100693          	li	a3,1
    800034b0:	000a0593          	mv	a1,s4
    800034b4:	fbf40513          	addi	a0,s0,-65
    800034b8:	00000097          	auipc	ra,0x0
    800034bc:	9d8080e7          	jalr	-1576(ra) # 80002e90 <either_copyin>
    800034c0:	fd5518e3          	bne	a0,s5,80003490 <consolewrite+0x40>
    800034c4:	04813083          	ld	ra,72(sp)
    800034c8:	04013403          	ld	s0,64(sp)
    800034cc:	03813483          	ld	s1,56(sp)
    800034d0:	02813983          	ld	s3,40(sp)
    800034d4:	02013a03          	ld	s4,32(sp)
    800034d8:	01813a83          	ld	s5,24(sp)
    800034dc:	00090513          	mv	a0,s2
    800034e0:	03013903          	ld	s2,48(sp)
    800034e4:	05010113          	addi	sp,sp,80
    800034e8:	00008067          	ret
    800034ec:	00000913          	li	s2,0
    800034f0:	fd5ff06f          	j	800034c4 <consolewrite+0x74>

00000000800034f4 <consoleread>:
    800034f4:	f9010113          	addi	sp,sp,-112
    800034f8:	06813023          	sd	s0,96(sp)
    800034fc:	04913c23          	sd	s1,88(sp)
    80003500:	05213823          	sd	s2,80(sp)
    80003504:	05313423          	sd	s3,72(sp)
    80003508:	05413023          	sd	s4,64(sp)
    8000350c:	03513c23          	sd	s5,56(sp)
    80003510:	03613823          	sd	s6,48(sp)
    80003514:	03713423          	sd	s7,40(sp)
    80003518:	03813023          	sd	s8,32(sp)
    8000351c:	06113423          	sd	ra,104(sp)
    80003520:	01913c23          	sd	s9,24(sp)
    80003524:	07010413          	addi	s0,sp,112
    80003528:	00060b93          	mv	s7,a2
    8000352c:	00050913          	mv	s2,a0
    80003530:	00058c13          	mv	s8,a1
    80003534:	00060b1b          	sext.w	s6,a2
    80003538:	00004497          	auipc	s1,0x4
    8000353c:	ce048493          	addi	s1,s1,-800 # 80007218 <cons>
    80003540:	00400993          	li	s3,4
    80003544:	fff00a13          	li	s4,-1
    80003548:	00a00a93          	li	s5,10
    8000354c:	05705e63          	blez	s7,800035a8 <consoleread+0xb4>
    80003550:	09c4a703          	lw	a4,156(s1)
    80003554:	0984a783          	lw	a5,152(s1)
    80003558:	0007071b          	sext.w	a4,a4
    8000355c:	08e78463          	beq	a5,a4,800035e4 <consoleread+0xf0>
    80003560:	07f7f713          	andi	a4,a5,127
    80003564:	00e48733          	add	a4,s1,a4
    80003568:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000356c:	0017869b          	addiw	a3,a5,1
    80003570:	08d4ac23          	sw	a3,152(s1)
    80003574:	00070c9b          	sext.w	s9,a4
    80003578:	0b370663          	beq	a4,s3,80003624 <consoleread+0x130>
    8000357c:	00100693          	li	a3,1
    80003580:	f9f40613          	addi	a2,s0,-97
    80003584:	000c0593          	mv	a1,s8
    80003588:	00090513          	mv	a0,s2
    8000358c:	f8e40fa3          	sb	a4,-97(s0)
    80003590:	00000097          	auipc	ra,0x0
    80003594:	8b4080e7          	jalr	-1868(ra) # 80002e44 <either_copyout>
    80003598:	01450863          	beq	a0,s4,800035a8 <consoleread+0xb4>
    8000359c:	001c0c13          	addi	s8,s8,1
    800035a0:	fffb8b9b          	addiw	s7,s7,-1
    800035a4:	fb5c94e3          	bne	s9,s5,8000354c <consoleread+0x58>
    800035a8:	000b851b          	sext.w	a0,s7
    800035ac:	06813083          	ld	ra,104(sp)
    800035b0:	06013403          	ld	s0,96(sp)
    800035b4:	05813483          	ld	s1,88(sp)
    800035b8:	05013903          	ld	s2,80(sp)
    800035bc:	04813983          	ld	s3,72(sp)
    800035c0:	04013a03          	ld	s4,64(sp)
    800035c4:	03813a83          	ld	s5,56(sp)
    800035c8:	02813b83          	ld	s7,40(sp)
    800035cc:	02013c03          	ld	s8,32(sp)
    800035d0:	01813c83          	ld	s9,24(sp)
    800035d4:	40ab053b          	subw	a0,s6,a0
    800035d8:	03013b03          	ld	s6,48(sp)
    800035dc:	07010113          	addi	sp,sp,112
    800035e0:	00008067          	ret
    800035e4:	00001097          	auipc	ra,0x1
    800035e8:	1d8080e7          	jalr	472(ra) # 800047bc <push_on>
    800035ec:	0984a703          	lw	a4,152(s1)
    800035f0:	09c4a783          	lw	a5,156(s1)
    800035f4:	0007879b          	sext.w	a5,a5
    800035f8:	fef70ce3          	beq	a4,a5,800035f0 <consoleread+0xfc>
    800035fc:	00001097          	auipc	ra,0x1
    80003600:	234080e7          	jalr	564(ra) # 80004830 <pop_on>
    80003604:	0984a783          	lw	a5,152(s1)
    80003608:	07f7f713          	andi	a4,a5,127
    8000360c:	00e48733          	add	a4,s1,a4
    80003610:	01874703          	lbu	a4,24(a4)
    80003614:	0017869b          	addiw	a3,a5,1
    80003618:	08d4ac23          	sw	a3,152(s1)
    8000361c:	00070c9b          	sext.w	s9,a4
    80003620:	f5371ee3          	bne	a4,s3,8000357c <consoleread+0x88>
    80003624:	000b851b          	sext.w	a0,s7
    80003628:	f96bf2e3          	bgeu	s7,s6,800035ac <consoleread+0xb8>
    8000362c:	08f4ac23          	sw	a5,152(s1)
    80003630:	f7dff06f          	j	800035ac <consoleread+0xb8>

0000000080003634 <consputc>:
    80003634:	10000793          	li	a5,256
    80003638:	00f50663          	beq	a0,a5,80003644 <consputc+0x10>
    8000363c:	00001317          	auipc	t1,0x1
    80003640:	9f430067          	jr	-1548(t1) # 80004030 <uartputc_sync>
    80003644:	ff010113          	addi	sp,sp,-16
    80003648:	00113423          	sd	ra,8(sp)
    8000364c:	00813023          	sd	s0,0(sp)
    80003650:	01010413          	addi	s0,sp,16
    80003654:	00800513          	li	a0,8
    80003658:	00001097          	auipc	ra,0x1
    8000365c:	9d8080e7          	jalr	-1576(ra) # 80004030 <uartputc_sync>
    80003660:	02000513          	li	a0,32
    80003664:	00001097          	auipc	ra,0x1
    80003668:	9cc080e7          	jalr	-1588(ra) # 80004030 <uartputc_sync>
    8000366c:	00013403          	ld	s0,0(sp)
    80003670:	00813083          	ld	ra,8(sp)
    80003674:	00800513          	li	a0,8
    80003678:	01010113          	addi	sp,sp,16
    8000367c:	00001317          	auipc	t1,0x1
    80003680:	9b430067          	jr	-1612(t1) # 80004030 <uartputc_sync>

0000000080003684 <consoleintr>:
    80003684:	fe010113          	addi	sp,sp,-32
    80003688:	00813823          	sd	s0,16(sp)
    8000368c:	00913423          	sd	s1,8(sp)
    80003690:	01213023          	sd	s2,0(sp)
    80003694:	00113c23          	sd	ra,24(sp)
    80003698:	02010413          	addi	s0,sp,32
    8000369c:	00004917          	auipc	s2,0x4
    800036a0:	b7c90913          	addi	s2,s2,-1156 # 80007218 <cons>
    800036a4:	00050493          	mv	s1,a0
    800036a8:	00090513          	mv	a0,s2
    800036ac:	00001097          	auipc	ra,0x1
    800036b0:	e40080e7          	jalr	-448(ra) # 800044ec <acquire>
    800036b4:	02048c63          	beqz	s1,800036ec <consoleintr+0x68>
    800036b8:	0a092783          	lw	a5,160(s2)
    800036bc:	09892703          	lw	a4,152(s2)
    800036c0:	07f00693          	li	a3,127
    800036c4:	40e7873b          	subw	a4,a5,a4
    800036c8:	02e6e263          	bltu	a3,a4,800036ec <consoleintr+0x68>
    800036cc:	00d00713          	li	a4,13
    800036d0:	04e48063          	beq	s1,a4,80003710 <consoleintr+0x8c>
    800036d4:	07f7f713          	andi	a4,a5,127
    800036d8:	00e90733          	add	a4,s2,a4
    800036dc:	0017879b          	addiw	a5,a5,1
    800036e0:	0af92023          	sw	a5,160(s2)
    800036e4:	00970c23          	sb	s1,24(a4)
    800036e8:	08f92e23          	sw	a5,156(s2)
    800036ec:	01013403          	ld	s0,16(sp)
    800036f0:	01813083          	ld	ra,24(sp)
    800036f4:	00813483          	ld	s1,8(sp)
    800036f8:	00013903          	ld	s2,0(sp)
    800036fc:	00004517          	auipc	a0,0x4
    80003700:	b1c50513          	addi	a0,a0,-1252 # 80007218 <cons>
    80003704:	02010113          	addi	sp,sp,32
    80003708:	00001317          	auipc	t1,0x1
    8000370c:	eb030067          	jr	-336(t1) # 800045b8 <release>
    80003710:	00a00493          	li	s1,10
    80003714:	fc1ff06f          	j	800036d4 <consoleintr+0x50>

0000000080003718 <consoleinit>:
    80003718:	fe010113          	addi	sp,sp,-32
    8000371c:	00113c23          	sd	ra,24(sp)
    80003720:	00813823          	sd	s0,16(sp)
    80003724:	00913423          	sd	s1,8(sp)
    80003728:	02010413          	addi	s0,sp,32
    8000372c:	00004497          	auipc	s1,0x4
    80003730:	aec48493          	addi	s1,s1,-1300 # 80007218 <cons>
    80003734:	00048513          	mv	a0,s1
    80003738:	00002597          	auipc	a1,0x2
    8000373c:	c0058593          	addi	a1,a1,-1024 # 80005338 <_ZZ8printIntmE6digits+0x138>
    80003740:	00001097          	auipc	ra,0x1
    80003744:	d88080e7          	jalr	-632(ra) # 800044c8 <initlock>
    80003748:	00000097          	auipc	ra,0x0
    8000374c:	7ac080e7          	jalr	1964(ra) # 80003ef4 <uartinit>
    80003750:	01813083          	ld	ra,24(sp)
    80003754:	01013403          	ld	s0,16(sp)
    80003758:	00000797          	auipc	a5,0x0
    8000375c:	d9c78793          	addi	a5,a5,-612 # 800034f4 <consoleread>
    80003760:	0af4bc23          	sd	a5,184(s1)
    80003764:	00000797          	auipc	a5,0x0
    80003768:	cec78793          	addi	a5,a5,-788 # 80003450 <consolewrite>
    8000376c:	0cf4b023          	sd	a5,192(s1)
    80003770:	00813483          	ld	s1,8(sp)
    80003774:	02010113          	addi	sp,sp,32
    80003778:	00008067          	ret

000000008000377c <console_read>:
    8000377c:	ff010113          	addi	sp,sp,-16
    80003780:	00813423          	sd	s0,8(sp)
    80003784:	01010413          	addi	s0,sp,16
    80003788:	00813403          	ld	s0,8(sp)
    8000378c:	00004317          	auipc	t1,0x4
    80003790:	b4433303          	ld	t1,-1212(t1) # 800072d0 <devsw+0x10>
    80003794:	01010113          	addi	sp,sp,16
    80003798:	00030067          	jr	t1

000000008000379c <console_write>:
    8000379c:	ff010113          	addi	sp,sp,-16
    800037a0:	00813423          	sd	s0,8(sp)
    800037a4:	01010413          	addi	s0,sp,16
    800037a8:	00813403          	ld	s0,8(sp)
    800037ac:	00004317          	auipc	t1,0x4
    800037b0:	b2c33303          	ld	t1,-1236(t1) # 800072d8 <devsw+0x18>
    800037b4:	01010113          	addi	sp,sp,16
    800037b8:	00030067          	jr	t1

00000000800037bc <panic>:
    800037bc:	fe010113          	addi	sp,sp,-32
    800037c0:	00113c23          	sd	ra,24(sp)
    800037c4:	00813823          	sd	s0,16(sp)
    800037c8:	00913423          	sd	s1,8(sp)
    800037cc:	02010413          	addi	s0,sp,32
    800037d0:	00050493          	mv	s1,a0
    800037d4:	00002517          	auipc	a0,0x2
    800037d8:	b6c50513          	addi	a0,a0,-1172 # 80005340 <_ZZ8printIntmE6digits+0x140>
    800037dc:	00004797          	auipc	a5,0x4
    800037e0:	b807ae23          	sw	zero,-1124(a5) # 80007378 <pr+0x18>
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	034080e7          	jalr	52(ra) # 80003818 <__printf>
    800037ec:	00048513          	mv	a0,s1
    800037f0:	00000097          	auipc	ra,0x0
    800037f4:	028080e7          	jalr	40(ra) # 80003818 <__printf>
    800037f8:	00002517          	auipc	a0,0x2
    800037fc:	95050513          	addi	a0,a0,-1712 # 80005148 <CONSOLE_STATUS+0x138>
    80003800:	00000097          	auipc	ra,0x0
    80003804:	018080e7          	jalr	24(ra) # 80003818 <__printf>
    80003808:	00100793          	li	a5,1
    8000380c:	00003717          	auipc	a4,0x3
    80003810:	8cf72623          	sw	a5,-1844(a4) # 800060d8 <panicked>
    80003814:	0000006f          	j	80003814 <panic+0x58>

0000000080003818 <__printf>:
    80003818:	f3010113          	addi	sp,sp,-208
    8000381c:	08813023          	sd	s0,128(sp)
    80003820:	07313423          	sd	s3,104(sp)
    80003824:	09010413          	addi	s0,sp,144
    80003828:	05813023          	sd	s8,64(sp)
    8000382c:	08113423          	sd	ra,136(sp)
    80003830:	06913c23          	sd	s1,120(sp)
    80003834:	07213823          	sd	s2,112(sp)
    80003838:	07413023          	sd	s4,96(sp)
    8000383c:	05513c23          	sd	s5,88(sp)
    80003840:	05613823          	sd	s6,80(sp)
    80003844:	05713423          	sd	s7,72(sp)
    80003848:	03913c23          	sd	s9,56(sp)
    8000384c:	03a13823          	sd	s10,48(sp)
    80003850:	03b13423          	sd	s11,40(sp)
    80003854:	00004317          	auipc	t1,0x4
    80003858:	b0c30313          	addi	t1,t1,-1268 # 80007360 <pr>
    8000385c:	01832c03          	lw	s8,24(t1)
    80003860:	00b43423          	sd	a1,8(s0)
    80003864:	00c43823          	sd	a2,16(s0)
    80003868:	00d43c23          	sd	a3,24(s0)
    8000386c:	02e43023          	sd	a4,32(s0)
    80003870:	02f43423          	sd	a5,40(s0)
    80003874:	03043823          	sd	a6,48(s0)
    80003878:	03143c23          	sd	a7,56(s0)
    8000387c:	00050993          	mv	s3,a0
    80003880:	4a0c1663          	bnez	s8,80003d2c <__printf+0x514>
    80003884:	60098c63          	beqz	s3,80003e9c <__printf+0x684>
    80003888:	0009c503          	lbu	a0,0(s3)
    8000388c:	00840793          	addi	a5,s0,8
    80003890:	f6f43c23          	sd	a5,-136(s0)
    80003894:	00000493          	li	s1,0
    80003898:	22050063          	beqz	a0,80003ab8 <__printf+0x2a0>
    8000389c:	00002a37          	lui	s4,0x2
    800038a0:	00018ab7          	lui	s5,0x18
    800038a4:	000f4b37          	lui	s6,0xf4
    800038a8:	00989bb7          	lui	s7,0x989
    800038ac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800038b0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800038b4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800038b8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800038bc:	00148c9b          	addiw	s9,s1,1
    800038c0:	02500793          	li	a5,37
    800038c4:	01998933          	add	s2,s3,s9
    800038c8:	38f51263          	bne	a0,a5,80003c4c <__printf+0x434>
    800038cc:	00094783          	lbu	a5,0(s2)
    800038d0:	00078c9b          	sext.w	s9,a5
    800038d4:	1e078263          	beqz	a5,80003ab8 <__printf+0x2a0>
    800038d8:	0024849b          	addiw	s1,s1,2
    800038dc:	07000713          	li	a4,112
    800038e0:	00998933          	add	s2,s3,s1
    800038e4:	38e78a63          	beq	a5,a4,80003c78 <__printf+0x460>
    800038e8:	20f76863          	bltu	a4,a5,80003af8 <__printf+0x2e0>
    800038ec:	42a78863          	beq	a5,a0,80003d1c <__printf+0x504>
    800038f0:	06400713          	li	a4,100
    800038f4:	40e79663          	bne	a5,a4,80003d00 <__printf+0x4e8>
    800038f8:	f7843783          	ld	a5,-136(s0)
    800038fc:	0007a603          	lw	a2,0(a5)
    80003900:	00878793          	addi	a5,a5,8
    80003904:	f6f43c23          	sd	a5,-136(s0)
    80003908:	42064a63          	bltz	a2,80003d3c <__printf+0x524>
    8000390c:	00a00713          	li	a4,10
    80003910:	02e677bb          	remuw	a5,a2,a4
    80003914:	00002d97          	auipc	s11,0x2
    80003918:	a54d8d93          	addi	s11,s11,-1452 # 80005368 <digits>
    8000391c:	00900593          	li	a1,9
    80003920:	0006051b          	sext.w	a0,a2
    80003924:	00000c93          	li	s9,0
    80003928:	02079793          	slli	a5,a5,0x20
    8000392c:	0207d793          	srli	a5,a5,0x20
    80003930:	00fd87b3          	add	a5,s11,a5
    80003934:	0007c783          	lbu	a5,0(a5)
    80003938:	02e656bb          	divuw	a3,a2,a4
    8000393c:	f8f40023          	sb	a5,-128(s0)
    80003940:	14c5d863          	bge	a1,a2,80003a90 <__printf+0x278>
    80003944:	06300593          	li	a1,99
    80003948:	00100c93          	li	s9,1
    8000394c:	02e6f7bb          	remuw	a5,a3,a4
    80003950:	02079793          	slli	a5,a5,0x20
    80003954:	0207d793          	srli	a5,a5,0x20
    80003958:	00fd87b3          	add	a5,s11,a5
    8000395c:	0007c783          	lbu	a5,0(a5)
    80003960:	02e6d73b          	divuw	a4,a3,a4
    80003964:	f8f400a3          	sb	a5,-127(s0)
    80003968:	12a5f463          	bgeu	a1,a0,80003a90 <__printf+0x278>
    8000396c:	00a00693          	li	a3,10
    80003970:	00900593          	li	a1,9
    80003974:	02d777bb          	remuw	a5,a4,a3
    80003978:	02079793          	slli	a5,a5,0x20
    8000397c:	0207d793          	srli	a5,a5,0x20
    80003980:	00fd87b3          	add	a5,s11,a5
    80003984:	0007c503          	lbu	a0,0(a5)
    80003988:	02d757bb          	divuw	a5,a4,a3
    8000398c:	f8a40123          	sb	a0,-126(s0)
    80003990:	48e5f263          	bgeu	a1,a4,80003e14 <__printf+0x5fc>
    80003994:	06300513          	li	a0,99
    80003998:	02d7f5bb          	remuw	a1,a5,a3
    8000399c:	02059593          	slli	a1,a1,0x20
    800039a0:	0205d593          	srli	a1,a1,0x20
    800039a4:	00bd85b3          	add	a1,s11,a1
    800039a8:	0005c583          	lbu	a1,0(a1)
    800039ac:	02d7d7bb          	divuw	a5,a5,a3
    800039b0:	f8b401a3          	sb	a1,-125(s0)
    800039b4:	48e57263          	bgeu	a0,a4,80003e38 <__printf+0x620>
    800039b8:	3e700513          	li	a0,999
    800039bc:	02d7f5bb          	remuw	a1,a5,a3
    800039c0:	02059593          	slli	a1,a1,0x20
    800039c4:	0205d593          	srli	a1,a1,0x20
    800039c8:	00bd85b3          	add	a1,s11,a1
    800039cc:	0005c583          	lbu	a1,0(a1)
    800039d0:	02d7d7bb          	divuw	a5,a5,a3
    800039d4:	f8b40223          	sb	a1,-124(s0)
    800039d8:	46e57663          	bgeu	a0,a4,80003e44 <__printf+0x62c>
    800039dc:	02d7f5bb          	remuw	a1,a5,a3
    800039e0:	02059593          	slli	a1,a1,0x20
    800039e4:	0205d593          	srli	a1,a1,0x20
    800039e8:	00bd85b3          	add	a1,s11,a1
    800039ec:	0005c583          	lbu	a1,0(a1)
    800039f0:	02d7d7bb          	divuw	a5,a5,a3
    800039f4:	f8b402a3          	sb	a1,-123(s0)
    800039f8:	46ea7863          	bgeu	s4,a4,80003e68 <__printf+0x650>
    800039fc:	02d7f5bb          	remuw	a1,a5,a3
    80003a00:	02059593          	slli	a1,a1,0x20
    80003a04:	0205d593          	srli	a1,a1,0x20
    80003a08:	00bd85b3          	add	a1,s11,a1
    80003a0c:	0005c583          	lbu	a1,0(a1)
    80003a10:	02d7d7bb          	divuw	a5,a5,a3
    80003a14:	f8b40323          	sb	a1,-122(s0)
    80003a18:	3eeaf863          	bgeu	s5,a4,80003e08 <__printf+0x5f0>
    80003a1c:	02d7f5bb          	remuw	a1,a5,a3
    80003a20:	02059593          	slli	a1,a1,0x20
    80003a24:	0205d593          	srli	a1,a1,0x20
    80003a28:	00bd85b3          	add	a1,s11,a1
    80003a2c:	0005c583          	lbu	a1,0(a1)
    80003a30:	02d7d7bb          	divuw	a5,a5,a3
    80003a34:	f8b403a3          	sb	a1,-121(s0)
    80003a38:	42eb7e63          	bgeu	s6,a4,80003e74 <__printf+0x65c>
    80003a3c:	02d7f5bb          	remuw	a1,a5,a3
    80003a40:	02059593          	slli	a1,a1,0x20
    80003a44:	0205d593          	srli	a1,a1,0x20
    80003a48:	00bd85b3          	add	a1,s11,a1
    80003a4c:	0005c583          	lbu	a1,0(a1)
    80003a50:	02d7d7bb          	divuw	a5,a5,a3
    80003a54:	f8b40423          	sb	a1,-120(s0)
    80003a58:	42ebfc63          	bgeu	s7,a4,80003e90 <__printf+0x678>
    80003a5c:	02079793          	slli	a5,a5,0x20
    80003a60:	0207d793          	srli	a5,a5,0x20
    80003a64:	00fd8db3          	add	s11,s11,a5
    80003a68:	000dc703          	lbu	a4,0(s11)
    80003a6c:	00a00793          	li	a5,10
    80003a70:	00900c93          	li	s9,9
    80003a74:	f8e404a3          	sb	a4,-119(s0)
    80003a78:	00065c63          	bgez	a2,80003a90 <__printf+0x278>
    80003a7c:	f9040713          	addi	a4,s0,-112
    80003a80:	00f70733          	add	a4,a4,a5
    80003a84:	02d00693          	li	a3,45
    80003a88:	fed70823          	sb	a3,-16(a4)
    80003a8c:	00078c93          	mv	s9,a5
    80003a90:	f8040793          	addi	a5,s0,-128
    80003a94:	01978cb3          	add	s9,a5,s9
    80003a98:	f7f40d13          	addi	s10,s0,-129
    80003a9c:	000cc503          	lbu	a0,0(s9)
    80003aa0:	fffc8c93          	addi	s9,s9,-1
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	b90080e7          	jalr	-1136(ra) # 80003634 <consputc>
    80003aac:	ffac98e3          	bne	s9,s10,80003a9c <__printf+0x284>
    80003ab0:	00094503          	lbu	a0,0(s2)
    80003ab4:	e00514e3          	bnez	a0,800038bc <__printf+0xa4>
    80003ab8:	1a0c1663          	bnez	s8,80003c64 <__printf+0x44c>
    80003abc:	08813083          	ld	ra,136(sp)
    80003ac0:	08013403          	ld	s0,128(sp)
    80003ac4:	07813483          	ld	s1,120(sp)
    80003ac8:	07013903          	ld	s2,112(sp)
    80003acc:	06813983          	ld	s3,104(sp)
    80003ad0:	06013a03          	ld	s4,96(sp)
    80003ad4:	05813a83          	ld	s5,88(sp)
    80003ad8:	05013b03          	ld	s6,80(sp)
    80003adc:	04813b83          	ld	s7,72(sp)
    80003ae0:	04013c03          	ld	s8,64(sp)
    80003ae4:	03813c83          	ld	s9,56(sp)
    80003ae8:	03013d03          	ld	s10,48(sp)
    80003aec:	02813d83          	ld	s11,40(sp)
    80003af0:	0d010113          	addi	sp,sp,208
    80003af4:	00008067          	ret
    80003af8:	07300713          	li	a4,115
    80003afc:	1ce78a63          	beq	a5,a4,80003cd0 <__printf+0x4b8>
    80003b00:	07800713          	li	a4,120
    80003b04:	1ee79e63          	bne	a5,a4,80003d00 <__printf+0x4e8>
    80003b08:	f7843783          	ld	a5,-136(s0)
    80003b0c:	0007a703          	lw	a4,0(a5)
    80003b10:	00878793          	addi	a5,a5,8
    80003b14:	f6f43c23          	sd	a5,-136(s0)
    80003b18:	28074263          	bltz	a4,80003d9c <__printf+0x584>
    80003b1c:	00002d97          	auipc	s11,0x2
    80003b20:	84cd8d93          	addi	s11,s11,-1972 # 80005368 <digits>
    80003b24:	00f77793          	andi	a5,a4,15
    80003b28:	00fd87b3          	add	a5,s11,a5
    80003b2c:	0007c683          	lbu	a3,0(a5)
    80003b30:	00f00613          	li	a2,15
    80003b34:	0007079b          	sext.w	a5,a4
    80003b38:	f8d40023          	sb	a3,-128(s0)
    80003b3c:	0047559b          	srliw	a1,a4,0x4
    80003b40:	0047569b          	srliw	a3,a4,0x4
    80003b44:	00000c93          	li	s9,0
    80003b48:	0ee65063          	bge	a2,a4,80003c28 <__printf+0x410>
    80003b4c:	00f6f693          	andi	a3,a3,15
    80003b50:	00dd86b3          	add	a3,s11,a3
    80003b54:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003b58:	0087d79b          	srliw	a5,a5,0x8
    80003b5c:	00100c93          	li	s9,1
    80003b60:	f8d400a3          	sb	a3,-127(s0)
    80003b64:	0cb67263          	bgeu	a2,a1,80003c28 <__printf+0x410>
    80003b68:	00f7f693          	andi	a3,a5,15
    80003b6c:	00dd86b3          	add	a3,s11,a3
    80003b70:	0006c583          	lbu	a1,0(a3)
    80003b74:	00f00613          	li	a2,15
    80003b78:	0047d69b          	srliw	a3,a5,0x4
    80003b7c:	f8b40123          	sb	a1,-126(s0)
    80003b80:	0047d593          	srli	a1,a5,0x4
    80003b84:	28f67e63          	bgeu	a2,a5,80003e20 <__printf+0x608>
    80003b88:	00f6f693          	andi	a3,a3,15
    80003b8c:	00dd86b3          	add	a3,s11,a3
    80003b90:	0006c503          	lbu	a0,0(a3)
    80003b94:	0087d813          	srli	a6,a5,0x8
    80003b98:	0087d69b          	srliw	a3,a5,0x8
    80003b9c:	f8a401a3          	sb	a0,-125(s0)
    80003ba0:	28b67663          	bgeu	a2,a1,80003e2c <__printf+0x614>
    80003ba4:	00f6f693          	andi	a3,a3,15
    80003ba8:	00dd86b3          	add	a3,s11,a3
    80003bac:	0006c583          	lbu	a1,0(a3)
    80003bb0:	00c7d513          	srli	a0,a5,0xc
    80003bb4:	00c7d69b          	srliw	a3,a5,0xc
    80003bb8:	f8b40223          	sb	a1,-124(s0)
    80003bbc:	29067a63          	bgeu	a2,a6,80003e50 <__printf+0x638>
    80003bc0:	00f6f693          	andi	a3,a3,15
    80003bc4:	00dd86b3          	add	a3,s11,a3
    80003bc8:	0006c583          	lbu	a1,0(a3)
    80003bcc:	0107d813          	srli	a6,a5,0x10
    80003bd0:	0107d69b          	srliw	a3,a5,0x10
    80003bd4:	f8b402a3          	sb	a1,-123(s0)
    80003bd8:	28a67263          	bgeu	a2,a0,80003e5c <__printf+0x644>
    80003bdc:	00f6f693          	andi	a3,a3,15
    80003be0:	00dd86b3          	add	a3,s11,a3
    80003be4:	0006c683          	lbu	a3,0(a3)
    80003be8:	0147d79b          	srliw	a5,a5,0x14
    80003bec:	f8d40323          	sb	a3,-122(s0)
    80003bf0:	21067663          	bgeu	a2,a6,80003dfc <__printf+0x5e4>
    80003bf4:	02079793          	slli	a5,a5,0x20
    80003bf8:	0207d793          	srli	a5,a5,0x20
    80003bfc:	00fd8db3          	add	s11,s11,a5
    80003c00:	000dc683          	lbu	a3,0(s11)
    80003c04:	00800793          	li	a5,8
    80003c08:	00700c93          	li	s9,7
    80003c0c:	f8d403a3          	sb	a3,-121(s0)
    80003c10:	00075c63          	bgez	a4,80003c28 <__printf+0x410>
    80003c14:	f9040713          	addi	a4,s0,-112
    80003c18:	00f70733          	add	a4,a4,a5
    80003c1c:	02d00693          	li	a3,45
    80003c20:	fed70823          	sb	a3,-16(a4)
    80003c24:	00078c93          	mv	s9,a5
    80003c28:	f8040793          	addi	a5,s0,-128
    80003c2c:	01978cb3          	add	s9,a5,s9
    80003c30:	f7f40d13          	addi	s10,s0,-129
    80003c34:	000cc503          	lbu	a0,0(s9)
    80003c38:	fffc8c93          	addi	s9,s9,-1
    80003c3c:	00000097          	auipc	ra,0x0
    80003c40:	9f8080e7          	jalr	-1544(ra) # 80003634 <consputc>
    80003c44:	ff9d18e3          	bne	s10,s9,80003c34 <__printf+0x41c>
    80003c48:	0100006f          	j	80003c58 <__printf+0x440>
    80003c4c:	00000097          	auipc	ra,0x0
    80003c50:	9e8080e7          	jalr	-1560(ra) # 80003634 <consputc>
    80003c54:	000c8493          	mv	s1,s9
    80003c58:	00094503          	lbu	a0,0(s2)
    80003c5c:	c60510e3          	bnez	a0,800038bc <__printf+0xa4>
    80003c60:	e40c0ee3          	beqz	s8,80003abc <__printf+0x2a4>
    80003c64:	00003517          	auipc	a0,0x3
    80003c68:	6fc50513          	addi	a0,a0,1788 # 80007360 <pr>
    80003c6c:	00001097          	auipc	ra,0x1
    80003c70:	94c080e7          	jalr	-1716(ra) # 800045b8 <release>
    80003c74:	e49ff06f          	j	80003abc <__printf+0x2a4>
    80003c78:	f7843783          	ld	a5,-136(s0)
    80003c7c:	03000513          	li	a0,48
    80003c80:	01000d13          	li	s10,16
    80003c84:	00878713          	addi	a4,a5,8
    80003c88:	0007bc83          	ld	s9,0(a5)
    80003c8c:	f6e43c23          	sd	a4,-136(s0)
    80003c90:	00000097          	auipc	ra,0x0
    80003c94:	9a4080e7          	jalr	-1628(ra) # 80003634 <consputc>
    80003c98:	07800513          	li	a0,120
    80003c9c:	00000097          	auipc	ra,0x0
    80003ca0:	998080e7          	jalr	-1640(ra) # 80003634 <consputc>
    80003ca4:	00001d97          	auipc	s11,0x1
    80003ca8:	6c4d8d93          	addi	s11,s11,1732 # 80005368 <digits>
    80003cac:	03ccd793          	srli	a5,s9,0x3c
    80003cb0:	00fd87b3          	add	a5,s11,a5
    80003cb4:	0007c503          	lbu	a0,0(a5)
    80003cb8:	fffd0d1b          	addiw	s10,s10,-1
    80003cbc:	004c9c93          	slli	s9,s9,0x4
    80003cc0:	00000097          	auipc	ra,0x0
    80003cc4:	974080e7          	jalr	-1676(ra) # 80003634 <consputc>
    80003cc8:	fe0d12e3          	bnez	s10,80003cac <__printf+0x494>
    80003ccc:	f8dff06f          	j	80003c58 <__printf+0x440>
    80003cd0:	f7843783          	ld	a5,-136(s0)
    80003cd4:	0007bc83          	ld	s9,0(a5)
    80003cd8:	00878793          	addi	a5,a5,8
    80003cdc:	f6f43c23          	sd	a5,-136(s0)
    80003ce0:	000c9a63          	bnez	s9,80003cf4 <__printf+0x4dc>
    80003ce4:	1080006f          	j	80003dec <__printf+0x5d4>
    80003ce8:	001c8c93          	addi	s9,s9,1
    80003cec:	00000097          	auipc	ra,0x0
    80003cf0:	948080e7          	jalr	-1720(ra) # 80003634 <consputc>
    80003cf4:	000cc503          	lbu	a0,0(s9)
    80003cf8:	fe0518e3          	bnez	a0,80003ce8 <__printf+0x4d0>
    80003cfc:	f5dff06f          	j	80003c58 <__printf+0x440>
    80003d00:	02500513          	li	a0,37
    80003d04:	00000097          	auipc	ra,0x0
    80003d08:	930080e7          	jalr	-1744(ra) # 80003634 <consputc>
    80003d0c:	000c8513          	mv	a0,s9
    80003d10:	00000097          	auipc	ra,0x0
    80003d14:	924080e7          	jalr	-1756(ra) # 80003634 <consputc>
    80003d18:	f41ff06f          	j	80003c58 <__printf+0x440>
    80003d1c:	02500513          	li	a0,37
    80003d20:	00000097          	auipc	ra,0x0
    80003d24:	914080e7          	jalr	-1772(ra) # 80003634 <consputc>
    80003d28:	f31ff06f          	j	80003c58 <__printf+0x440>
    80003d2c:	00030513          	mv	a0,t1
    80003d30:	00000097          	auipc	ra,0x0
    80003d34:	7bc080e7          	jalr	1980(ra) # 800044ec <acquire>
    80003d38:	b4dff06f          	j	80003884 <__printf+0x6c>
    80003d3c:	40c0053b          	negw	a0,a2
    80003d40:	00a00713          	li	a4,10
    80003d44:	02e576bb          	remuw	a3,a0,a4
    80003d48:	00001d97          	auipc	s11,0x1
    80003d4c:	620d8d93          	addi	s11,s11,1568 # 80005368 <digits>
    80003d50:	ff700593          	li	a1,-9
    80003d54:	02069693          	slli	a3,a3,0x20
    80003d58:	0206d693          	srli	a3,a3,0x20
    80003d5c:	00dd86b3          	add	a3,s11,a3
    80003d60:	0006c683          	lbu	a3,0(a3)
    80003d64:	02e557bb          	divuw	a5,a0,a4
    80003d68:	f8d40023          	sb	a3,-128(s0)
    80003d6c:	10b65e63          	bge	a2,a1,80003e88 <__printf+0x670>
    80003d70:	06300593          	li	a1,99
    80003d74:	02e7f6bb          	remuw	a3,a5,a4
    80003d78:	02069693          	slli	a3,a3,0x20
    80003d7c:	0206d693          	srli	a3,a3,0x20
    80003d80:	00dd86b3          	add	a3,s11,a3
    80003d84:	0006c683          	lbu	a3,0(a3)
    80003d88:	02e7d73b          	divuw	a4,a5,a4
    80003d8c:	00200793          	li	a5,2
    80003d90:	f8d400a3          	sb	a3,-127(s0)
    80003d94:	bca5ece3          	bltu	a1,a0,8000396c <__printf+0x154>
    80003d98:	ce5ff06f          	j	80003a7c <__printf+0x264>
    80003d9c:	40e007bb          	negw	a5,a4
    80003da0:	00001d97          	auipc	s11,0x1
    80003da4:	5c8d8d93          	addi	s11,s11,1480 # 80005368 <digits>
    80003da8:	00f7f693          	andi	a3,a5,15
    80003dac:	00dd86b3          	add	a3,s11,a3
    80003db0:	0006c583          	lbu	a1,0(a3)
    80003db4:	ff100613          	li	a2,-15
    80003db8:	0047d69b          	srliw	a3,a5,0x4
    80003dbc:	f8b40023          	sb	a1,-128(s0)
    80003dc0:	0047d59b          	srliw	a1,a5,0x4
    80003dc4:	0ac75e63          	bge	a4,a2,80003e80 <__printf+0x668>
    80003dc8:	00f6f693          	andi	a3,a3,15
    80003dcc:	00dd86b3          	add	a3,s11,a3
    80003dd0:	0006c603          	lbu	a2,0(a3)
    80003dd4:	00f00693          	li	a3,15
    80003dd8:	0087d79b          	srliw	a5,a5,0x8
    80003ddc:	f8c400a3          	sb	a2,-127(s0)
    80003de0:	d8b6e4e3          	bltu	a3,a1,80003b68 <__printf+0x350>
    80003de4:	00200793          	li	a5,2
    80003de8:	e2dff06f          	j	80003c14 <__printf+0x3fc>
    80003dec:	00001c97          	auipc	s9,0x1
    80003df0:	55cc8c93          	addi	s9,s9,1372 # 80005348 <_ZZ8printIntmE6digits+0x148>
    80003df4:	02800513          	li	a0,40
    80003df8:	ef1ff06f          	j	80003ce8 <__printf+0x4d0>
    80003dfc:	00700793          	li	a5,7
    80003e00:	00600c93          	li	s9,6
    80003e04:	e0dff06f          	j	80003c10 <__printf+0x3f8>
    80003e08:	00700793          	li	a5,7
    80003e0c:	00600c93          	li	s9,6
    80003e10:	c69ff06f          	j	80003a78 <__printf+0x260>
    80003e14:	00300793          	li	a5,3
    80003e18:	00200c93          	li	s9,2
    80003e1c:	c5dff06f          	j	80003a78 <__printf+0x260>
    80003e20:	00300793          	li	a5,3
    80003e24:	00200c93          	li	s9,2
    80003e28:	de9ff06f          	j	80003c10 <__printf+0x3f8>
    80003e2c:	00400793          	li	a5,4
    80003e30:	00300c93          	li	s9,3
    80003e34:	dddff06f          	j	80003c10 <__printf+0x3f8>
    80003e38:	00400793          	li	a5,4
    80003e3c:	00300c93          	li	s9,3
    80003e40:	c39ff06f          	j	80003a78 <__printf+0x260>
    80003e44:	00500793          	li	a5,5
    80003e48:	00400c93          	li	s9,4
    80003e4c:	c2dff06f          	j	80003a78 <__printf+0x260>
    80003e50:	00500793          	li	a5,5
    80003e54:	00400c93          	li	s9,4
    80003e58:	db9ff06f          	j	80003c10 <__printf+0x3f8>
    80003e5c:	00600793          	li	a5,6
    80003e60:	00500c93          	li	s9,5
    80003e64:	dadff06f          	j	80003c10 <__printf+0x3f8>
    80003e68:	00600793          	li	a5,6
    80003e6c:	00500c93          	li	s9,5
    80003e70:	c09ff06f          	j	80003a78 <__printf+0x260>
    80003e74:	00800793          	li	a5,8
    80003e78:	00700c93          	li	s9,7
    80003e7c:	bfdff06f          	j	80003a78 <__printf+0x260>
    80003e80:	00100793          	li	a5,1
    80003e84:	d91ff06f          	j	80003c14 <__printf+0x3fc>
    80003e88:	00100793          	li	a5,1
    80003e8c:	bf1ff06f          	j	80003a7c <__printf+0x264>
    80003e90:	00900793          	li	a5,9
    80003e94:	00800c93          	li	s9,8
    80003e98:	be1ff06f          	j	80003a78 <__printf+0x260>
    80003e9c:	00001517          	auipc	a0,0x1
    80003ea0:	4b450513          	addi	a0,a0,1204 # 80005350 <_ZZ8printIntmE6digits+0x150>
    80003ea4:	00000097          	auipc	ra,0x0
    80003ea8:	918080e7          	jalr	-1768(ra) # 800037bc <panic>

0000000080003eac <printfinit>:
    80003eac:	fe010113          	addi	sp,sp,-32
    80003eb0:	00813823          	sd	s0,16(sp)
    80003eb4:	00913423          	sd	s1,8(sp)
    80003eb8:	00113c23          	sd	ra,24(sp)
    80003ebc:	02010413          	addi	s0,sp,32
    80003ec0:	00003497          	auipc	s1,0x3
    80003ec4:	4a048493          	addi	s1,s1,1184 # 80007360 <pr>
    80003ec8:	00048513          	mv	a0,s1
    80003ecc:	00001597          	auipc	a1,0x1
    80003ed0:	49458593          	addi	a1,a1,1172 # 80005360 <_ZZ8printIntmE6digits+0x160>
    80003ed4:	00000097          	auipc	ra,0x0
    80003ed8:	5f4080e7          	jalr	1524(ra) # 800044c8 <initlock>
    80003edc:	01813083          	ld	ra,24(sp)
    80003ee0:	01013403          	ld	s0,16(sp)
    80003ee4:	0004ac23          	sw	zero,24(s1)
    80003ee8:	00813483          	ld	s1,8(sp)
    80003eec:	02010113          	addi	sp,sp,32
    80003ef0:	00008067          	ret

0000000080003ef4 <uartinit>:
    80003ef4:	ff010113          	addi	sp,sp,-16
    80003ef8:	00813423          	sd	s0,8(sp)
    80003efc:	01010413          	addi	s0,sp,16
    80003f00:	100007b7          	lui	a5,0x10000
    80003f04:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003f08:	f8000713          	li	a4,-128
    80003f0c:	00e781a3          	sb	a4,3(a5)
    80003f10:	00300713          	li	a4,3
    80003f14:	00e78023          	sb	a4,0(a5)
    80003f18:	000780a3          	sb	zero,1(a5)
    80003f1c:	00e781a3          	sb	a4,3(a5)
    80003f20:	00700693          	li	a3,7
    80003f24:	00d78123          	sb	a3,2(a5)
    80003f28:	00e780a3          	sb	a4,1(a5)
    80003f2c:	00813403          	ld	s0,8(sp)
    80003f30:	01010113          	addi	sp,sp,16
    80003f34:	00008067          	ret

0000000080003f38 <uartputc>:
    80003f38:	00002797          	auipc	a5,0x2
    80003f3c:	1a07a783          	lw	a5,416(a5) # 800060d8 <panicked>
    80003f40:	00078463          	beqz	a5,80003f48 <uartputc+0x10>
    80003f44:	0000006f          	j	80003f44 <uartputc+0xc>
    80003f48:	fd010113          	addi	sp,sp,-48
    80003f4c:	02813023          	sd	s0,32(sp)
    80003f50:	00913c23          	sd	s1,24(sp)
    80003f54:	01213823          	sd	s2,16(sp)
    80003f58:	01313423          	sd	s3,8(sp)
    80003f5c:	02113423          	sd	ra,40(sp)
    80003f60:	03010413          	addi	s0,sp,48
    80003f64:	00002917          	auipc	s2,0x2
    80003f68:	17c90913          	addi	s2,s2,380 # 800060e0 <uart_tx_r>
    80003f6c:	00093783          	ld	a5,0(s2)
    80003f70:	00002497          	auipc	s1,0x2
    80003f74:	17848493          	addi	s1,s1,376 # 800060e8 <uart_tx_w>
    80003f78:	0004b703          	ld	a4,0(s1)
    80003f7c:	02078693          	addi	a3,a5,32
    80003f80:	00050993          	mv	s3,a0
    80003f84:	02e69c63          	bne	a3,a4,80003fbc <uartputc+0x84>
    80003f88:	00001097          	auipc	ra,0x1
    80003f8c:	834080e7          	jalr	-1996(ra) # 800047bc <push_on>
    80003f90:	00093783          	ld	a5,0(s2)
    80003f94:	0004b703          	ld	a4,0(s1)
    80003f98:	02078793          	addi	a5,a5,32
    80003f9c:	00e79463          	bne	a5,a4,80003fa4 <uartputc+0x6c>
    80003fa0:	0000006f          	j	80003fa0 <uartputc+0x68>
    80003fa4:	00001097          	auipc	ra,0x1
    80003fa8:	88c080e7          	jalr	-1908(ra) # 80004830 <pop_on>
    80003fac:	00093783          	ld	a5,0(s2)
    80003fb0:	0004b703          	ld	a4,0(s1)
    80003fb4:	02078693          	addi	a3,a5,32
    80003fb8:	fce688e3          	beq	a3,a4,80003f88 <uartputc+0x50>
    80003fbc:	01f77693          	andi	a3,a4,31
    80003fc0:	00003597          	auipc	a1,0x3
    80003fc4:	3c058593          	addi	a1,a1,960 # 80007380 <uart_tx_buf>
    80003fc8:	00d586b3          	add	a3,a1,a3
    80003fcc:	00170713          	addi	a4,a4,1
    80003fd0:	01368023          	sb	s3,0(a3)
    80003fd4:	00e4b023          	sd	a4,0(s1)
    80003fd8:	10000637          	lui	a2,0x10000
    80003fdc:	02f71063          	bne	a4,a5,80003ffc <uartputc+0xc4>
    80003fe0:	0340006f          	j	80004014 <uartputc+0xdc>
    80003fe4:	00074703          	lbu	a4,0(a4)
    80003fe8:	00f93023          	sd	a5,0(s2)
    80003fec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003ff0:	00093783          	ld	a5,0(s2)
    80003ff4:	0004b703          	ld	a4,0(s1)
    80003ff8:	00f70e63          	beq	a4,a5,80004014 <uartputc+0xdc>
    80003ffc:	00564683          	lbu	a3,5(a2)
    80004000:	01f7f713          	andi	a4,a5,31
    80004004:	00e58733          	add	a4,a1,a4
    80004008:	0206f693          	andi	a3,a3,32
    8000400c:	00178793          	addi	a5,a5,1
    80004010:	fc069ae3          	bnez	a3,80003fe4 <uartputc+0xac>
    80004014:	02813083          	ld	ra,40(sp)
    80004018:	02013403          	ld	s0,32(sp)
    8000401c:	01813483          	ld	s1,24(sp)
    80004020:	01013903          	ld	s2,16(sp)
    80004024:	00813983          	ld	s3,8(sp)
    80004028:	03010113          	addi	sp,sp,48
    8000402c:	00008067          	ret

0000000080004030 <uartputc_sync>:
    80004030:	ff010113          	addi	sp,sp,-16
    80004034:	00813423          	sd	s0,8(sp)
    80004038:	01010413          	addi	s0,sp,16
    8000403c:	00002717          	auipc	a4,0x2
    80004040:	09c72703          	lw	a4,156(a4) # 800060d8 <panicked>
    80004044:	02071663          	bnez	a4,80004070 <uartputc_sync+0x40>
    80004048:	00050793          	mv	a5,a0
    8000404c:	100006b7          	lui	a3,0x10000
    80004050:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004054:	02077713          	andi	a4,a4,32
    80004058:	fe070ce3          	beqz	a4,80004050 <uartputc_sync+0x20>
    8000405c:	0ff7f793          	andi	a5,a5,255
    80004060:	00f68023          	sb	a5,0(a3)
    80004064:	00813403          	ld	s0,8(sp)
    80004068:	01010113          	addi	sp,sp,16
    8000406c:	00008067          	ret
    80004070:	0000006f          	j	80004070 <uartputc_sync+0x40>

0000000080004074 <uartstart>:
    80004074:	ff010113          	addi	sp,sp,-16
    80004078:	00813423          	sd	s0,8(sp)
    8000407c:	01010413          	addi	s0,sp,16
    80004080:	00002617          	auipc	a2,0x2
    80004084:	06060613          	addi	a2,a2,96 # 800060e0 <uart_tx_r>
    80004088:	00002517          	auipc	a0,0x2
    8000408c:	06050513          	addi	a0,a0,96 # 800060e8 <uart_tx_w>
    80004090:	00063783          	ld	a5,0(a2)
    80004094:	00053703          	ld	a4,0(a0)
    80004098:	04f70263          	beq	a4,a5,800040dc <uartstart+0x68>
    8000409c:	100005b7          	lui	a1,0x10000
    800040a0:	00003817          	auipc	a6,0x3
    800040a4:	2e080813          	addi	a6,a6,736 # 80007380 <uart_tx_buf>
    800040a8:	01c0006f          	j	800040c4 <uartstart+0x50>
    800040ac:	0006c703          	lbu	a4,0(a3)
    800040b0:	00f63023          	sd	a5,0(a2)
    800040b4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800040b8:	00063783          	ld	a5,0(a2)
    800040bc:	00053703          	ld	a4,0(a0)
    800040c0:	00f70e63          	beq	a4,a5,800040dc <uartstart+0x68>
    800040c4:	01f7f713          	andi	a4,a5,31
    800040c8:	00e806b3          	add	a3,a6,a4
    800040cc:	0055c703          	lbu	a4,5(a1)
    800040d0:	00178793          	addi	a5,a5,1
    800040d4:	02077713          	andi	a4,a4,32
    800040d8:	fc071ae3          	bnez	a4,800040ac <uartstart+0x38>
    800040dc:	00813403          	ld	s0,8(sp)
    800040e0:	01010113          	addi	sp,sp,16
    800040e4:	00008067          	ret

00000000800040e8 <uartgetc>:
    800040e8:	ff010113          	addi	sp,sp,-16
    800040ec:	00813423          	sd	s0,8(sp)
    800040f0:	01010413          	addi	s0,sp,16
    800040f4:	10000737          	lui	a4,0x10000
    800040f8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800040fc:	0017f793          	andi	a5,a5,1
    80004100:	00078c63          	beqz	a5,80004118 <uartgetc+0x30>
    80004104:	00074503          	lbu	a0,0(a4)
    80004108:	0ff57513          	andi	a0,a0,255
    8000410c:	00813403          	ld	s0,8(sp)
    80004110:	01010113          	addi	sp,sp,16
    80004114:	00008067          	ret
    80004118:	fff00513          	li	a0,-1
    8000411c:	ff1ff06f          	j	8000410c <uartgetc+0x24>

0000000080004120 <uartintr>:
    80004120:	100007b7          	lui	a5,0x10000
    80004124:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004128:	0017f793          	andi	a5,a5,1
    8000412c:	0a078463          	beqz	a5,800041d4 <uartintr+0xb4>
    80004130:	fe010113          	addi	sp,sp,-32
    80004134:	00813823          	sd	s0,16(sp)
    80004138:	00913423          	sd	s1,8(sp)
    8000413c:	00113c23          	sd	ra,24(sp)
    80004140:	02010413          	addi	s0,sp,32
    80004144:	100004b7          	lui	s1,0x10000
    80004148:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000414c:	0ff57513          	andi	a0,a0,255
    80004150:	fffff097          	auipc	ra,0xfffff
    80004154:	534080e7          	jalr	1332(ra) # 80003684 <consoleintr>
    80004158:	0054c783          	lbu	a5,5(s1)
    8000415c:	0017f793          	andi	a5,a5,1
    80004160:	fe0794e3          	bnez	a5,80004148 <uartintr+0x28>
    80004164:	00002617          	auipc	a2,0x2
    80004168:	f7c60613          	addi	a2,a2,-132 # 800060e0 <uart_tx_r>
    8000416c:	00002517          	auipc	a0,0x2
    80004170:	f7c50513          	addi	a0,a0,-132 # 800060e8 <uart_tx_w>
    80004174:	00063783          	ld	a5,0(a2)
    80004178:	00053703          	ld	a4,0(a0)
    8000417c:	04f70263          	beq	a4,a5,800041c0 <uartintr+0xa0>
    80004180:	100005b7          	lui	a1,0x10000
    80004184:	00003817          	auipc	a6,0x3
    80004188:	1fc80813          	addi	a6,a6,508 # 80007380 <uart_tx_buf>
    8000418c:	01c0006f          	j	800041a8 <uartintr+0x88>
    80004190:	0006c703          	lbu	a4,0(a3)
    80004194:	00f63023          	sd	a5,0(a2)
    80004198:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000419c:	00063783          	ld	a5,0(a2)
    800041a0:	00053703          	ld	a4,0(a0)
    800041a4:	00f70e63          	beq	a4,a5,800041c0 <uartintr+0xa0>
    800041a8:	01f7f713          	andi	a4,a5,31
    800041ac:	00e806b3          	add	a3,a6,a4
    800041b0:	0055c703          	lbu	a4,5(a1)
    800041b4:	00178793          	addi	a5,a5,1
    800041b8:	02077713          	andi	a4,a4,32
    800041bc:	fc071ae3          	bnez	a4,80004190 <uartintr+0x70>
    800041c0:	01813083          	ld	ra,24(sp)
    800041c4:	01013403          	ld	s0,16(sp)
    800041c8:	00813483          	ld	s1,8(sp)
    800041cc:	02010113          	addi	sp,sp,32
    800041d0:	00008067          	ret
    800041d4:	00002617          	auipc	a2,0x2
    800041d8:	f0c60613          	addi	a2,a2,-244 # 800060e0 <uart_tx_r>
    800041dc:	00002517          	auipc	a0,0x2
    800041e0:	f0c50513          	addi	a0,a0,-244 # 800060e8 <uart_tx_w>
    800041e4:	00063783          	ld	a5,0(a2)
    800041e8:	00053703          	ld	a4,0(a0)
    800041ec:	04f70263          	beq	a4,a5,80004230 <uartintr+0x110>
    800041f0:	100005b7          	lui	a1,0x10000
    800041f4:	00003817          	auipc	a6,0x3
    800041f8:	18c80813          	addi	a6,a6,396 # 80007380 <uart_tx_buf>
    800041fc:	01c0006f          	j	80004218 <uartintr+0xf8>
    80004200:	0006c703          	lbu	a4,0(a3)
    80004204:	00f63023          	sd	a5,0(a2)
    80004208:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000420c:	00063783          	ld	a5,0(a2)
    80004210:	00053703          	ld	a4,0(a0)
    80004214:	02f70063          	beq	a4,a5,80004234 <uartintr+0x114>
    80004218:	01f7f713          	andi	a4,a5,31
    8000421c:	00e806b3          	add	a3,a6,a4
    80004220:	0055c703          	lbu	a4,5(a1)
    80004224:	00178793          	addi	a5,a5,1
    80004228:	02077713          	andi	a4,a4,32
    8000422c:	fc071ae3          	bnez	a4,80004200 <uartintr+0xe0>
    80004230:	00008067          	ret
    80004234:	00008067          	ret

0000000080004238 <kinit>:
    80004238:	fc010113          	addi	sp,sp,-64
    8000423c:	02913423          	sd	s1,40(sp)
    80004240:	fffff7b7          	lui	a5,0xfffff
    80004244:	00004497          	auipc	s1,0x4
    80004248:	16b48493          	addi	s1,s1,363 # 800083af <end+0xfff>
    8000424c:	02813823          	sd	s0,48(sp)
    80004250:	01313c23          	sd	s3,24(sp)
    80004254:	00f4f4b3          	and	s1,s1,a5
    80004258:	02113c23          	sd	ra,56(sp)
    8000425c:	03213023          	sd	s2,32(sp)
    80004260:	01413823          	sd	s4,16(sp)
    80004264:	01513423          	sd	s5,8(sp)
    80004268:	04010413          	addi	s0,sp,64
    8000426c:	000017b7          	lui	a5,0x1
    80004270:	01100993          	li	s3,17
    80004274:	00f487b3          	add	a5,s1,a5
    80004278:	01b99993          	slli	s3,s3,0x1b
    8000427c:	06f9e063          	bltu	s3,a5,800042dc <kinit+0xa4>
    80004280:	00003a97          	auipc	s5,0x3
    80004284:	130a8a93          	addi	s5,s5,304 # 800073b0 <end>
    80004288:	0754ec63          	bltu	s1,s5,80004300 <kinit+0xc8>
    8000428c:	0734fa63          	bgeu	s1,s3,80004300 <kinit+0xc8>
    80004290:	00088a37          	lui	s4,0x88
    80004294:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004298:	00002917          	auipc	s2,0x2
    8000429c:	e5890913          	addi	s2,s2,-424 # 800060f0 <kmem>
    800042a0:	00ca1a13          	slli	s4,s4,0xc
    800042a4:	0140006f          	j	800042b8 <kinit+0x80>
    800042a8:	000017b7          	lui	a5,0x1
    800042ac:	00f484b3          	add	s1,s1,a5
    800042b0:	0554e863          	bltu	s1,s5,80004300 <kinit+0xc8>
    800042b4:	0534f663          	bgeu	s1,s3,80004300 <kinit+0xc8>
    800042b8:	00001637          	lui	a2,0x1
    800042bc:	00100593          	li	a1,1
    800042c0:	00048513          	mv	a0,s1
    800042c4:	00000097          	auipc	ra,0x0
    800042c8:	5e4080e7          	jalr	1508(ra) # 800048a8 <__memset>
    800042cc:	00093783          	ld	a5,0(s2)
    800042d0:	00f4b023          	sd	a5,0(s1)
    800042d4:	00993023          	sd	s1,0(s2)
    800042d8:	fd4498e3          	bne	s1,s4,800042a8 <kinit+0x70>
    800042dc:	03813083          	ld	ra,56(sp)
    800042e0:	03013403          	ld	s0,48(sp)
    800042e4:	02813483          	ld	s1,40(sp)
    800042e8:	02013903          	ld	s2,32(sp)
    800042ec:	01813983          	ld	s3,24(sp)
    800042f0:	01013a03          	ld	s4,16(sp)
    800042f4:	00813a83          	ld	s5,8(sp)
    800042f8:	04010113          	addi	sp,sp,64
    800042fc:	00008067          	ret
    80004300:	00001517          	auipc	a0,0x1
    80004304:	08050513          	addi	a0,a0,128 # 80005380 <digits+0x18>
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	4b4080e7          	jalr	1204(ra) # 800037bc <panic>

0000000080004310 <freerange>:
    80004310:	fc010113          	addi	sp,sp,-64
    80004314:	000017b7          	lui	a5,0x1
    80004318:	02913423          	sd	s1,40(sp)
    8000431c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004320:	009504b3          	add	s1,a0,s1
    80004324:	fffff537          	lui	a0,0xfffff
    80004328:	02813823          	sd	s0,48(sp)
    8000432c:	02113c23          	sd	ra,56(sp)
    80004330:	03213023          	sd	s2,32(sp)
    80004334:	01313c23          	sd	s3,24(sp)
    80004338:	01413823          	sd	s4,16(sp)
    8000433c:	01513423          	sd	s5,8(sp)
    80004340:	01613023          	sd	s6,0(sp)
    80004344:	04010413          	addi	s0,sp,64
    80004348:	00a4f4b3          	and	s1,s1,a0
    8000434c:	00f487b3          	add	a5,s1,a5
    80004350:	06f5e463          	bltu	a1,a5,800043b8 <freerange+0xa8>
    80004354:	00003a97          	auipc	s5,0x3
    80004358:	05ca8a93          	addi	s5,s5,92 # 800073b0 <end>
    8000435c:	0954e263          	bltu	s1,s5,800043e0 <freerange+0xd0>
    80004360:	01100993          	li	s3,17
    80004364:	01b99993          	slli	s3,s3,0x1b
    80004368:	0734fc63          	bgeu	s1,s3,800043e0 <freerange+0xd0>
    8000436c:	00058a13          	mv	s4,a1
    80004370:	00002917          	auipc	s2,0x2
    80004374:	d8090913          	addi	s2,s2,-640 # 800060f0 <kmem>
    80004378:	00002b37          	lui	s6,0x2
    8000437c:	0140006f          	j	80004390 <freerange+0x80>
    80004380:	000017b7          	lui	a5,0x1
    80004384:	00f484b3          	add	s1,s1,a5
    80004388:	0554ec63          	bltu	s1,s5,800043e0 <freerange+0xd0>
    8000438c:	0534fa63          	bgeu	s1,s3,800043e0 <freerange+0xd0>
    80004390:	00001637          	lui	a2,0x1
    80004394:	00100593          	li	a1,1
    80004398:	00048513          	mv	a0,s1
    8000439c:	00000097          	auipc	ra,0x0
    800043a0:	50c080e7          	jalr	1292(ra) # 800048a8 <__memset>
    800043a4:	00093703          	ld	a4,0(s2)
    800043a8:	016487b3          	add	a5,s1,s6
    800043ac:	00e4b023          	sd	a4,0(s1)
    800043b0:	00993023          	sd	s1,0(s2)
    800043b4:	fcfa76e3          	bgeu	s4,a5,80004380 <freerange+0x70>
    800043b8:	03813083          	ld	ra,56(sp)
    800043bc:	03013403          	ld	s0,48(sp)
    800043c0:	02813483          	ld	s1,40(sp)
    800043c4:	02013903          	ld	s2,32(sp)
    800043c8:	01813983          	ld	s3,24(sp)
    800043cc:	01013a03          	ld	s4,16(sp)
    800043d0:	00813a83          	ld	s5,8(sp)
    800043d4:	00013b03          	ld	s6,0(sp)
    800043d8:	04010113          	addi	sp,sp,64
    800043dc:	00008067          	ret
    800043e0:	00001517          	auipc	a0,0x1
    800043e4:	fa050513          	addi	a0,a0,-96 # 80005380 <digits+0x18>
    800043e8:	fffff097          	auipc	ra,0xfffff
    800043ec:	3d4080e7          	jalr	980(ra) # 800037bc <panic>

00000000800043f0 <kfree>:
    800043f0:	fe010113          	addi	sp,sp,-32
    800043f4:	00813823          	sd	s0,16(sp)
    800043f8:	00113c23          	sd	ra,24(sp)
    800043fc:	00913423          	sd	s1,8(sp)
    80004400:	02010413          	addi	s0,sp,32
    80004404:	03451793          	slli	a5,a0,0x34
    80004408:	04079c63          	bnez	a5,80004460 <kfree+0x70>
    8000440c:	00003797          	auipc	a5,0x3
    80004410:	fa478793          	addi	a5,a5,-92 # 800073b0 <end>
    80004414:	00050493          	mv	s1,a0
    80004418:	04f56463          	bltu	a0,a5,80004460 <kfree+0x70>
    8000441c:	01100793          	li	a5,17
    80004420:	01b79793          	slli	a5,a5,0x1b
    80004424:	02f57e63          	bgeu	a0,a5,80004460 <kfree+0x70>
    80004428:	00001637          	lui	a2,0x1
    8000442c:	00100593          	li	a1,1
    80004430:	00000097          	auipc	ra,0x0
    80004434:	478080e7          	jalr	1144(ra) # 800048a8 <__memset>
    80004438:	00002797          	auipc	a5,0x2
    8000443c:	cb878793          	addi	a5,a5,-840 # 800060f0 <kmem>
    80004440:	0007b703          	ld	a4,0(a5)
    80004444:	01813083          	ld	ra,24(sp)
    80004448:	01013403          	ld	s0,16(sp)
    8000444c:	00e4b023          	sd	a4,0(s1)
    80004450:	0097b023          	sd	s1,0(a5)
    80004454:	00813483          	ld	s1,8(sp)
    80004458:	02010113          	addi	sp,sp,32
    8000445c:	00008067          	ret
    80004460:	00001517          	auipc	a0,0x1
    80004464:	f2050513          	addi	a0,a0,-224 # 80005380 <digits+0x18>
    80004468:	fffff097          	auipc	ra,0xfffff
    8000446c:	354080e7          	jalr	852(ra) # 800037bc <panic>

0000000080004470 <kalloc>:
    80004470:	fe010113          	addi	sp,sp,-32
    80004474:	00813823          	sd	s0,16(sp)
    80004478:	00913423          	sd	s1,8(sp)
    8000447c:	00113c23          	sd	ra,24(sp)
    80004480:	02010413          	addi	s0,sp,32
    80004484:	00002797          	auipc	a5,0x2
    80004488:	c6c78793          	addi	a5,a5,-916 # 800060f0 <kmem>
    8000448c:	0007b483          	ld	s1,0(a5)
    80004490:	02048063          	beqz	s1,800044b0 <kalloc+0x40>
    80004494:	0004b703          	ld	a4,0(s1)
    80004498:	00001637          	lui	a2,0x1
    8000449c:	00500593          	li	a1,5
    800044a0:	00048513          	mv	a0,s1
    800044a4:	00e7b023          	sd	a4,0(a5)
    800044a8:	00000097          	auipc	ra,0x0
    800044ac:	400080e7          	jalr	1024(ra) # 800048a8 <__memset>
    800044b0:	01813083          	ld	ra,24(sp)
    800044b4:	01013403          	ld	s0,16(sp)
    800044b8:	00048513          	mv	a0,s1
    800044bc:	00813483          	ld	s1,8(sp)
    800044c0:	02010113          	addi	sp,sp,32
    800044c4:	00008067          	ret

00000000800044c8 <initlock>:
    800044c8:	ff010113          	addi	sp,sp,-16
    800044cc:	00813423          	sd	s0,8(sp)
    800044d0:	01010413          	addi	s0,sp,16
    800044d4:	00813403          	ld	s0,8(sp)
    800044d8:	00b53423          	sd	a1,8(a0)
    800044dc:	00052023          	sw	zero,0(a0)
    800044e0:	00053823          	sd	zero,16(a0)
    800044e4:	01010113          	addi	sp,sp,16
    800044e8:	00008067          	ret

00000000800044ec <acquire>:
    800044ec:	fe010113          	addi	sp,sp,-32
    800044f0:	00813823          	sd	s0,16(sp)
    800044f4:	00913423          	sd	s1,8(sp)
    800044f8:	00113c23          	sd	ra,24(sp)
    800044fc:	01213023          	sd	s2,0(sp)
    80004500:	02010413          	addi	s0,sp,32
    80004504:	00050493          	mv	s1,a0
    80004508:	10002973          	csrr	s2,sstatus
    8000450c:	100027f3          	csrr	a5,sstatus
    80004510:	ffd7f793          	andi	a5,a5,-3
    80004514:	10079073          	csrw	sstatus,a5
    80004518:	fffff097          	auipc	ra,0xfffff
    8000451c:	8e0080e7          	jalr	-1824(ra) # 80002df8 <mycpu>
    80004520:	07852783          	lw	a5,120(a0)
    80004524:	06078e63          	beqz	a5,800045a0 <acquire+0xb4>
    80004528:	fffff097          	auipc	ra,0xfffff
    8000452c:	8d0080e7          	jalr	-1840(ra) # 80002df8 <mycpu>
    80004530:	07852783          	lw	a5,120(a0)
    80004534:	0004a703          	lw	a4,0(s1)
    80004538:	0017879b          	addiw	a5,a5,1
    8000453c:	06f52c23          	sw	a5,120(a0)
    80004540:	04071063          	bnez	a4,80004580 <acquire+0x94>
    80004544:	00100713          	li	a4,1
    80004548:	00070793          	mv	a5,a4
    8000454c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004550:	0007879b          	sext.w	a5,a5
    80004554:	fe079ae3          	bnez	a5,80004548 <acquire+0x5c>
    80004558:	0ff0000f          	fence
    8000455c:	fffff097          	auipc	ra,0xfffff
    80004560:	89c080e7          	jalr	-1892(ra) # 80002df8 <mycpu>
    80004564:	01813083          	ld	ra,24(sp)
    80004568:	01013403          	ld	s0,16(sp)
    8000456c:	00a4b823          	sd	a0,16(s1)
    80004570:	00013903          	ld	s2,0(sp)
    80004574:	00813483          	ld	s1,8(sp)
    80004578:	02010113          	addi	sp,sp,32
    8000457c:	00008067          	ret
    80004580:	0104b903          	ld	s2,16(s1)
    80004584:	fffff097          	auipc	ra,0xfffff
    80004588:	874080e7          	jalr	-1932(ra) # 80002df8 <mycpu>
    8000458c:	faa91ce3          	bne	s2,a0,80004544 <acquire+0x58>
    80004590:	00001517          	auipc	a0,0x1
    80004594:	df850513          	addi	a0,a0,-520 # 80005388 <digits+0x20>
    80004598:	fffff097          	auipc	ra,0xfffff
    8000459c:	224080e7          	jalr	548(ra) # 800037bc <panic>
    800045a0:	00195913          	srli	s2,s2,0x1
    800045a4:	fffff097          	auipc	ra,0xfffff
    800045a8:	854080e7          	jalr	-1964(ra) # 80002df8 <mycpu>
    800045ac:	00197913          	andi	s2,s2,1
    800045b0:	07252e23          	sw	s2,124(a0)
    800045b4:	f75ff06f          	j	80004528 <acquire+0x3c>

00000000800045b8 <release>:
    800045b8:	fe010113          	addi	sp,sp,-32
    800045bc:	00813823          	sd	s0,16(sp)
    800045c0:	00113c23          	sd	ra,24(sp)
    800045c4:	00913423          	sd	s1,8(sp)
    800045c8:	01213023          	sd	s2,0(sp)
    800045cc:	02010413          	addi	s0,sp,32
    800045d0:	00052783          	lw	a5,0(a0)
    800045d4:	00079a63          	bnez	a5,800045e8 <release+0x30>
    800045d8:	00001517          	auipc	a0,0x1
    800045dc:	db850513          	addi	a0,a0,-584 # 80005390 <digits+0x28>
    800045e0:	fffff097          	auipc	ra,0xfffff
    800045e4:	1dc080e7          	jalr	476(ra) # 800037bc <panic>
    800045e8:	01053903          	ld	s2,16(a0)
    800045ec:	00050493          	mv	s1,a0
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	808080e7          	jalr	-2040(ra) # 80002df8 <mycpu>
    800045f8:	fea910e3          	bne	s2,a0,800045d8 <release+0x20>
    800045fc:	0004b823          	sd	zero,16(s1)
    80004600:	0ff0000f          	fence
    80004604:	0f50000f          	fence	iorw,ow
    80004608:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000460c:	ffffe097          	auipc	ra,0xffffe
    80004610:	7ec080e7          	jalr	2028(ra) # 80002df8 <mycpu>
    80004614:	100027f3          	csrr	a5,sstatus
    80004618:	0027f793          	andi	a5,a5,2
    8000461c:	04079a63          	bnez	a5,80004670 <release+0xb8>
    80004620:	07852783          	lw	a5,120(a0)
    80004624:	02f05e63          	blez	a5,80004660 <release+0xa8>
    80004628:	fff7871b          	addiw	a4,a5,-1
    8000462c:	06e52c23          	sw	a4,120(a0)
    80004630:	00071c63          	bnez	a4,80004648 <release+0x90>
    80004634:	07c52783          	lw	a5,124(a0)
    80004638:	00078863          	beqz	a5,80004648 <release+0x90>
    8000463c:	100027f3          	csrr	a5,sstatus
    80004640:	0027e793          	ori	a5,a5,2
    80004644:	10079073          	csrw	sstatus,a5
    80004648:	01813083          	ld	ra,24(sp)
    8000464c:	01013403          	ld	s0,16(sp)
    80004650:	00813483          	ld	s1,8(sp)
    80004654:	00013903          	ld	s2,0(sp)
    80004658:	02010113          	addi	sp,sp,32
    8000465c:	00008067          	ret
    80004660:	00001517          	auipc	a0,0x1
    80004664:	d5050513          	addi	a0,a0,-688 # 800053b0 <digits+0x48>
    80004668:	fffff097          	auipc	ra,0xfffff
    8000466c:	154080e7          	jalr	340(ra) # 800037bc <panic>
    80004670:	00001517          	auipc	a0,0x1
    80004674:	d2850513          	addi	a0,a0,-728 # 80005398 <digits+0x30>
    80004678:	fffff097          	auipc	ra,0xfffff
    8000467c:	144080e7          	jalr	324(ra) # 800037bc <panic>

0000000080004680 <holding>:
    80004680:	00052783          	lw	a5,0(a0)
    80004684:	00079663          	bnez	a5,80004690 <holding+0x10>
    80004688:	00000513          	li	a0,0
    8000468c:	00008067          	ret
    80004690:	fe010113          	addi	sp,sp,-32
    80004694:	00813823          	sd	s0,16(sp)
    80004698:	00913423          	sd	s1,8(sp)
    8000469c:	00113c23          	sd	ra,24(sp)
    800046a0:	02010413          	addi	s0,sp,32
    800046a4:	01053483          	ld	s1,16(a0)
    800046a8:	ffffe097          	auipc	ra,0xffffe
    800046ac:	750080e7          	jalr	1872(ra) # 80002df8 <mycpu>
    800046b0:	01813083          	ld	ra,24(sp)
    800046b4:	01013403          	ld	s0,16(sp)
    800046b8:	40a48533          	sub	a0,s1,a0
    800046bc:	00153513          	seqz	a0,a0
    800046c0:	00813483          	ld	s1,8(sp)
    800046c4:	02010113          	addi	sp,sp,32
    800046c8:	00008067          	ret

00000000800046cc <push_off>:
    800046cc:	fe010113          	addi	sp,sp,-32
    800046d0:	00813823          	sd	s0,16(sp)
    800046d4:	00113c23          	sd	ra,24(sp)
    800046d8:	00913423          	sd	s1,8(sp)
    800046dc:	02010413          	addi	s0,sp,32
    800046e0:	100024f3          	csrr	s1,sstatus
    800046e4:	100027f3          	csrr	a5,sstatus
    800046e8:	ffd7f793          	andi	a5,a5,-3
    800046ec:	10079073          	csrw	sstatus,a5
    800046f0:	ffffe097          	auipc	ra,0xffffe
    800046f4:	708080e7          	jalr	1800(ra) # 80002df8 <mycpu>
    800046f8:	07852783          	lw	a5,120(a0)
    800046fc:	02078663          	beqz	a5,80004728 <push_off+0x5c>
    80004700:	ffffe097          	auipc	ra,0xffffe
    80004704:	6f8080e7          	jalr	1784(ra) # 80002df8 <mycpu>
    80004708:	07852783          	lw	a5,120(a0)
    8000470c:	01813083          	ld	ra,24(sp)
    80004710:	01013403          	ld	s0,16(sp)
    80004714:	0017879b          	addiw	a5,a5,1
    80004718:	06f52c23          	sw	a5,120(a0)
    8000471c:	00813483          	ld	s1,8(sp)
    80004720:	02010113          	addi	sp,sp,32
    80004724:	00008067          	ret
    80004728:	0014d493          	srli	s1,s1,0x1
    8000472c:	ffffe097          	auipc	ra,0xffffe
    80004730:	6cc080e7          	jalr	1740(ra) # 80002df8 <mycpu>
    80004734:	0014f493          	andi	s1,s1,1
    80004738:	06952e23          	sw	s1,124(a0)
    8000473c:	fc5ff06f          	j	80004700 <push_off+0x34>

0000000080004740 <pop_off>:
    80004740:	ff010113          	addi	sp,sp,-16
    80004744:	00813023          	sd	s0,0(sp)
    80004748:	00113423          	sd	ra,8(sp)
    8000474c:	01010413          	addi	s0,sp,16
    80004750:	ffffe097          	auipc	ra,0xffffe
    80004754:	6a8080e7          	jalr	1704(ra) # 80002df8 <mycpu>
    80004758:	100027f3          	csrr	a5,sstatus
    8000475c:	0027f793          	andi	a5,a5,2
    80004760:	04079663          	bnez	a5,800047ac <pop_off+0x6c>
    80004764:	07852783          	lw	a5,120(a0)
    80004768:	02f05a63          	blez	a5,8000479c <pop_off+0x5c>
    8000476c:	fff7871b          	addiw	a4,a5,-1
    80004770:	06e52c23          	sw	a4,120(a0)
    80004774:	00071c63          	bnez	a4,8000478c <pop_off+0x4c>
    80004778:	07c52783          	lw	a5,124(a0)
    8000477c:	00078863          	beqz	a5,8000478c <pop_off+0x4c>
    80004780:	100027f3          	csrr	a5,sstatus
    80004784:	0027e793          	ori	a5,a5,2
    80004788:	10079073          	csrw	sstatus,a5
    8000478c:	00813083          	ld	ra,8(sp)
    80004790:	00013403          	ld	s0,0(sp)
    80004794:	01010113          	addi	sp,sp,16
    80004798:	00008067          	ret
    8000479c:	00001517          	auipc	a0,0x1
    800047a0:	c1450513          	addi	a0,a0,-1004 # 800053b0 <digits+0x48>
    800047a4:	fffff097          	auipc	ra,0xfffff
    800047a8:	018080e7          	jalr	24(ra) # 800037bc <panic>
    800047ac:	00001517          	auipc	a0,0x1
    800047b0:	bec50513          	addi	a0,a0,-1044 # 80005398 <digits+0x30>
    800047b4:	fffff097          	auipc	ra,0xfffff
    800047b8:	008080e7          	jalr	8(ra) # 800037bc <panic>

00000000800047bc <push_on>:
    800047bc:	fe010113          	addi	sp,sp,-32
    800047c0:	00813823          	sd	s0,16(sp)
    800047c4:	00113c23          	sd	ra,24(sp)
    800047c8:	00913423          	sd	s1,8(sp)
    800047cc:	02010413          	addi	s0,sp,32
    800047d0:	100024f3          	csrr	s1,sstatus
    800047d4:	100027f3          	csrr	a5,sstatus
    800047d8:	0027e793          	ori	a5,a5,2
    800047dc:	10079073          	csrw	sstatus,a5
    800047e0:	ffffe097          	auipc	ra,0xffffe
    800047e4:	618080e7          	jalr	1560(ra) # 80002df8 <mycpu>
    800047e8:	07852783          	lw	a5,120(a0)
    800047ec:	02078663          	beqz	a5,80004818 <push_on+0x5c>
    800047f0:	ffffe097          	auipc	ra,0xffffe
    800047f4:	608080e7          	jalr	1544(ra) # 80002df8 <mycpu>
    800047f8:	07852783          	lw	a5,120(a0)
    800047fc:	01813083          	ld	ra,24(sp)
    80004800:	01013403          	ld	s0,16(sp)
    80004804:	0017879b          	addiw	a5,a5,1
    80004808:	06f52c23          	sw	a5,120(a0)
    8000480c:	00813483          	ld	s1,8(sp)
    80004810:	02010113          	addi	sp,sp,32
    80004814:	00008067          	ret
    80004818:	0014d493          	srli	s1,s1,0x1
    8000481c:	ffffe097          	auipc	ra,0xffffe
    80004820:	5dc080e7          	jalr	1500(ra) # 80002df8 <mycpu>
    80004824:	0014f493          	andi	s1,s1,1
    80004828:	06952e23          	sw	s1,124(a0)
    8000482c:	fc5ff06f          	j	800047f0 <push_on+0x34>

0000000080004830 <pop_on>:
    80004830:	ff010113          	addi	sp,sp,-16
    80004834:	00813023          	sd	s0,0(sp)
    80004838:	00113423          	sd	ra,8(sp)
    8000483c:	01010413          	addi	s0,sp,16
    80004840:	ffffe097          	auipc	ra,0xffffe
    80004844:	5b8080e7          	jalr	1464(ra) # 80002df8 <mycpu>
    80004848:	100027f3          	csrr	a5,sstatus
    8000484c:	0027f793          	andi	a5,a5,2
    80004850:	04078463          	beqz	a5,80004898 <pop_on+0x68>
    80004854:	07852783          	lw	a5,120(a0)
    80004858:	02f05863          	blez	a5,80004888 <pop_on+0x58>
    8000485c:	fff7879b          	addiw	a5,a5,-1
    80004860:	06f52c23          	sw	a5,120(a0)
    80004864:	07853783          	ld	a5,120(a0)
    80004868:	00079863          	bnez	a5,80004878 <pop_on+0x48>
    8000486c:	100027f3          	csrr	a5,sstatus
    80004870:	ffd7f793          	andi	a5,a5,-3
    80004874:	10079073          	csrw	sstatus,a5
    80004878:	00813083          	ld	ra,8(sp)
    8000487c:	00013403          	ld	s0,0(sp)
    80004880:	01010113          	addi	sp,sp,16
    80004884:	00008067          	ret
    80004888:	00001517          	auipc	a0,0x1
    8000488c:	b5050513          	addi	a0,a0,-1200 # 800053d8 <digits+0x70>
    80004890:	fffff097          	auipc	ra,0xfffff
    80004894:	f2c080e7          	jalr	-212(ra) # 800037bc <panic>
    80004898:	00001517          	auipc	a0,0x1
    8000489c:	b2050513          	addi	a0,a0,-1248 # 800053b8 <digits+0x50>
    800048a0:	fffff097          	auipc	ra,0xfffff
    800048a4:	f1c080e7          	jalr	-228(ra) # 800037bc <panic>

00000000800048a8 <__memset>:
    800048a8:	ff010113          	addi	sp,sp,-16
    800048ac:	00813423          	sd	s0,8(sp)
    800048b0:	01010413          	addi	s0,sp,16
    800048b4:	1a060e63          	beqz	a2,80004a70 <__memset+0x1c8>
    800048b8:	40a007b3          	neg	a5,a0
    800048bc:	0077f793          	andi	a5,a5,7
    800048c0:	00778693          	addi	a3,a5,7
    800048c4:	00b00813          	li	a6,11
    800048c8:	0ff5f593          	andi	a1,a1,255
    800048cc:	fff6071b          	addiw	a4,a2,-1
    800048d0:	1b06e663          	bltu	a3,a6,80004a7c <__memset+0x1d4>
    800048d4:	1cd76463          	bltu	a4,a3,80004a9c <__memset+0x1f4>
    800048d8:	1a078e63          	beqz	a5,80004a94 <__memset+0x1ec>
    800048dc:	00b50023          	sb	a1,0(a0)
    800048e0:	00100713          	li	a4,1
    800048e4:	1ae78463          	beq	a5,a4,80004a8c <__memset+0x1e4>
    800048e8:	00b500a3          	sb	a1,1(a0)
    800048ec:	00200713          	li	a4,2
    800048f0:	1ae78a63          	beq	a5,a4,80004aa4 <__memset+0x1fc>
    800048f4:	00b50123          	sb	a1,2(a0)
    800048f8:	00300713          	li	a4,3
    800048fc:	18e78463          	beq	a5,a4,80004a84 <__memset+0x1dc>
    80004900:	00b501a3          	sb	a1,3(a0)
    80004904:	00400713          	li	a4,4
    80004908:	1ae78263          	beq	a5,a4,80004aac <__memset+0x204>
    8000490c:	00b50223          	sb	a1,4(a0)
    80004910:	00500713          	li	a4,5
    80004914:	1ae78063          	beq	a5,a4,80004ab4 <__memset+0x20c>
    80004918:	00b502a3          	sb	a1,5(a0)
    8000491c:	00700713          	li	a4,7
    80004920:	18e79e63          	bne	a5,a4,80004abc <__memset+0x214>
    80004924:	00b50323          	sb	a1,6(a0)
    80004928:	00700e93          	li	t4,7
    8000492c:	00859713          	slli	a4,a1,0x8
    80004930:	00e5e733          	or	a4,a1,a4
    80004934:	01059e13          	slli	t3,a1,0x10
    80004938:	01c76e33          	or	t3,a4,t3
    8000493c:	01859313          	slli	t1,a1,0x18
    80004940:	006e6333          	or	t1,t3,t1
    80004944:	02059893          	slli	a7,a1,0x20
    80004948:	40f60e3b          	subw	t3,a2,a5
    8000494c:	011368b3          	or	a7,t1,a7
    80004950:	02859813          	slli	a6,a1,0x28
    80004954:	0108e833          	or	a6,a7,a6
    80004958:	03059693          	slli	a3,a1,0x30
    8000495c:	003e589b          	srliw	a7,t3,0x3
    80004960:	00d866b3          	or	a3,a6,a3
    80004964:	03859713          	slli	a4,a1,0x38
    80004968:	00389813          	slli	a6,a7,0x3
    8000496c:	00f507b3          	add	a5,a0,a5
    80004970:	00e6e733          	or	a4,a3,a4
    80004974:	000e089b          	sext.w	a7,t3
    80004978:	00f806b3          	add	a3,a6,a5
    8000497c:	00e7b023          	sd	a4,0(a5)
    80004980:	00878793          	addi	a5,a5,8
    80004984:	fed79ce3          	bne	a5,a3,8000497c <__memset+0xd4>
    80004988:	ff8e7793          	andi	a5,t3,-8
    8000498c:	0007871b          	sext.w	a4,a5
    80004990:	01d787bb          	addw	a5,a5,t4
    80004994:	0ce88e63          	beq	a7,a4,80004a70 <__memset+0x1c8>
    80004998:	00f50733          	add	a4,a0,a5
    8000499c:	00b70023          	sb	a1,0(a4)
    800049a0:	0017871b          	addiw	a4,a5,1
    800049a4:	0cc77663          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    800049a8:	00e50733          	add	a4,a0,a4
    800049ac:	00b70023          	sb	a1,0(a4)
    800049b0:	0027871b          	addiw	a4,a5,2
    800049b4:	0ac77e63          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    800049b8:	00e50733          	add	a4,a0,a4
    800049bc:	00b70023          	sb	a1,0(a4)
    800049c0:	0037871b          	addiw	a4,a5,3
    800049c4:	0ac77663          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    800049c8:	00e50733          	add	a4,a0,a4
    800049cc:	00b70023          	sb	a1,0(a4)
    800049d0:	0047871b          	addiw	a4,a5,4
    800049d4:	08c77e63          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    800049d8:	00e50733          	add	a4,a0,a4
    800049dc:	00b70023          	sb	a1,0(a4)
    800049e0:	0057871b          	addiw	a4,a5,5
    800049e4:	08c77663          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    800049e8:	00e50733          	add	a4,a0,a4
    800049ec:	00b70023          	sb	a1,0(a4)
    800049f0:	0067871b          	addiw	a4,a5,6
    800049f4:	06c77e63          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    800049f8:	00e50733          	add	a4,a0,a4
    800049fc:	00b70023          	sb	a1,0(a4)
    80004a00:	0077871b          	addiw	a4,a5,7
    80004a04:	06c77663          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    80004a08:	00e50733          	add	a4,a0,a4
    80004a0c:	00b70023          	sb	a1,0(a4)
    80004a10:	0087871b          	addiw	a4,a5,8
    80004a14:	04c77e63          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    80004a18:	00e50733          	add	a4,a0,a4
    80004a1c:	00b70023          	sb	a1,0(a4)
    80004a20:	0097871b          	addiw	a4,a5,9
    80004a24:	04c77663          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    80004a28:	00e50733          	add	a4,a0,a4
    80004a2c:	00b70023          	sb	a1,0(a4)
    80004a30:	00a7871b          	addiw	a4,a5,10
    80004a34:	02c77e63          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    80004a38:	00e50733          	add	a4,a0,a4
    80004a3c:	00b70023          	sb	a1,0(a4)
    80004a40:	00b7871b          	addiw	a4,a5,11
    80004a44:	02c77663          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    80004a48:	00e50733          	add	a4,a0,a4
    80004a4c:	00b70023          	sb	a1,0(a4)
    80004a50:	00c7871b          	addiw	a4,a5,12
    80004a54:	00c77e63          	bgeu	a4,a2,80004a70 <__memset+0x1c8>
    80004a58:	00e50733          	add	a4,a0,a4
    80004a5c:	00b70023          	sb	a1,0(a4)
    80004a60:	00d7879b          	addiw	a5,a5,13
    80004a64:	00c7f663          	bgeu	a5,a2,80004a70 <__memset+0x1c8>
    80004a68:	00f507b3          	add	a5,a0,a5
    80004a6c:	00b78023          	sb	a1,0(a5)
    80004a70:	00813403          	ld	s0,8(sp)
    80004a74:	01010113          	addi	sp,sp,16
    80004a78:	00008067          	ret
    80004a7c:	00b00693          	li	a3,11
    80004a80:	e55ff06f          	j	800048d4 <__memset+0x2c>
    80004a84:	00300e93          	li	t4,3
    80004a88:	ea5ff06f          	j	8000492c <__memset+0x84>
    80004a8c:	00100e93          	li	t4,1
    80004a90:	e9dff06f          	j	8000492c <__memset+0x84>
    80004a94:	00000e93          	li	t4,0
    80004a98:	e95ff06f          	j	8000492c <__memset+0x84>
    80004a9c:	00000793          	li	a5,0
    80004aa0:	ef9ff06f          	j	80004998 <__memset+0xf0>
    80004aa4:	00200e93          	li	t4,2
    80004aa8:	e85ff06f          	j	8000492c <__memset+0x84>
    80004aac:	00400e93          	li	t4,4
    80004ab0:	e7dff06f          	j	8000492c <__memset+0x84>
    80004ab4:	00500e93          	li	t4,5
    80004ab8:	e75ff06f          	j	8000492c <__memset+0x84>
    80004abc:	00600e93          	li	t4,6
    80004ac0:	e6dff06f          	j	8000492c <__memset+0x84>

0000000080004ac4 <__memmove>:
    80004ac4:	ff010113          	addi	sp,sp,-16
    80004ac8:	00813423          	sd	s0,8(sp)
    80004acc:	01010413          	addi	s0,sp,16
    80004ad0:	0e060863          	beqz	a2,80004bc0 <__memmove+0xfc>
    80004ad4:	fff6069b          	addiw	a3,a2,-1
    80004ad8:	0006881b          	sext.w	a6,a3
    80004adc:	0ea5e863          	bltu	a1,a0,80004bcc <__memmove+0x108>
    80004ae0:	00758713          	addi	a4,a1,7
    80004ae4:	00a5e7b3          	or	a5,a1,a0
    80004ae8:	40a70733          	sub	a4,a4,a0
    80004aec:	0077f793          	andi	a5,a5,7
    80004af0:	00f73713          	sltiu	a4,a4,15
    80004af4:	00174713          	xori	a4,a4,1
    80004af8:	0017b793          	seqz	a5,a5
    80004afc:	00e7f7b3          	and	a5,a5,a4
    80004b00:	10078863          	beqz	a5,80004c10 <__memmove+0x14c>
    80004b04:	00900793          	li	a5,9
    80004b08:	1107f463          	bgeu	a5,a6,80004c10 <__memmove+0x14c>
    80004b0c:	0036581b          	srliw	a6,a2,0x3
    80004b10:	fff8081b          	addiw	a6,a6,-1
    80004b14:	02081813          	slli	a6,a6,0x20
    80004b18:	01d85893          	srli	a7,a6,0x1d
    80004b1c:	00858813          	addi	a6,a1,8
    80004b20:	00058793          	mv	a5,a1
    80004b24:	00050713          	mv	a4,a0
    80004b28:	01088833          	add	a6,a7,a6
    80004b2c:	0007b883          	ld	a7,0(a5)
    80004b30:	00878793          	addi	a5,a5,8
    80004b34:	00870713          	addi	a4,a4,8
    80004b38:	ff173c23          	sd	a7,-8(a4)
    80004b3c:	ff0798e3          	bne	a5,a6,80004b2c <__memmove+0x68>
    80004b40:	ff867713          	andi	a4,a2,-8
    80004b44:	02071793          	slli	a5,a4,0x20
    80004b48:	0207d793          	srli	a5,a5,0x20
    80004b4c:	00f585b3          	add	a1,a1,a5
    80004b50:	40e686bb          	subw	a3,a3,a4
    80004b54:	00f507b3          	add	a5,a0,a5
    80004b58:	06e60463          	beq	a2,a4,80004bc0 <__memmove+0xfc>
    80004b5c:	0005c703          	lbu	a4,0(a1)
    80004b60:	00e78023          	sb	a4,0(a5)
    80004b64:	04068e63          	beqz	a3,80004bc0 <__memmove+0xfc>
    80004b68:	0015c603          	lbu	a2,1(a1)
    80004b6c:	00100713          	li	a4,1
    80004b70:	00c780a3          	sb	a2,1(a5)
    80004b74:	04e68663          	beq	a3,a4,80004bc0 <__memmove+0xfc>
    80004b78:	0025c603          	lbu	a2,2(a1)
    80004b7c:	00200713          	li	a4,2
    80004b80:	00c78123          	sb	a2,2(a5)
    80004b84:	02e68e63          	beq	a3,a4,80004bc0 <__memmove+0xfc>
    80004b88:	0035c603          	lbu	a2,3(a1)
    80004b8c:	00300713          	li	a4,3
    80004b90:	00c781a3          	sb	a2,3(a5)
    80004b94:	02e68663          	beq	a3,a4,80004bc0 <__memmove+0xfc>
    80004b98:	0045c603          	lbu	a2,4(a1)
    80004b9c:	00400713          	li	a4,4
    80004ba0:	00c78223          	sb	a2,4(a5)
    80004ba4:	00e68e63          	beq	a3,a4,80004bc0 <__memmove+0xfc>
    80004ba8:	0055c603          	lbu	a2,5(a1)
    80004bac:	00500713          	li	a4,5
    80004bb0:	00c782a3          	sb	a2,5(a5)
    80004bb4:	00e68663          	beq	a3,a4,80004bc0 <__memmove+0xfc>
    80004bb8:	0065c703          	lbu	a4,6(a1)
    80004bbc:	00e78323          	sb	a4,6(a5)
    80004bc0:	00813403          	ld	s0,8(sp)
    80004bc4:	01010113          	addi	sp,sp,16
    80004bc8:	00008067          	ret
    80004bcc:	02061713          	slli	a4,a2,0x20
    80004bd0:	02075713          	srli	a4,a4,0x20
    80004bd4:	00e587b3          	add	a5,a1,a4
    80004bd8:	f0f574e3          	bgeu	a0,a5,80004ae0 <__memmove+0x1c>
    80004bdc:	02069613          	slli	a2,a3,0x20
    80004be0:	02065613          	srli	a2,a2,0x20
    80004be4:	fff64613          	not	a2,a2
    80004be8:	00e50733          	add	a4,a0,a4
    80004bec:	00c78633          	add	a2,a5,a2
    80004bf0:	fff7c683          	lbu	a3,-1(a5)
    80004bf4:	fff78793          	addi	a5,a5,-1
    80004bf8:	fff70713          	addi	a4,a4,-1
    80004bfc:	00d70023          	sb	a3,0(a4)
    80004c00:	fec798e3          	bne	a5,a2,80004bf0 <__memmove+0x12c>
    80004c04:	00813403          	ld	s0,8(sp)
    80004c08:	01010113          	addi	sp,sp,16
    80004c0c:	00008067          	ret
    80004c10:	02069713          	slli	a4,a3,0x20
    80004c14:	02075713          	srli	a4,a4,0x20
    80004c18:	00170713          	addi	a4,a4,1
    80004c1c:	00e50733          	add	a4,a0,a4
    80004c20:	00050793          	mv	a5,a0
    80004c24:	0005c683          	lbu	a3,0(a1)
    80004c28:	00178793          	addi	a5,a5,1
    80004c2c:	00158593          	addi	a1,a1,1
    80004c30:	fed78fa3          	sb	a3,-1(a5)
    80004c34:	fee798e3          	bne	a5,a4,80004c24 <__memmove+0x160>
    80004c38:	f89ff06f          	j	80004bc0 <__memmove+0xfc>

0000000080004c3c <__putc>:
    80004c3c:	fe010113          	addi	sp,sp,-32
    80004c40:	00813823          	sd	s0,16(sp)
    80004c44:	00113c23          	sd	ra,24(sp)
    80004c48:	02010413          	addi	s0,sp,32
    80004c4c:	00050793          	mv	a5,a0
    80004c50:	fef40593          	addi	a1,s0,-17
    80004c54:	00100613          	li	a2,1
    80004c58:	00000513          	li	a0,0
    80004c5c:	fef407a3          	sb	a5,-17(s0)
    80004c60:	fffff097          	auipc	ra,0xfffff
    80004c64:	b3c080e7          	jalr	-1220(ra) # 8000379c <console_write>
    80004c68:	01813083          	ld	ra,24(sp)
    80004c6c:	01013403          	ld	s0,16(sp)
    80004c70:	02010113          	addi	sp,sp,32
    80004c74:	00008067          	ret

0000000080004c78 <__getc>:
    80004c78:	fe010113          	addi	sp,sp,-32
    80004c7c:	00813823          	sd	s0,16(sp)
    80004c80:	00113c23          	sd	ra,24(sp)
    80004c84:	02010413          	addi	s0,sp,32
    80004c88:	fe840593          	addi	a1,s0,-24
    80004c8c:	00100613          	li	a2,1
    80004c90:	00000513          	li	a0,0
    80004c94:	fffff097          	auipc	ra,0xfffff
    80004c98:	ae8080e7          	jalr	-1304(ra) # 8000377c <console_read>
    80004c9c:	fe844503          	lbu	a0,-24(s0)
    80004ca0:	01813083          	ld	ra,24(sp)
    80004ca4:	01013403          	ld	s0,16(sp)
    80004ca8:	02010113          	addi	sp,sp,32
    80004cac:	00008067          	ret

0000000080004cb0 <console_handler>:
    80004cb0:	fe010113          	addi	sp,sp,-32
    80004cb4:	00813823          	sd	s0,16(sp)
    80004cb8:	00113c23          	sd	ra,24(sp)
    80004cbc:	00913423          	sd	s1,8(sp)
    80004cc0:	02010413          	addi	s0,sp,32
    80004cc4:	14202773          	csrr	a4,scause
    80004cc8:	100027f3          	csrr	a5,sstatus
    80004ccc:	0027f793          	andi	a5,a5,2
    80004cd0:	06079e63          	bnez	a5,80004d4c <console_handler+0x9c>
    80004cd4:	00074c63          	bltz	a4,80004cec <console_handler+0x3c>
    80004cd8:	01813083          	ld	ra,24(sp)
    80004cdc:	01013403          	ld	s0,16(sp)
    80004ce0:	00813483          	ld	s1,8(sp)
    80004ce4:	02010113          	addi	sp,sp,32
    80004ce8:	00008067          	ret
    80004cec:	0ff77713          	andi	a4,a4,255
    80004cf0:	00900793          	li	a5,9
    80004cf4:	fef712e3          	bne	a4,a5,80004cd8 <console_handler+0x28>
    80004cf8:	ffffe097          	auipc	ra,0xffffe
    80004cfc:	6dc080e7          	jalr	1756(ra) # 800033d4 <plic_claim>
    80004d00:	00a00793          	li	a5,10
    80004d04:	00050493          	mv	s1,a0
    80004d08:	02f50c63          	beq	a0,a5,80004d40 <console_handler+0x90>
    80004d0c:	fc0506e3          	beqz	a0,80004cd8 <console_handler+0x28>
    80004d10:	00050593          	mv	a1,a0
    80004d14:	00000517          	auipc	a0,0x0
    80004d18:	5cc50513          	addi	a0,a0,1484 # 800052e0 <_ZZ8printIntmE6digits+0xe0>
    80004d1c:	fffff097          	auipc	ra,0xfffff
    80004d20:	afc080e7          	jalr	-1284(ra) # 80003818 <__printf>
    80004d24:	01013403          	ld	s0,16(sp)
    80004d28:	01813083          	ld	ra,24(sp)
    80004d2c:	00048513          	mv	a0,s1
    80004d30:	00813483          	ld	s1,8(sp)
    80004d34:	02010113          	addi	sp,sp,32
    80004d38:	ffffe317          	auipc	t1,0xffffe
    80004d3c:	6d430067          	jr	1748(t1) # 8000340c <plic_complete>
    80004d40:	fffff097          	auipc	ra,0xfffff
    80004d44:	3e0080e7          	jalr	992(ra) # 80004120 <uartintr>
    80004d48:	fddff06f          	j	80004d24 <console_handler+0x74>
    80004d4c:	00000517          	auipc	a0,0x0
    80004d50:	69450513          	addi	a0,a0,1684 # 800053e0 <digits+0x78>
    80004d54:	fffff097          	auipc	ra,0xfffff
    80004d58:	a68080e7          	jalr	-1432(ra) # 800037bc <panic>

0000000080004d5c <__mem_free>:
    80004d5c:	ff010113          	addi	sp,sp,-16
    80004d60:	00813423          	sd	s0,8(sp)
    80004d64:	01010413          	addi	s0,sp,16
    80004d68:	00001597          	auipc	a1,0x1
    80004d6c:	39058593          	addi	a1,a1,912 # 800060f8 <freep>
    80004d70:	0005b783          	ld	a5,0(a1)
    80004d74:	ff050693          	addi	a3,a0,-16
    80004d78:	0007b703          	ld	a4,0(a5)
    80004d7c:	00d7fc63          	bgeu	a5,a3,80004d94 <__mem_free+0x38>
    80004d80:	00e6ee63          	bltu	a3,a4,80004d9c <__mem_free+0x40>
    80004d84:	00e7fc63          	bgeu	a5,a4,80004d9c <__mem_free+0x40>
    80004d88:	00070793          	mv	a5,a4
    80004d8c:	0007b703          	ld	a4,0(a5)
    80004d90:	fed7e8e3          	bltu	a5,a3,80004d80 <__mem_free+0x24>
    80004d94:	fee7eae3          	bltu	a5,a4,80004d88 <__mem_free+0x2c>
    80004d98:	fee6f8e3          	bgeu	a3,a4,80004d88 <__mem_free+0x2c>
    80004d9c:	ff852803          	lw	a6,-8(a0)
    80004da0:	02081613          	slli	a2,a6,0x20
    80004da4:	01c65613          	srli	a2,a2,0x1c
    80004da8:	00c68633          	add	a2,a3,a2
    80004dac:	02c70a63          	beq	a4,a2,80004de0 <__mem_free+0x84>
    80004db0:	fee53823          	sd	a4,-16(a0)
    80004db4:	0087a503          	lw	a0,8(a5)
    80004db8:	02051613          	slli	a2,a0,0x20
    80004dbc:	01c65613          	srli	a2,a2,0x1c
    80004dc0:	00c78633          	add	a2,a5,a2
    80004dc4:	04c68263          	beq	a3,a2,80004e08 <__mem_free+0xac>
    80004dc8:	00813403          	ld	s0,8(sp)
    80004dcc:	00d7b023          	sd	a3,0(a5)
    80004dd0:	00f5b023          	sd	a5,0(a1)
    80004dd4:	00000513          	li	a0,0
    80004dd8:	01010113          	addi	sp,sp,16
    80004ddc:	00008067          	ret
    80004de0:	00872603          	lw	a2,8(a4)
    80004de4:	00073703          	ld	a4,0(a4)
    80004de8:	0106083b          	addw	a6,a2,a6
    80004dec:	ff052c23          	sw	a6,-8(a0)
    80004df0:	fee53823          	sd	a4,-16(a0)
    80004df4:	0087a503          	lw	a0,8(a5)
    80004df8:	02051613          	slli	a2,a0,0x20
    80004dfc:	01c65613          	srli	a2,a2,0x1c
    80004e00:	00c78633          	add	a2,a5,a2
    80004e04:	fcc692e3          	bne	a3,a2,80004dc8 <__mem_free+0x6c>
    80004e08:	00813403          	ld	s0,8(sp)
    80004e0c:	0105053b          	addw	a0,a0,a6
    80004e10:	00a7a423          	sw	a0,8(a5)
    80004e14:	00e7b023          	sd	a4,0(a5)
    80004e18:	00f5b023          	sd	a5,0(a1)
    80004e1c:	00000513          	li	a0,0
    80004e20:	01010113          	addi	sp,sp,16
    80004e24:	00008067          	ret

0000000080004e28 <__mem_alloc>:
    80004e28:	fc010113          	addi	sp,sp,-64
    80004e2c:	02813823          	sd	s0,48(sp)
    80004e30:	02913423          	sd	s1,40(sp)
    80004e34:	03213023          	sd	s2,32(sp)
    80004e38:	01513423          	sd	s5,8(sp)
    80004e3c:	02113c23          	sd	ra,56(sp)
    80004e40:	01313c23          	sd	s3,24(sp)
    80004e44:	01413823          	sd	s4,16(sp)
    80004e48:	01613023          	sd	s6,0(sp)
    80004e4c:	04010413          	addi	s0,sp,64
    80004e50:	00001a97          	auipc	s5,0x1
    80004e54:	2a8a8a93          	addi	s5,s5,680 # 800060f8 <freep>
    80004e58:	00f50913          	addi	s2,a0,15
    80004e5c:	000ab683          	ld	a3,0(s5)
    80004e60:	00495913          	srli	s2,s2,0x4
    80004e64:	0019049b          	addiw	s1,s2,1
    80004e68:	00048913          	mv	s2,s1
    80004e6c:	0c068c63          	beqz	a3,80004f44 <__mem_alloc+0x11c>
    80004e70:	0006b503          	ld	a0,0(a3)
    80004e74:	00852703          	lw	a4,8(a0)
    80004e78:	10977063          	bgeu	a4,s1,80004f78 <__mem_alloc+0x150>
    80004e7c:	000017b7          	lui	a5,0x1
    80004e80:	0009099b          	sext.w	s3,s2
    80004e84:	0af4e863          	bltu	s1,a5,80004f34 <__mem_alloc+0x10c>
    80004e88:	02099a13          	slli	s4,s3,0x20
    80004e8c:	01ca5a13          	srli	s4,s4,0x1c
    80004e90:	fff00b13          	li	s6,-1
    80004e94:	0100006f          	j	80004ea4 <__mem_alloc+0x7c>
    80004e98:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    80004e9c:	00852703          	lw	a4,8(a0)
    80004ea0:	04977463          	bgeu	a4,s1,80004ee8 <__mem_alloc+0xc0>
    80004ea4:	00050793          	mv	a5,a0
    80004ea8:	fea698e3          	bne	a3,a0,80004e98 <__mem_alloc+0x70>
    80004eac:	000a0513          	mv	a0,s4
    80004eb0:	00000097          	auipc	ra,0x0
    80004eb4:	0d0080e7          	jalr	208(ra) # 80004f80 <kvmincrease>
    80004eb8:	00050793          	mv	a5,a0
    80004ebc:	01050513          	addi	a0,a0,16
    80004ec0:	07678e63          	beq	a5,s6,80004f3c <__mem_alloc+0x114>
    80004ec4:	0137a423          	sw	s3,8(a5)
    80004ec8:	00000097          	auipc	ra,0x0
    80004ecc:	e94080e7          	jalr	-364(ra) # 80004d5c <__mem_free>
    80004ed0:	000ab783          	ld	a5,0(s5)
    80004ed4:	06078463          	beqz	a5,80004f3c <__mem_alloc+0x114>
    80004ed8:	0007b503          	ld	a0,0(a5)
    80004edc:	00078693          	mv	a3,a5
    80004ee0:	00852703          	lw	a4,8(a0)
    80004ee4:	fc9760e3          	bltu	a4,s1,80004ea4 <__mem_alloc+0x7c>
    80004ee8:	08e48263          	beq	s1,a4,80004f6c <__mem_alloc+0x144>
    80004eec:	4127073b          	subw	a4,a4,s2
    80004ef0:	02071693          	slli	a3,a4,0x20
    80004ef4:	01c6d693          	srli	a3,a3,0x1c
    80004ef8:	00e52423          	sw	a4,8(a0)
    80004efc:	00d50533          	add	a0,a0,a3
    80004f00:	01252423          	sw	s2,8(a0)
    80004f04:	00fab023          	sd	a5,0(s5)
    80004f08:	01050513          	addi	a0,a0,16
    80004f0c:	03813083          	ld	ra,56(sp)
    80004f10:	03013403          	ld	s0,48(sp)
    80004f14:	02813483          	ld	s1,40(sp)
    80004f18:	02013903          	ld	s2,32(sp)
    80004f1c:	01813983          	ld	s3,24(sp)
    80004f20:	01013a03          	ld	s4,16(sp)
    80004f24:	00813a83          	ld	s5,8(sp)
    80004f28:	00013b03          	ld	s6,0(sp)
    80004f2c:	04010113          	addi	sp,sp,64
    80004f30:	00008067          	ret
    80004f34:	000019b7          	lui	s3,0x1
    80004f38:	f51ff06f          	j	80004e88 <__mem_alloc+0x60>
    80004f3c:	00000513          	li	a0,0
    80004f40:	fcdff06f          	j	80004f0c <__mem_alloc+0xe4>
    80004f44:	00002797          	auipc	a5,0x2
    80004f48:	45c78793          	addi	a5,a5,1116 # 800073a0 <base>
    80004f4c:	00078513          	mv	a0,a5
    80004f50:	00fab023          	sd	a5,0(s5)
    80004f54:	00f7b023          	sd	a5,0(a5)
    80004f58:	00000713          	li	a4,0
    80004f5c:	00002797          	auipc	a5,0x2
    80004f60:	4407a623          	sw	zero,1100(a5) # 800073a8 <base+0x8>
    80004f64:	00050693          	mv	a3,a0
    80004f68:	f11ff06f          	j	80004e78 <__mem_alloc+0x50>
    80004f6c:	00053703          	ld	a4,0(a0)
    80004f70:	00e7b023          	sd	a4,0(a5)
    80004f74:	f91ff06f          	j	80004f04 <__mem_alloc+0xdc>
    80004f78:	00068793          	mv	a5,a3
    80004f7c:	f6dff06f          	j	80004ee8 <__mem_alloc+0xc0>

0000000080004f80 <kvmincrease>:
    80004f80:	fe010113          	addi	sp,sp,-32
    80004f84:	01213023          	sd	s2,0(sp)
    80004f88:	00001937          	lui	s2,0x1
    80004f8c:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80004f90:	00813823          	sd	s0,16(sp)
    80004f94:	00113c23          	sd	ra,24(sp)
    80004f98:	00913423          	sd	s1,8(sp)
    80004f9c:	02010413          	addi	s0,sp,32
    80004fa0:	01250933          	add	s2,a0,s2
    80004fa4:	00c95913          	srli	s2,s2,0xc
    80004fa8:	02090863          	beqz	s2,80004fd8 <kvmincrease+0x58>
    80004fac:	00000493          	li	s1,0
    80004fb0:	00148493          	addi	s1,s1,1
    80004fb4:	fffff097          	auipc	ra,0xfffff
    80004fb8:	4bc080e7          	jalr	1212(ra) # 80004470 <kalloc>
    80004fbc:	fe991ae3          	bne	s2,s1,80004fb0 <kvmincrease+0x30>
    80004fc0:	01813083          	ld	ra,24(sp)
    80004fc4:	01013403          	ld	s0,16(sp)
    80004fc8:	00813483          	ld	s1,8(sp)
    80004fcc:	00013903          	ld	s2,0(sp)
    80004fd0:	02010113          	addi	sp,sp,32
    80004fd4:	00008067          	ret
    80004fd8:	01813083          	ld	ra,24(sp)
    80004fdc:	01013403          	ld	s0,16(sp)
    80004fe0:	00813483          	ld	s1,8(sp)
    80004fe4:	00013903          	ld	s2,0(sp)
    80004fe8:	00000513          	li	a0,0
    80004fec:	02010113          	addi	sp,sp,32
    80004ff0:	00008067          	ret
	...
