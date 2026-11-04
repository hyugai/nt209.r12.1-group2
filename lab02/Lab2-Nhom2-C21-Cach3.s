.section .data
msg:      .string "NT209UIT"
len:      .int 0                 # phai nam ngay sau msg

.section .bss
    .lcomm out, 2

.section .text
    .globl _start
_start:
    movl $len, %edi              # edi = dia chi cua len
    subl $msg, %edi              # tru dia chi msg -> do dai gom ca null
    subl $1, %edi                # bo ky tu null
    movl %edi, len               # luu ket qua vao len

    movl len, %eax               # doc gia tri len
    addl $48, %eax               # sang ASCII
    movb %al, out
    movb $10, out+1

    movl $4, %eax
    movl $1, %ebx
    movl $out, %ecx
    movl $2, %edx
    int $0x80

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
