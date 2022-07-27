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

#Insertion Sort
sort:
	li $t0, 1	# t0 = i =1
	li $t1, 0	# t1 =  key = 0
	li $t2, 0 	# t2 = j = 0

loop:
	slt 
while:

end_loop:

end_while: