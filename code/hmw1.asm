# Homework1 
# READ THE WORDS, LETTERS, 
# NUMBERS AND DIGITS IN FILE data.txt

.globl main 

.eqv FILE_READ 0

# print string literal
.macro print_string(%s) 
.data 
str_ptr: .asciiz %s
.text 
	li $v0, 4 
	la $a0, str_ptr
	syscall
.end_macro

# print word integer in register
.macro print_int_reg(%r) 
	li $v0, 1
	move $a0, %r
	syscall
.end_macro

# print string in data segment
.macro print_s(%d) 
	la $a0, %d
	li $v0, 4 
	syscall
.end_macro 

.macro print_newline 
	li $v0, 11
	li $a0, '\n'
	syscall
.end_macro

# increment register
.macro incr(%r) 
	addiu %r, %r, 1
.end_macro
# file_name: put a string literal
# file_addr: put a register to store buffer address
# len: put a register to store file length in 
# max_len: put an int literal for max length of the string
.macro read_file(%file_name, %file_addr, %len, %max_len)
.eqv FILE_READ 0 # define constant
.data 
filename: .asciiz %file_name	
# make sure u dont have another symbol called `buffer`
buffer: .byte 0:%max_len 
file_open_err_str: .asciiz "[ERROR]: error opening "
file_read_err_str: .asciiz "[ERROR]: error reading "
.text
	j macro_body # skip error printing
# error handling area 
file_open_err:
	la $a0, file_open_err_str
	j print_err
file_read_err: 
	la $a0, file_read_err_str 
	j print_err
print_err: 
	li $v0, 4 
	syscall 

	li $v0, 4 
	la $a0, filename
	syscall 

	print_newline 

	li $v0, 10 
	syscall
# macro code starts here
macro_body: 
	# open file 
	li $v0, 13
	la $a0, filename
	li $a1, FILE_READ
	syscall 

	blt $v0, $zero, file_open_err # assert file open

	# read file	
	move $a0, $v0 
	li $v0, 14
	la $a1, buffer
	li $a2, %max_len
	syscall 
	move %len, $v0 # len in %len
	la %file_addr, buffer # load string addr to buffer
	# assert file open
	blt $v0, $zero, file_read_err 
.end_macro

.data 

.text # program starting point 
main: 
	read_file("data.txt", $t0, $t1, 10000)
# t0: buffer ptr
# t1: file length (not needed)
# dicarded and used for dereferenced char
# t2: digits 
# t3: numbers 
# t4: letters 
# t5: words
	move $t2, $0 # init 0
	move $t3, $0 # init 0
	move $t4, $0 # init 0 
	move $t5, $0 # init 0 

loop: 
	lb $t1, ($t0) 
	beq $t1, $0, endLoop

checkDigit:
	blt $t1, '0', inc
	bgt $t1, '9', checkLetter

# cond #1 
isDigit: 
	incr($t3)	
isNum: 
	incr($t2)
	incr($t0) 
	lb $t1, ($t0)
	blt $t1, '0', inc
	bgt $t1, '9', checkLetter
	j isNum


checkLetter:	
# cond #2 
	# is cap letter?
	sle $t7, $t1, 'Z'
	sge $t8, $t1, 'A'
	and $t7, $t7, $t8
	bnez $t7, isLetter
	
	# is lower letter?
	sle $t7, $t1, 'z'
	sge $t8, $t1, 'a'
	and $t7, $t7, $t8
	bnez $t7, isLetter
	
	j inc

isLetter:
	incr($t5) # increment words count

isWord:
	incr($t4) # increment letter count
	incr($t0) # advance ptr
	lb $t1, ($t0)
	
	# is cap letter?
	sle $t7, $t1, 'Z'
	sge $t8, $t1, 'A'
	and $t9, $t7, $t8
	bnez $t9, isWord
	
	# is lower letter?
	sle $t7, $t1, 'z'
	sge $t8, $t1, 'a'
	and $t9, $t7, $t8
	bnez $t9, isWord
	j loop

# ptr++	
inc: 
	incr($t0)
	j loop	

endLoop: 

# output results 
	print_string("Letters = ")
	print_int_reg($t4)
	print_newline 
	print_string("Digits = ")
	print_int_reg($t2)
	print_newline
	print_string("Words = ")
	print_int_reg($t5)
	print_newline
	print_string("Numbers = ")
	print_int_reg($t3)
	print_newline

