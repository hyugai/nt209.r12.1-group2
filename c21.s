# Version 1
.section .data
msg:      .string "NT209UIT"
msg_len = . - msg - 1            # (dia chi hien tai - dia chi msg) - 1 ky tu null

.section .bss
    .lcomm out, 2                # 1 chu so + '\n'

.section .text
    .globl _start
_start:
    movl $msg_len, %eax          # eax = do dai chuoi (hang so)
    addl $48, %eax               # doi sang ky tu so ASCII ('0' = 48)
    movb %al, out                # out[0] = chu so
    movb $10, out+1              # out[1] = '\n'

    movl $4, %eax                # sys_write
    movl $1, %ebx                # stdout
    movl $out, %ecx              # dia chi du lieu can in
    movl $2, %edx                # in 2 byte
    int $0x80

    movl $1, %eax                # sys_exit
    xorl %ebx, %ebx
    int $0x80


# Version 2
.section .data
msg:      .string "NT209UIT"

.section .bss
    .lcomm out, 2

.section .text
    .globl _start
_start:
    movl $msg, %esi              # esi = dia chi dau chuoi
    xorl %ecx, %ecx              # ecx = bo dem do dai = 0
dem:
    cmpb $0, (%esi,%ecx,1)       # byte tai msg[ecx] co phai null khong?
    je xong
    incl %ecx                    # chua phai null -> tang do dai
    jmp dem
xong:
    addl $48, %ecx               # doi so -> ky tu ASCII
    movb %cl, out
    movb $10, out+1

    movl $4, %eax
    movl $1, %ebx
    movl $out, %ecx
    movl $2, %edx
    int $0x80

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80


# Version 3
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



