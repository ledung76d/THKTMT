.eqv MONITOR_SCREEN 0x10010000
.eqv WHITE 0x00FFFFFF

.text
	li $k0, MONITOR_SCREEN
	li $a0, WHITE
	li $a2, -1 # i = -1
	li $a1, 65
	li $a3, 2
	li $s0, 8
loop:
	addi $a2, $a2, 1
	beq $a2, $a1, exit
	div $a2, $a3
	mfhi $t0 # du cua hang /2
	div $a2, $s0
	mflo $t1
	div $t1, $a3
	mfhi $t1 # so cot
	bne $t0, $t1, loop
	sll $t0, $a2, 2
	add $t0, $t0, $k0
	sw $a0, 0($t0) # White
	j loop

exit: