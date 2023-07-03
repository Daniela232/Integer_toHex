.data
prompt: .asciiz "Enter a number: "
result: .asciiz "Number of circles: "

.text
main:

	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	jal num_circles
	
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall
	
num_circles:
	li $t1, 0
	li $t2, 10
	li $t4, 8
	li $t5, 6
	li $t6, 9
	lw $t0, 0($sp)
loop:
	div $t0, $t2
	mflo $t0
	mfhi $t3
	beq $t3, $t4, sum2
	beq $t3, $t6, sum
	beq $t3, $t5, sum
	beqz $t3, sum
	beqz $t0, return
	b loop
sum:
	addi $t1,$t1, 1
	b loop
sum2:
 	addi $t1,$t1, 2
	b loop

return:	
	sw $t1, 4($sp)
	jr $ra
	