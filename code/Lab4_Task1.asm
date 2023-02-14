.globl main

.data 
msg: .asciiz "Enter a character: "
newline: .asciiz "\n"
lower: .asciiz "Lowercase"
upper: .asciiz "Uppercase"
digit: .asciiz "Digit" 
special: .asciiz "Special Character"


.text 
# psuedo code 
# if ('a' <= c && 'z' >= c) return lower;
# if ('A' <= c && 'Z' >= c) return upper;
# if ('0'<= c && '9' >= c) return digit; 
# return special;

main:
	la $a0, msg
	li $v0, 4 
	syscall 
	
	li $v0, 12  
	syscall
	move $t0, $v0 # store 
	
	# print newline 
	li $v0, 4 
	la $a0, newline
	syscall

# c is t0	
# if ('a' <= c && 'z' >= c) return lower;
	bge $t0, 'a', lower2
	j upper1
lower2: 
	ble $t0, 'z', print_lower 
	
# if ('A' <= c && 'Z' >= c) return upper;
upper1: 
	bge $t0, 'A', upper2
	j digit1
upper2: 
	ble $t0, 'Z', print_upper 
	
# if ('0'<= c && '9' >= c) return digit; 
digit1: 
	bge $t0, '0', digit2
	j print_special
digit2: 
	ble $t0, '9', print_digit
# else all are special;
	j print_special 
	
# load the specific string for output prompt		
print_lower: 
	la $a0, lower 
	j done_load
	
print_upper: 
	la $a0, upper 	
	j done_load
	
print_digit: 
	la $a0, digit 
	j done_load

print_special: 
	la $a0, special 
	j done_load 
	
done_load: 
	# print preloaded string address
	li $v0, 4 
	syscall
	
	# exit
	li $v0, 10 
	syscall 
	
