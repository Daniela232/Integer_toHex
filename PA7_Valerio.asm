.data
prompt: .asciiz "Please enter an integer for the array size : "
input: .asciiz "Enter number: "
sorted: .asciiz "The array sorted: \n"
nl : .asciiz "\n"
.text

main: 
	li $v0, 4 
	la $a0, prompt 
	syscall 

	li $v0, 5 
	syscall 
	move $s1, $v0 

	mul $a0, $s1, 4 
	
	li $v0, 9
	syscall 
	
	add $s0, $v0, $0 
	li $t0,0

inputLoop:

	slt $t1, $t0, $s1 
	beq $t1, $0, endInputLoop 
	sll $t2, $t0, 2 
	
	li $v0, 4 
	la $a0, input 
	syscall

	li $v0, 5 
	syscall 

	add $t3, $s0, $t2 
	sw $v0, 0($t3) 
	addi $t0, $t0, 1 

	j inputLoop 

endInputLoop:

	addi $a0, $s0, 0 
	addi $a1, $s1, 0 

	jal bubble_sort
	addi $a0, $s0, 0 
	addi $a1, $s1, 0 

	li $t0, 0
	addi $s6, $a0, 0 

	la $a0, sorted 
	li $v0, 4
	syscall

printLoop:
	beq $t0, $s1, exit
	lw $a0, 0($s6) 
	li $v0, 1
	syscall

	li $v0, 4 
	la $a0, nl
	syscall

	addi $s6, $s6, 4 
	addi $t0, $t0, 1 
	j printLoop

exit:
	li $v0, 10
	syscall 



bubble_sort:
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	li $t0, 0 
	addi $s7, $a0, 0 
	
first: 
	bge $t0, $a1, return 
	addi $s3, $s7, 0 
	li $t1, 0 
	addi $t2, $s1, -1 
	sub $t2, $t2, $t0 

second:
	bge $t1, $t2, secondEnd 

	lw $t3, 0($s3)
	lw $t4, 4($s3) 
	ble $t3, $t4, skip 
	addi $a0, $s3, 0 
	j swap 

skip:
	addi $t1, $t1, 1 
	addi $s3, $s3, 4 
	j second

secondEnd: 
	addi $t0, $t0, 1
	j first

return :
	lw $ra, 0($sp) 
	addi $sp, $sp, 4
	jr $ra
swap:
	lw $t5, 0($a0) 
	lw $t6, 4($a0) 
	sw $t6, 0($a0) 
	sw $t5, 4($a0) 
	j skip 


