# Task2 

# Write a MIPS assembly program that asks the
# user for file name (max 50 chars). Open the
# file for reading. Next, read the file contents
# as characters (max 100 chars). After that,
# loop over each character, if the character is
# a digit (i.e. ‘0’ to ‘9’), convert it to integer and
# store it in another array called “array int”.
# Assume the maximum number of integers
# in the file is 20. Finally, print “array int” in
# reverse order.

.globl main

# define constants
.eqv FILE_READ 0


.data # static data segment
msg1: .asciiz "Enter filename: "
msg2: .asciiz "Integer array reversed = "
msg3: .asciiz "File open error\nProbably file doesnt exist\n"
msg4: .asciiz "File read error\nI cant read this file\n" 
filename: .space 50
filecontents: .space 100
array_int: .word 0:20

.text 
main: 
	# print string input prompt
	li $v0, 4
	la $a0, msg1
	syscall
	
	# read string filename 
	li $v0, 8
	la $a0, filename
	li $a1, 49
	syscall 
	
# fix file name
	la $t1, filename
   	li $s0, 0               # i=0
remove:
	lb $a3, filename($s0)      # Load character at index
	addi $s0, $s0, 1        # i++
    bnez $a3, remove   
    beq $a1, $s0, skip      
    subiu $s0, $s0, 2     # assuming '\n' is before the last char
    sb $0, filename($s0)        # Add the terminating character in its place
skip:

	# open file 
	li $v0, 13
	li $a1, FILE_READ
	la $a0, filename
	syscall 
	blt $v0, $zero, file_open_err # assert file open

	# read file	
	move $a0, $v0 
	li $v0, 14
	la $a1, filecontents
	li $a2, 99
	syscall 
	move $t0, $v0 # len in t0 

	# assert file open
	blt $v0, $zero, file_read_err 
	
	# str[len]=0; // add null char
	sb $0, filecontents+99 
	
# foreach() {
#   if ch == '\0'{ break; } 
# 	if ch >= '0' && ch <= '9' { 
#   	add ch to array
# 
# 	}
#   continue
# }
# $t0: file length 
# $t1: index 
# $t2: string ptr 
# $t3: ch
	move $t1, $zero # i=0
	move $t6, $zero # arrlen
	la $t2, filecontents # file ptr
	li $t4, 20
	la $t5, array_int
loop:
	#bge $t1, $t4, exitloop			
	lbu $t3, ($t2) # load char 
	beq $t3, $0, exitloop # exit if null char
	blt $t3, '0', inc # check if less than 0
	bgt $t3, '9', inc # check if greater than 9
	
	
save: #save word 
	subiu $t3, $t3, '0' # to get the original value
	sw $t3, ($t5) 
	addiu $t5, $t5, 4
	addiu $t6, $t6, 1

inc: #i++ and ptrs++
	
	addiu $t1, $t1, 1 # i++
	addiu $t2, $t2, 1 # file ptr++
	j loop

exitloop:	

	# print string result prompt
	li $v0, 4 
	la $a0, msg2 
	syscall

# for (i = len-1; i >=0; i--) { }	
# print int array reversed
	subiu $t6, $t6, 1
	# if len = 0 no res
	beq $t6, $zero, endrev
	
rev: 
	sll $t2, $t6, 2 # i*4
	la $t3, array_int
	addu $t2, $t3, $t2 
	
	lw $a0, ($t2)
	li $v0, 1 
	syscall 
	
	blt $t6, 0, endrev
	# print space
	li $v0, 11 
	li $a0, ' '
	syscall 
	
	subiu $t6, $t6, 1
	bne $t6, -1, rev
endrev: 
	
	# exit
	li $v0, 10 
	syscall 
	
# error msgs segment	
file_open_err:
	la $a0, msg3 
	j file_err
file_read_err:
	la $a0, msg4 
file_err: 
	# print preloaded string
	li $v0, 4 
	syscall 
	
	# exit
	li $v0, 10 
	syscall
