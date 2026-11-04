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




