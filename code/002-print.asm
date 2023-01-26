.globl main
.data
str1: .asciiz "Enter an int value: "
str2: .asciiz "You entered: "

.text
main:
    # print string
    li $v0, 4
    la $a0, str1
    syscall
    
    # read int
    li $v0, 5
    syscall
    move $s0, $v0 # save int result in $s0
    
    # print string
    li $v0, 4
    la $a0, str2
    syscall
    
    
    # print int
    li $v0, 1
    la $a0, $s0
    syscall
    
    # exit
    li $v0, 10
    syscall
