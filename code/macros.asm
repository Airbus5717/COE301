# NOTE: useful macros for general development  


# to exit program
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
