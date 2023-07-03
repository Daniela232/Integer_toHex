.data
prompt: .asciiz "Enter a number (enter -99 to exit): "
numOdd: .asciiz "The number of odd digits is: "
sumOdd: .asciiz "\nThe sum of all the odd digits is: "

.text
	li $s0, -99
	li $s1, 0
	li $s2, 2
	li $s3, 0
	
loop:
	li $v0, 4
	la $a0, prompt
	syscall	

	li $v0, 5
	syscall
	move $t1, $v0
	
	beq $s0, $t1, output	#if -99 is enter output the sum and counter

loopFindOdd:
	div $t1, $s2		#divides user input by 2
	mfhi $t3		#moves reminder to register $t3
	bgtz $t3, addOdd	#if the reminder is greater than 0, jump to addOdd
	b loop			#if reminder is equal to 0, jump back to the previous loop
	
addOdd:
	addi $s1, $s1, 1	#add 1 to the counter
	add $s3, $t1, $s3	#add user inputs
	b loop			#jump back to loop
	
output:				#output the counter and sum of the odd numbers
		
	li $v0, 4
	la $a0, numOdd
	syscall	
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, sumOdd
	syscall	
	
	li $v0, 1
	move $a0, $s3
	syscall

exit:
	li $v0, 10
	syscall