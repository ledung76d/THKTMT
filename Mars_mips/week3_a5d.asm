#Laboratory 3, Home Assigment 2
.data
A: .word  1,0,0,-25,5
.text
	addi $s5, $zero, 0 # max = 0
	addi $s1, $zero, 0 # i = 0
	la   $s2, A	# gan dia chi dau mang A cho $s2
	li   $s3, 5	# n = 5
	li   $s4, 1	# step = 1
	
loop:   
	slt $t2, $s1, $s3 # $t2 = i < n ? 1 : 0
	beq $t2, $zero, endloop 
	add $t1, $s1, $s1 # $t1 = 2 * $s1
	add $t1, $t1, $t1 # $t1 = 4 * $s1
	add $t1, $t1, $s2 # $t1 store the address of A[i]
	lw $t0, 0($t1) # load value of A[i] in $t0
	bgtz $t0, if  
	sub $t0, $zero, $t0 
	
if:
	slt $t6,$s5,$t0	 # $t6 = max < n? 1 : 0 
	beq $t6, $zero, endif # $t6 = 0 branch endif
	add $s5, $t0, $zero # max = A[i]
endif:
	add $s1, $s1, $s4 # i = i + step
	j loop # goto loop
endloop:
