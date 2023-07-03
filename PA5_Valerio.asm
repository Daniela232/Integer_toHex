.data
prompt:  .asciiz "Enter a number: "	
space1:		.asciiz " "
nl:		.asciiz	"\n"

.text
main:	
	la $a0,prompt
	jal input 		#get first number
	move $s0,$v0		#first number in s2
	jal prtbin
	
	li $v0, 10
	syscall

#function to print numbers in binary --number is in s0
prtbin: 
        li $t2, 4           #bits between spaces
        li $t3, 0           #bits printed counter    
	li $t0, 0x80000000	#initial mask
	
nextdigit:
	and $t1, $s0, $t0     #extract bit
	beqz $t1,print	#0, so print it
	li $a0,1		#will print a 1							
	j printdigit	
	
print:	
	li $a0,0		#will print a 0	
	
printdigit: 
	li $v0, 1           #print the digit
	syscall
	addi $t3, $t3, 1       #count digit printed
	bne $t3, $t2, nospace #ready for a space?
	li $t3, 0           #space so reset counter
	la $a0, space1
	li $v0, 4		
	syscall			#and print the space
	
nospace:
	srl $t0 ,$t0, 1	#move mask 1
	bnez $t0, nextdigit   #while not shifted out
	la $a0, nl
	li $v0, 4
   	syscall
	jr $ra		#done printing
input:
	li $v0, 4
	syscall			#print prompt
	li $v0, 5	
	syscall			#input number
	jr $ra		#return
