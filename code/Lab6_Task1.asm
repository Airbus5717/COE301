# convert withdrawal money amount to bank notes
.globl main 

.data 
msg1: .asciiz "Enter withdrawal amount: "
msg2: .asciiz "500 Bank note: "
msg3: .asciiz "100 Bank note: "
msg4: .asciiz "50 Bank note: "
msg5: .asciiz "10 Bank note: "
msg6: .asciiz "5 Bank note: "
msg7: .asciiz "1 Bank note: "

.text 
main:
	# print string input prompt
	li $v0, 4 
	la $a0, msg1 
	syscall 
	
	# read integer 
	li $v0, 5 
	syscall 
	move $t0, $v0
	
	# get 500s
	li $t1, 500
	div $t2, $t0, $t1 
	mfhi $t0
	
	# get 100s
	li $t1, 100 
	div $t3, $t0, $t1 
	mfhi $t0
		
		
	# get 50s
	li $t1, 50 
	div $t4, $t0, $t1 
	mfhi $t0
	
	# get 10s
	li $t1, 10 
	div $t5, $t0, $t1 
	mfhi $t0
	
	# get 5s
	li $t1, 5 
	div $t6, $t0, $t1 
	mfhi $t0
	
	# get 1s
	li $t1, 1 
	div $t7, $t0, $t1 
	mfhi $t0
	
x_500s:
	blez $t2, x_100s
	
	la $a0, msg2
	li $v0, 4 
	syscall
	
	li $v0, 1 
	move $a0, $t2 
	syscall 
	
	li $v0, 11
	li $a0, '\n'
	syscall 
	 
x_100s:
	blez $t3, x_50s
	
	la $a0, msg3
	li $v0, 4 
	syscall
	
	li $v0, 1 
	move $a0, $t3 
	syscall 
	
	li $v0, 11
	li $a0, '\n'
	syscall
x_50s: 
	blez $t4, x_10s
	
	la $a0, msg4
	li $v0, 4 
	syscall
	
	li $v0, 1 
	move $a0, $t4 
	syscall 
	
	li $v0, 11
	li $a0, '\n'
	syscall
x_10s:
	blez $t5, x_5s 
	
	la $a0, msg5
	li $v0, 4 
	syscall
	
	li $v0, 1 
	move $a0, $t5 
	syscall 
	
	li $v0, 11
	li $a0, '\n'
	syscall
x_5s:
	blez $t6, x_1s
	
	la $a0, msg6
	li $v0, 4 
	syscall
	
	li $v0, 1 
	move $a0, $t6
	syscall 
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
x_1s:
	blez $t7, done 
	la $a0, msg7
	li $v0, 4 
	syscall
	
	li $v0, 1 
	move $a0, $t7 
	syscall 
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
done: 
	li $v0, 10 
	syscall
