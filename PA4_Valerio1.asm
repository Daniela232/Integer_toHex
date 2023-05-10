.data
prompt: .asciiz "Please enter a non-negative integer: "
result: .asciiz "Hex: 0x"
hex: .space 100   

.text
	li $t3, 0x0f 
	li $t1, 8      
	li $t2, 0    
	
	li $v0, 4
	la $a0, prompt
	syscall 
    
	li $v0, 5
	syscall
	move $t0, $v0     
loop:
	beq $t1, $zero, print  
	and $t4, $t0, $t3   
	addi $t4, $t4, 48   
	blt $t4, 58, store   
	addi $t4, $t4, 7    
store:
	sb $t4, hex($t1)   
	addi $t1, $t1, -1   
	srl $t0, $t0, 4     
	addi $t2, $t2, 1    
	b loop             

print:
	li $v0, 4
	la $a0, result
	syscall
	
	move $t1, $zero    
	li $t2, 9          
	b printLoop       

printLoop:
	beq $t2, $zero, exit 
	lb $a0, hex($t1)  
	li $v0, 11
	syscall
	
	addi $t1, $t1, 1   
	addi $t2, $t2, -1  
	b printLoop

exit:
	li $v0, 10         
	syscall

