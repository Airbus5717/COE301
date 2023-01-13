# NOTE: useful macros for general development  


# to exit program
# no params required
.macro exit() 
	li $v0, 10
	syscall
.end_macro
