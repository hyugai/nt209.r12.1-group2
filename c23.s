#version 1

.section .data
sum: .int 0

.section .bss
.lcomm input, 2                 # 1 byte ky tu so + 1 byte '\n'
.lcomm result, 2                # 1 chu so ket qua + '\n'

.section .text
.globl _start
_start:
    movl $4, %esi               # Bo dem vong lap (4 lan)

loop_read:
    # Doc 2 byte tu ban phim (stdin)
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $2, %edx
    int $0x80

    # Lay dung 1 byte, doi sang so roi cong don vao sum
    movzbl input, %edi
    subl $'0', %edi
    addl %edi, sum

    decl %esi
    jne loop_read

    # Tinh trung binh cong: sum / 4
    movl sum, %eax
    xorl %edx, %edx             # Xoa %edx truoc khi divl
    movl $4, %ecx
    divl %ecx                   # %eax = sum / 4 (lay phan nguyen)

    # Chuyen ket qua sang ASCII va luu vao result
    addl $'0', %eax
    movb %al, result
    movb $10, result+1          # 10 la ky tu xuong dong '\n'

    # In ket qua ra man hinh (stdout)
    movl $4, %eax
    movl $1, %ebx
    movl $result, %ecx
    movl $2, %edx
    int $0x80

    # Thoat chuong trinh
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

    #version 2

.section .bss
.lcomm input, 2                 # Bo dem nhan 2 byte
.lcomm result, 2                # Ket qua in ra kem '\n'

.section .text
.globl _start
_start:
    xorl %ebp, %ebp             # %ebp = tong tich luy (khoi tao = 0)
    movl $4, %esi               # Bo dem lap (4 lan)

loop_read:
    # Syscall sys_read nhan 2 byte
    movl $3, %eax
    xorl %ebx, %ebx             # %ebx = 0 (stdin)
    movl $input, %ecx
    movl $2, %edx
    int $0x80

    # Chuyen ky tu thanh so va cong vao thanh ghi %ebp
    movzbl input, %eax
    subl $'0', %eax
    addl %eax, %ebp

    decl %esi
    jnz loop_read

    # Chia cho 4 bang phep dich phai 2 bit (ebp >> 2)
    movl %ebp, %eax
    shrl $2, %eax               # %eax = phan nguyen cua tong / 4

    # Ghi ma ASCII va ky tu '\n' vao result
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


  #version 3

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
