	
	.eqv MONITOR_SCREEN 0x10010000
	.eqv RED 0x00FF0000
	.eqv GREEN 0x0000FF00
	.eqv BLUE 0x000000FF
	.eqv WHITE 0x00FFFFFF
	.eqv YELLOW 0x00FFFF00
.text
	
	li $k0, MONITOR_SCREEN
	li $t0, RED

	
main:	
	li $t0, GREEN
	li $t1, 0	# i = 0
	li $t2, 0	# j = 0
	li $t4, 0
	jal loop1
	li $t0, RED
	li $t1, 2	# i = 0
	li $t2, 2	# j = 0
	li $t4, 0
	jal loop1
exit: 
	sw $t0, 0($k0)
	li $t0, WHITE
	sw $t0, 4($k0)
	li $t0, BLUE
	sw $t0, 8($k0)
	li $t0, WHITE
	sw $t0, 12($k0)
	li $t0, YELLOW
	sw $t0, 64($k0)
	li $t0, YELLOW

	li $v0, 10
	syscall	
	
#Vong lap 

loop1:
	slti $t3, $t1, 16
	beq $t3, $zero, endloop1
	
	j loop2

	
loop2:
	sll  $t4, $t1, 6
	slti $t3, $t2, 16
	beq $t3, $zero, endloop2
	
	sll  $t5, $t2, 2
	add $t5, $t4, $t5
	add $t5, $t5, $k0
	
	
	sw $t0, 0($t5)
	
	addi $t2, $t2, 1 		# tang j len 1
	j loop2
endloop2:
	addi $t1, $t1, 1  		# tang i len 1	
	li $t2, 0
	j loop1
endloop1:
	jr $ra


