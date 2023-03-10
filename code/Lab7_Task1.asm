# TASK 1 
# using the stack 
# run the f();
#
# void f() { 
# 	int array[10]; 
# 	read(array, 10); 
# 	reverse(array, 10); 
# 	print(array, 10); 
# }

.globl main 

.data 
msg1: .asciiz "Enter integer "
colon: .asciiz ": "
msg2: .asciiz "Integer reversed = " 

.text
main: 
	jal f
	
	
	# exit
	li $v0, 10 
	syscall 

# read(int[], int)
read: 
	move $t0, $0
	move $t1, $a0
	move $t2, $a1
	# for (i: 0..<n) { }
loop_read: 
	bge $t0, $t2, endLoop_Read
	# print string read prompt
	li $v0, 4 
	la $a0, msg1 
	syscall 
	# print i+1
	li $v0, 1
	addiu $a0, $t0, 1 
	syscall
	
	# print colon
	li $v0, 4 
	la $a0, colon 
	syscall
	
	# read integer
	li $v0, 5
	syscall 
	sw $v0, ($t1)
inc_read: 
	# i++, stack_ptr++ (using sizeof(int))
	addiu $t0, $t0, 1 
	addiu $t1, $t1, 4 # 32 bit
	b loop_read
	
endLoop_Read: 
	jr $ra 
	
# reverse(int[], int) 
reverse:
	move $t0, $0 
	move $t1, $a0 
	# get address of the last element
	move $t2, $a1 
	subi $t2, $t2, 1
	sll $t2, $t2, 2
	addu $t2, $t2, $t1
	
loop_rev: 
	bge $t1, $t2, endLoop_rev
	# ALGORITHM
	# int t = arr[i]
	# arr[i] = arr[j]
	# arr[j] = t
	lw $t3, ($t1) # t
	lw $t4, ($t2) # arr[j]
	sw $t4, ($t1)
	sw $t3, ($t2)

inc_rev: 
	addiu $t0, $t0, 1
	addiu $t1, $t1, 4  # ptr.begin()++
	addiu $t2, $t2, -4 # ptr.end()--
	j loop_rev

endLoop_rev: 
	jr $ra 

# print(int[], int)
print: 
	move $t0, $a0 # store arr addr
	move $t2, $a1 
	# print string output prompt
	li $v0, 4
	la $a0, msg2
	syscall 
	

	# address of last el + 1	
	subi $t2, $t2, 1
	sll $t2, $t2, 2
	addu $t2, $t2, $t0
	addiu $t2, $t2, 1
loop_pr: 
	bge $t0, $t2, end_pr
	
	# print int 
	li $v0, 1 
	lw $a0, ($t0)
	syscall
	
	# print space
	li $v0, 11
	li $a0, ' '
	syscall
	
inc_pr:
	addiu $t0, $t0, 4
	j loop_pr
end_pr:
	jr $ra 

# f() 
f: 
	addiu $sp, $sp, -44 # allocate stack frame = 44 bytes 
	sw $ra, 40($sp) # save $ra on the stack 
	move $a0, $sp # $a0 = address of array on the stack 
	li $a1, 10 # $a1 = 10 
	jal read # call function read 
	move $a0, $sp # $a0 = address of array on the stack 
	li $a1, 10 # $a1 = 10 
	jal reverse # call function reverse 
	move $a0, $sp # $a0 = address of array on the stack 
	li $a1, 10 # $a1 = 10 
	jal print # call function print 
	lw $ra, 40($sp) # load $ra from the stack 
	addiu $sp, $sp, 44 # Free stack frame = 44 bytes 
	jr $ra # return to caller