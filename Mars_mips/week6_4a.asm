.data
    A: .word 1,2,3,-4,5,6,-2,-8
.text
main: 
    la $a0,A    #$a0 = Address(A[0])
    li $s0, 8  #length of array $s0,  length 
    j sort      #sort
end_sort: 
    li $v0, 10 #exit
    syscall
end_main:



#Insertion sort
sort:
    li $t0, 1   # $t0, i = 1
    li $t1, 0   # $t1, key = 0
    li $t2, 0   # $t2, j = 0
loop:
     slt $v0, $t0, $s0      			# set $v0 = 1 when i < length
     beq $v0, $zero, end_sort   		# end loop when i >= length
     sll	  $t3, $t0, 2				# $t3 = 4*i
     add $t3, $t3, $a0      		# $t3 is address A[i]
     lw $t1, 0($t3)         			# key = A[i]
     add $t2, $t0, -1      			# j = i - 1
while:
    slt $v0, $t2, $zero     			# set $v0 = 1 when j < 0
    bne $v0, $zero, end_while
    sll	$t3,$t2,2				# $t3 = 4*j 
    add $t3, $t3, $a0       		# $t3 is address A[j]
    lw $t4, 0($t3)          			# Load A[j]
    slt $v0, $t4, $t1       			# set $v0 = 1 when A[j] < key
    beq $v0, $zero, end_while   		# End while if key <=  A[j]
    sw $t4, 4($t3)          			# A[j+1] = A[j]
    add $t2, $t2, -1        			# j = j - 1
    j while
end_while:
    sll	$t3,$t2,2				# $t3 = 4*j 
    add $t3, $t3, $a0       		# $t3 is address A[j]
    sw $t1, 4($t3)          			# A[j+1] = key
    add $t0, $t0, 1         			# i = i + 1
    j loop
  

 
