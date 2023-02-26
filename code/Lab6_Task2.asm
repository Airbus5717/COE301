# Get factorial of input number
.globl main 

.data 
msg: .asciiz "Enter n: "
msg2: .asciiz "n! = "
.text 

main: 
	# print string input prompt 
	li $v0, 4 
	la $a0, msg 
	syscall 
	
	# read int
	li $v0, 5
	syscall 
	move $t0, $v0 
	
	li $t1, 1 # result 
	li $t2, 1 # i
loop: 
	bgt $t2, $t0, endLoop 
body: 
	mul $t1, $t1, $t2 

inc: # i++
	addi $t2, $t2, 1 
	j loop
endLoop:

	# print output prompt 
	li $v0, 4 
	la $a0, msg2 
	syscall 
	
	# print int result
	li $v0, 1 
	move $a0, $t1 
	syscall 
	
	# print newline
	li $v0, 11 
	li $a0, '\n' 
	syscall 
	
	# exit
	li $v0, 10 
	syscall
	
	
