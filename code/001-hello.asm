# NOTE: Hello, World in assembly
.globl main
# includes a file and inserts the whole file here
.include "macros.asm"

# data segment
.data 
msg: .asciiz "Hello, World"

# code segment
.text
# main label
main:
	# print string msg
	la $a0, msg
	li $v0, 4
	syscall
	
# call exit macro from macro file(included file)
	exit()
	
