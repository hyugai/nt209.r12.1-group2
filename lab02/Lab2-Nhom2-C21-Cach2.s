.section .data
msg:      .string "NT209UIT"

.section .bss
    .lcomm out, 2

.section .text
    .globl _start
_start:
    movl $msg, %esi              # esi = dia chi dau chuoi
    xorl %ecx, %ecx              # ecx = bo dem do dai = 0
dem:
    cmpb $0, (%esi,%ecx,1)       # byte tai msg[ecx] co phai null khong?
    je xong
    incl %ecx                    # chua phai null -> tang do dai
    jmp dem
xong:
    addl $48, %ecx               # doi so -> ky tu ASCII
    movb %cl, out
    movb $10, out+1

    movl $4, %eax
    movl $1, %ebx
    movl $out, %ecx
    movl $2, %edx
    int $0x80

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
