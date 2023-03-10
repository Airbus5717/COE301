# Task 1 
.globl main

.data 
msg1: .asciiz "Enter Dividend (x): "
msg2: .asciiz "Enter Divisor (y): "
msg3: .asciiz "Divide By Zero Exception.\nPlease enter a different value for y.\n"
msg5: .asciiz "Enter Divisor (y): "
msg6: .asciiz "The result of x/y is "

.text
main:
	# print prompt1 
	li $v0, 4
	la $a0, msg1 
	syscall	

	# read int1
	li $v0, 5
	syscall
	move $t0, $v0 # dividend
	
	# print prompt1 
	li $v0, 4
	la $a0, msg2 
	syscall	

	# read int1
	li $v0, 5
	syscall
	move $t1, $v0 # dividend
	
	div $t2, $t0, $t1
	
	# print result prompt
	li $v0, 4
	la $a0, msg6
	syscall

	# print int result
	li $v0, 1
	move $a0, $t2 
	syscall

	# exit
	li $v0, 10 	
	syscall

# kernel mode (where the death begins)
.ktext 0x80000180
	move $k1, $at 
	la $k0, _regs 
	sw $k1, 0($k0)
	sw $a0, 4($k0)
	sw $v0, 8($k0)
redo:
	la $a0, _msg
	li $v0, 4
	syscall 
	
	li $v0, 5 
	syscall
	move $t1, $v0
	beqz $t1, redo

	

	la $k1, _regs # $k1 = address of _regs
	lw $at, 0($k1) # restore $at
	lw $v0, 4($k1) # restore $v0
	lw $a0, 8($k1) # restore $a0 	

	mtc0 $zero, $8 # clear vaddr
	mfc0 $k0, $14 # $k0 = EPC
	addiu $k0, $k0, 4 # Increment $k0 by 4
	mtc0 $k0, $14 # EPC = point to next instruction
	eret # exception return: PC = EPC	

.kdata
_regs: .word 0:3
_msg: .asciiz "Divide By Zero Exception.\nPlease enter a different value for y.\n"

