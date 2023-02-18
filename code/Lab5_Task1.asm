
# TASK1

# Write a MIPS assembly program that
# reads the size (n) of the message from
# the user. Then, the program allocates
# (n+1) bytes in the heap. After that, read
# a string of n characters from the user
# he/she wishes to encrypt. Next, read
# an encrypting key (e) from the user 
# Encrypt the original string with the
# encryption key using the following code.
# Finally, print out the encrypted string.
# 
#
#

.globl main

.data 
msg1: .asciiz "Enter n: "
msg2: .asciiz "Enter string: "
msg3: .asciiz "Enter e: "
msg4: .asciiz "Encrypted string = "


.text
# $t0 will hold the n 
# $t1 will hold the e 
# $t2 is the temp `ch` variable
# $t3 is the address of the string
# $t4 is the index in loop



main:
	# print string input prompt
	li $v0, 4 
	la $a0, msg1
	syscall
	
	# $t0 <- ask for integer input 
	li $v0, 5
	syscall
	move $t0, $v0
	
	# print string input prompt for string
	li $v0, 4 
	la $a0, msg2
	syscall
	
	# malloc((n | $t0)+1)
	li $v0, 9
	addiu $t0, $t0, 1 # n++
	move $a0, $t0 # load memory size
	syscall 
	move $t3, $v0
	
	# read string to memory
	li $v0, 8
	move $a0, $t3
	move $a1, $t0 
	syscall
	
	# print newline
	#li $v0, 11
	#li $a0, '\n'
	#syscall  
	
	
	# print string input prompt 
	# for encrypt key
	li $v0, 4 
	la $a0, msg3
	syscall
	
	# input encryption key
	li $v0, 5 
	syscall 
	move $t1, $v0
	
	
	
	
# $t0 will hold the n 
# $t1 will hold the e 
# $t2 is the temp `ch` variable
# $t3 is the address of the string
# $t4 is the index in loop
# $t5 pointer to indexed char
	# PROGRAM BODY 
	# foreach (i; 0..<n) {
	# 	
	# }
	move $t5, $t3 # t5 = &str[0]
	move $t4, $0 # i=0 
loop_body:
	lbu $t2, 0($t5) # load char
	blt $t2, 'A', endif 
	ble $t2, 'Z', elseif_upper
	
# islower	
	bgt $t2, 'z', endif 
	blt $t2, 'a', endif 
	addu $t2, $t2, $t1 # ch += e
	li $t6, 0x7A  
	blt $t2, $t6, endif # if ch < 0x7A {goto endif}
	subiu $t2, $t2, 26 # ch -= 26
	j endif
# isupper
elseif_upper:
	addu $t2, $t2, $t1 # ch += e
	li $t6, 0x5A
	blt $t2, $t6, endif # if ch < 0x5A {goto endif}
	subiu $t2, $t2, 26 # ch -= 26
	
endif:	
	sb $t2, 0($t5)
	addiu $t5, $t5, 1 # ptr++
	addiu $t4, $t4, 1 # i++
	blt $t4, $t0, loop_body # check i<n
	
	# print final result prompt 
	li $v0, 4
	la $a0, msg4 
	syscall 
	
	# print final result string
	li $v0, 4 
	move $a0, $t3
	syscall
	
	
	# exit
	li $v0, 10
	syscall 
			
