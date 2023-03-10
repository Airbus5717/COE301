# Task 2

.globl main
.data
msg1: .asciiz "Enter n: "
msg2: .asciiz "fib(n) = " 
.text
main: 
	# print prompt
	li $v0, 4 
	la $a0, msg1 
	syscall 
	
	li $v0, 5
	syscall 
	move $a0, $v0
	
	jal fib 
	move $t1, $v0 
	
	li $v0, 4 
	la $a0, msg2 
	syscall
	
	li $v0, 1 
	move $a0, $t1 
	syscall  
	# exit
	li $v0, 10
	syscall
	
# int fib(int n) {
#	if (n <= 1)
#		return n;
#	return fib(n-1)+fib(n-2);
# }

fib: 
	 move $t0, $a0
	 # if n <= 1 { return n }
	 bgt $t0, 1, else
	 move $v0, $a0
	 jr $ra
	 # else 
	 # t1 = fib (n - 1) 
	 # t2 = fib (n - 2) 
	 # t3 = t1 + t2 
	 # v0 = t3
else: 
	addi $sp, $sp, -12 # allocate stack
	sw $a0, 0($sp) # store temp n
	sw $ra, 4($sp) # store return address
	lw $a0, 0($sp) # restore $a0 = n 
 	addi $a0, $a0, -1 # n - 1

	jal fib
	move $t1, $v0
	sw $v0, 8($sp) # store temp fib(n-1)
	
	lw $a0, 0($sp) # restore $a0 = n
	subi $a0, $a0, 2
	jal fib
	
	lw $t1, 8($sp)
	addu $v0, $t1, $v0
	
	lw $ra, 4($sp) # restore return address
 	addi $sp, $sp, 12 # deallocate stack  
	jr $ra
