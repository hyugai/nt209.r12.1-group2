.section .bss
    .lcomm text, 5               # 4 ky tu + '\n'
    .lcomm ch, 1                 # 1 byte doc vao

.section .text
    .globl _start
_start:
    xorl %esi, %esi              # esi = so ky tu da luu
    xorl %edi, %edi              # edi = n (mac dinh 0)

doc1:                            # doc dong 1, chi giu 4 ky tu dau
    movl $3, %eax
    xorl %ebx, %ebx
    movl $ch, %ecx
    movl $1, %edx
    int $0x80
    testl %eax, %eax
    jle xuly                     # EOF / loi
    movzbl ch, %eax
    cmpl $10, %eax
    je doc2                      # gap '\n' -> sang dong 2
    cmpl $13, %eax
    je doc1                      # bo '\r'
    cmpl $4, %esi
    jge doc1                     # thua thi bo
    movb %al, text(%esi)
    incl %esi
    jmp doc1

doc2:                            # doc dong 2, tim chu so dau tien
    movl $3, %eax
    xorl %ebx, %ebx
    movl $ch, %ecx
    movl $1, %edx
    int $0x80
    testl %eax, %eax
    jle xuly
    movzbl ch, %eax
    subl $48, %eax
    cmpl $9, %eax
    ja doc2                      # khong phai chu so -> bo qua (so sanh unsigned)
    movl %eax, %edi              # edi = n

xuly:
    xorl %ecx, %ecx
lap:
    cmpl $4, %ecx
    jge xong
    movzbl text(,%ecx,1), %eax
    addl %edi, %eax
    cmpl $122, %eax
    jle giu
    subl $26, %eax
giu:
    movb %al, text(,%ecx,1)
    incl %ecx
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

