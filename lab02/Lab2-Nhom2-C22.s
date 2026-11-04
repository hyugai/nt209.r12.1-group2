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

    # Nhap chi so start
    movl $3, %eax
    movl $0, %ebx
    movl $start, %ecx
    movl $2, %edx
    int $0x80

    # Nhap chi so end
    movl $3, %eax
    movl $0, %ebx
    movl $end, %ecx
    movl $2, %edx
    int $0x80

    # Chuyen start tu ASCII sang so
    movzbl start, %esi
    subl $48, %esi

    # Chuyen end tu ASCII sang so
    movzbl end, %edi
    subl $48, %edi

    # Tinh dia chi va do dai chuoi con
    leal input(%esi), %ecx
    movl %edi, %edx
    subl %esi, %edx
    incl %edx

    # In chuoi con
    movl $4, %eax
    movl $1, %ebx
    int $0x80

    # In ky tu xuong dong
    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

    # Ket thuc chuong trinh
    movl $1, %eax
    movl $0, %ebx
    int $0x80

