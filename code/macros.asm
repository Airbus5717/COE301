# NOTE: useful macros for general development  
# exit program
# no params required
.macro exit() 
	li $v0, 10
	syscall
.end_macro

# print strings
# param(s): string address
.macro print_str(%s)
	la $a0, %s
	li $v0, 4
	syscall
.end_macro

# print string literals
# param(s): string literal
.macro print_strlit(%s)
.data
string_pointer: .asciiz %s
.text
	la $a0, string_pointer
	li $v0, 4
	syscall
.end_macro

# print int
# param(d): int register
.macro print_int(%d)
	la $a0, %d
	li $v0, 1
	syscall
.end_macro


# READ FILE 
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

	li $v0, 11
	li $a0, '\n'
	syscall

	li $v0, 10 
	syscall
# macro code starts here
macro_body: 
	# open file 
	li $v0, 13
	li $a1, FILE_READ
	la $a0, filename
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


# TODO:
# - for loop (maybe?)
