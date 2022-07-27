.text
start:
	li 	$s1, -40			# s1 = -40	
	bgtz 	$s1, 	positive		# if(s1>0) then positive
	sub 	$s0, $zero, $s1		#s0 = 0 - s1
	j end
positive:
	add $s0, $zero, $s1		#s0=0 + s1
end:
