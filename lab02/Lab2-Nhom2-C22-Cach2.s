.section .data
    newline: .ascii "\n"

.section .bss
    .lcomm input, 11
    .lcomm start, 2
    .lcomm end, 2

.section .text
    .globl _start

_start:
    # Nhap chuoi 10 ky tu
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $11, %edx
    int $0x80

    # Nhap start
    movl $3, %eax
    movl $0, %ebx
    movl $start, %ecx
    movl $2, %edx
    int $0x80

    # Nhap end
    movl $3, %eax
    movl $0, %ebx
    movl $end, %ecx
    movl $2, %edx
    int $0x80

    # Chuyen ASCII sang so
    movzbl start, %esi
    subl $48, %esi

    movzbl end, %edi
    subl $48, %edi

loop:
    # Kiem tra chi so hien tai
    cmpl %edi, %esi
    jg print_newline

    # In 1 ky tu tai vi tri input + esi
    movl $4, %eax
    movl $1, %ebx
    leal input(%esi), %ecx
    movl $1, %edx
    int $0x80

    # Tang chi so
    incl %esi
    jmp loop

print_newline:
    # In ky tu xuong dong
    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
