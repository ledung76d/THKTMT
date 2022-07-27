.text
	li	$s1, 4			#s1 = 4
	li	$s2, 4			#s2 = 5
	slt	$t1, $s1, $s2	# s1 < s2  ? t1 = 1: t1 =0
	bne	$t1, $zero, L	#  s1 ! = 0 -> L if(  s1 < s2) -> L
	beq	$s1, $s2, L		# s1 = s2 -> L	if(s1 =s2) -> L
	j end 
L:
	add	$t0, $s1, $s2
end: