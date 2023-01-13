# NOTE: Hello, World in assembly
.globl main

# data segment (global variables)
.data
msg: .asciiz "Hello, World\n"
    # asciiz includes the null terminator (\0) in string

# code segment
.text
main:
    # print string msg
    # 4 is the syscall number for print string
    la $a0, msg # loads address of msg to $a0
    li $v0, 4   # loads immediate (4) to $v0
    syscall

    # exit
    # exit syscall is 10
    li $v0, 10 
    syscall

