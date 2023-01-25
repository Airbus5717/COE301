# NOTE: useful macros for general development  


# exit program
# no params required
.macro exit() 
	li $v0, 10
	syscall
.end_macro

# print strings
# param(s): string input
.macro print_str(%s)
	la $a0, %s
	li $v0, 4
	syscall
.end_macro

# print int
# param(d): int input
.macro print_int(%d)
	la $a0, %d
	li $v0, 1
	syscall
.end_macro

