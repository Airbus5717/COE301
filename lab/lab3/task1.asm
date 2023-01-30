# task1
# get integer input 
# multiply with 53.125 
# print result

.globl main

.data
msg1: .asciiz "Enter x: "
msg2: .asciiz "y = "

.text
main: 
	# print string input prompt
	la $a0, msg1
	li $v0, 4
	syscall

	# read integer to $t0
	li $v0, 5
	syscall
	move $t0, $v0

	# .125 = x/8 = x >> 3
	sra $t1, $t0, 3 
	

	# 53 = 32 + 16 + 4 + 1	
	sll $t2, $t0, 5 # 32x 
	sll $t3, $t0, 4 # 16x 
	sll $t4, $t0, 2 # 4x

	# add results to $t0
	add $t0, $t0, $t1 # adds the 1x + .125x
	add $t0, $t0, $t2 # += 32x
	add $t0, $t0, $t3 # += 16x
	add $t0, $t0, $t4 # += 4x

	# print string output prompt
	li  $v0, 4
	la $a0, msg2
	syscall

	# print result (result is already in $a0)
	move $a0, $t0
	li $v0, 1
	syscall

	# exit
	li $v0, 10
	syscall
