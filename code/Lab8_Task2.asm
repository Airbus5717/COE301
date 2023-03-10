# Task 2 
.globl main
.eqv KEY_REG_ADDR 0xffff0000
.eqv DISP_CNTRL_REG 0xffff0008
.text
main:

	li $t0, KEY_REG_ADDR # KEYBOARD REGISTER ADDRESS
wait_keyboard:
	lw $t2, ($t0) # Read the keyboard control register
	andi $t2, $t2, 1 # Extract ready bit
	beqz $t2, wait_keyboard # loop back while not ready
	lw $a0, 4($t0) # Get character from keyboard

check_lower: 
	bge $a0, 'a', lower
	bge $a0, 'A', upper
	j break_check
lower:
	# toupper
	bgt $a0, 'z', break_check
	subi $a0, $a0, 32
	j break_check
upper:	
	# tolower
	bgt $a0, 'Z', break_check
	addi $a0, $a0, 32
	j break_check
break_check:


	li $t0, DISP_CNTRL_REG # Address of display control register
wait_display:
	lw $t2, ($t0) # Read the display control register
	andi $t2, $t2, 1 # Extract ready bit
	beqz $t2, wait_display # loop back while not ready
	sw $a0, 4($t0) # Send character to display

	j main
