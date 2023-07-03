.data
prompt: .asciiz "Please enter a non-negative intenger: "
result: .asciiz "Hex: "

.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $v0, $t1