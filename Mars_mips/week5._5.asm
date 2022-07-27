.data
	Message: .asciiz "\nChuoi nguoc: "
	buffer:  .space 50
.text
	la $s0, buffer		# Load address buffer
	li $s1, 0			# index = 0
	li $s2, 0			# i = 0
	li $t1, 20			# Max length
	li $t2, 10			#ASCII code '\n'
start_read_char:
	li  	$v0, 12	
	syscall
	add 	$s1, $s0, $s2	# Load new address buffer
	
	addi 	$s2, $s2, 1		# i++
	sb	$v0,   0($s1)	# save byte v0 to address s1
	beq	$s2, $t1, end_read_char		# exit when max length
	beq	$v0, $t2, end_read_char		# exit when enter
	
	j start_read_char

end_read_char:
	li $v0, 4
	la $a0, Message		#  Message: "\nChuoi nguoc: "
	syscall
Reverse_string:			
	li 	$v0, 11		# Print charecter
	lb	$a0, 0($s1)		
	syscall
	
	beq 	$s1, $s0, exit	
	addi	$s1, $s1, -1		
	j Reverse_string
exit:
	
	