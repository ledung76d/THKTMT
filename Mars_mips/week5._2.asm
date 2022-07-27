.data
	mess1: .asciiz 	"The sum of "
	mess2: .asciiz 	" and "
	mess3: .asciiz 	" is "
	
.text 
	li	$s0, 30		# s0 = 20
	li	$s1, 20		# s1 = 30
	add 	$s2, $s0, $s1	# s2 = s0 + s1
	
	li $v0, 4
	la $a0, mess1		#print "The sum of "
	syscall
	
	li $v0, 1
	add $a0, $zero, $s1 	# $a0 = $s1
	syscall	
	
	li $v0, 4
	la $a0, mess2		#print "and "
	syscall
	
	li $v0, 1
	add $a0, $zero, $s2 	# $a0 = $s2
	syscall	
	
	li $v0, 4
	la $a0, mess3		#print "is "
	syscall
	
	li $v0, 1
	add $a0, $s1, $s2 		# a0 = s1 + s2
	syscall	
	
	
	
	
	
	
	
	
	
	