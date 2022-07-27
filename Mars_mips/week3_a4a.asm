#Laboratory Exercise 3, Home Assignment 1

.text
	addi $s1, $zero 1 # i = 1
	addi $s2, $zero 5 # j = 5
	addi $s3, $zero 1 # m = 1
	addi $s4, $zero -1 # n = -1
	
	
	addi $t1, $zero 2 # x = 2
	addi $t2, $zero 3 # y = 3
	addi $t3, $zero 4 # z = 4
start:
	add $t0, $s1, $s2 # $t0 = i +j
	add $t4, $s3, $s4 # $t4 = m +n
	ble $t0, $t4, else	  # $t0 > 0 jumb to else  	 
	addi $t1,$t1,1 #then part: x=x+1
	addi $t3,$zero,1 # z=1
	j endif # skip “else” part
else: 
	addi $t2,$t2,-1 # begin else part: y=y-1
	add $t3,$t3,$t3 # z=2*z
endif:
