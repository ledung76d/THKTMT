.data
A: 	.word 1,2,3,-4,5,6,-2,-8
.text
main: 
    la $a0,A    		#$a0 = Address(A[0])
    li $s0, 8  			#length of array $s0,  length 
    j sort      		#sort
end_sort: 
    li $v0, 10 		#exit
    syscall
end_main:

#Bubble sort algorithm
sort:
    	li $t0, 0   				# $t0 = i = 0
loop1:
     	slt $v0, $t0, $s0     	 	# set $v0 = 1 when i < length
    	beq $v0, $zero, end_sort   	# end loop when i >= length
    	li 	$t1, 0   			# $t1 = j = 0
loop2:
	addi	$t2, $s0, -1
	sub	$t2, $t2, $t0		# $t2 = temp = n-i-1 
	slt 	$v0, $t1, $t2   		# set $v0 = 1 when j < temp
    	beq	$v0, $zero, end_loop2
if:
    	sll 	$t5, $t1, 2			# $t5 = 4*j
    	add 	$t5, $t5, $a0		# $t5 is address A[j]
    	lw 	$t3, 0($t5)    		# Load $t3 = A[j]
    	lw	$t4, 4($t5)			# $t4 = A[j+1]
    	sub 	$v0, $t3, $t4		# v0 = $t3 - $t4 =  A[j] - A[j+1]
    	slt	$v0, $v0,$zero		# v0 = 1 if A[j] - A[j+1]  < 0
    	
    	beq 	$v0, $zero, end_if   	# End_if if A[j] > A[j+1]
    	sw	$t4, 0($t5)
	sw	$t3, 4($t5)
end_if:
	addi 	$t1, $t1, 1			# j++
    	j 	loop2
end_loop2:
    	addi	$t0, $t0, 1			# i++
    	j 	loop1

 

 
