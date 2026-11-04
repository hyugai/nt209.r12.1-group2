.section .data
alpha:    .ascii "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

.section .bss
    .lcomm text, 5
    .lcomm nbuf, 2
    .lcomm res, 5

.section .text
    .globl _start
_start:
    movl $3, %eax
    movl $0, %ebx
    movl $text, %ecx
    movl $5, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    movl $nbuf, %ecx
    movl $2, %edx
    int $0x80

    movzbl nbuf, %esi
    subl $48, %esi               # esi = n (0..9)
    xorl %ecx, %ecx              # ecx = i
lap:
    cmpl $4, %ecx
    jge xong
    movzbl text(,%ecx,1), %eax
    subl $97, %eax
    addl %esi, %eax              # chi so toi da 25 + 9 = 34 < 52, khong can xoay vong
    movb alpha(,%eax,1), %bl     # tra bang
    movb %bl, res(,%ecx,1)
    incl %ecx
    jmp lap
xong:
    movb $10, res+4

    movl $4, %eax
    movl $1, %ebx
    movl $res, %ecx
    movl $5, %edx
    int $0x80

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
