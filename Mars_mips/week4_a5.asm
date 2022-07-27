.text
	li $s0,5		# s0=3
	li $s1,16		# s1=16
	li $t0, 0 		# count = 0
LOOP:
	beq 	$s1,1,End	# s1 = 1 => end
	srl 	$s1,$s1,1 	#  s1/2;
	addi	$t0,$t0,1 	# count++
	j LOOP
End:
	sllv $s2,$s0,$t0