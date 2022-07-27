#Laboratory Exercise 4, Home Assignment 1
.text
start:
	addi 	$s1,$zero, 0xffffffff  	#s1 = -4
	addi  $s2,$zero,  0x80000000	#s2 = 10
	
	li  	$t0,0 			#No Overflow is default status
	addu	$s3,$s1,$s2		# s3 = s1 + s2
	xor 	$t1,$s1,$s2 		#Test if $s1 and $s2 have the same sign
	bltz 	$t1,EXIT		#If not, exit
	
	
	
	xor $t1, $s3, $s2		#check s1, s3 have sign
	bgtz $t1, EXIT		# neu cung dau => exit
	
OVERFLOW:
	li 	$t0,1 			#the result is overflow
EXIT:
