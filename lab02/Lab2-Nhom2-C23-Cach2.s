.section .bss
.lcomm buffer, 8                # 4 dong x 2 byte = 8 byte
.lcomm result, 2                # Ket qua in ra kem '\n'

.section .text
.globl _start
_start:
    # Goi sys_read 1 lan duy nhat de doc ca 8 byte vao buffer
    movl $3, %eax
    xorl %ebx, %ebx             # %ebx = 0 (stdin)
    movl $buffer, %ecx
    movl $8, %edx
    int $0x80

    # Cong truc tiep ma ASCII cua 4 chu so (cach nhau 2 byte)
    movzbl buffer, %eax         # So 1 tai buffer[0]
    movzbl buffer+2, %ebx       # So 2 tai buffer[2]
    addl %ebx, %eax

    movzbl buffer+4, %ebx       # So 3 tai buffer[4]
    addl %ebx, %eax

    movzbl buffer+6, %ebx       # So 4 tai buffer[6]
    addl %ebx, %eax

    # Tru di 4 lan '0' (4 * 48 = 192) de ra tong gia tri that
    subl $192, %eax

    # Chia 4 lay phan nguyen
    shrl $2, %eax

    # Ghi ma ASCII va '\n' vao result
    addl $'0', %eax
    movb %al, result
    movb $10, result+1

    # In ket qua
    movl $4, %eax
    movl $1, %ebx               # %ebx = 1 (stdout)
    movl $result, %ecx
    movl $2, %edx
    int $0x80

    # Thoat chuong trinh
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
