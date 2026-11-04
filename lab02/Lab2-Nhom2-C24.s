# Version 1
.section .bss
    .lcomm text, 5               # 4 ky tu + '\n'
    .lcomm nbuf, 2               # n + '\n'

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

    movzbl nbuf, %edx
    subl $48, %edx               # edx = n
    xorl %ecx, %ecx              # ecx = i = 0
lap:
    cmpl $4, %ecx
    jge xong
    movzbl text(,%ecx,1), %eax   # eax = text[i]
    addl %edx, %eax              # dich n
    cmpl $122, %eax              # vuot 'z' ?
    jle giu
    subl $26, %eax               # xoay vong ve a..z
giu:
    movb %al, text(,%ecx,1)      # ghi de lai len text[i]
    incl %ecx
    jmp lap
xong:
    movb $10, text+4             # dam bao co ky tu xuong dong

    movl $4, %eax
    movl $1, %ebx
    movl $text, %ecx
    movl $5, %edx
    int $0x80

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

# Version 2
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


# Version 3
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
