# task2 
# get an integer input 
# set bit 11 and 17 to 1 
# print the result integer

.globl main

.data
msg1: .asciiz "Enter a: "
msg2: .asciiz "Result = "

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

	# set bit 11 and 17 to 1
	# by ORing with a zeroed number except the
	# bit locations
	ori $t0, $t0, 133120

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
