#Laboratory Exercise 4, Home Assignment 1
.text
start:
	li 	$s0, 0x0f001234		
	andi	$t0, $s0, 0xff00000 	# extra MSB
	andi	$t1, $s0, 0xffffff00	# Clear LSB
	or	$t2, $s0, 0x000000ff	#Set LSB
	xor	$t3,$s0,$s0			#Clear $s0