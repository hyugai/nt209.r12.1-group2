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
