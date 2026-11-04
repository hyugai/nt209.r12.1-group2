.section .bss
    .lcomm text, 5
    .lcomm nbuf, 2

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
    subl $48, %esi               # esi = n
    xorl %edi, %edi              # edi = i
    movl $26, %ebx               # ebx = so chia
lap:
    cmpl $4, %edi
    jge xong
    movzbl text(,%edi,1), %eax
    subl $97, %eax               # 'a' -> 0 ... 'z' -> 25
    addl %esi, %eax              # + n
    xorl %edx, %edx
    divl %ebx                    # edx = (c + n) mod 26
    addl $97, %edx               # ve lai ma ASCII
    movb %dl, text(,%edi,1)
    incl %edi
    jmp lap
xong:
    movb $10, text+4

    movl $4, %eax
    movl $1, %ebx
    movl $text, %ecx
    movl $5, %edx
    int $0x80

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
