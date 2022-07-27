.eqv HEADING 0xffff8010 # Integer: An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
.eqv MOVING 0xffff8050 # Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 # Boolean (0 or non-0):
# whether or not to leave a track
.eqv WHEREX 0xffff8030 # Integer: Current x-location ofMarsBot
.eqv WHEREY 0xffff8040 # Integer: Current y-location ofMarsBot
.text

main: 
addi $a0, $zero, 120 # Marsbot rotates 90* and startrunning
jal ROTATE
jal GO
jal TRACK # draw track line
sleep0: addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
li $a0,1000
syscall
li $s1,'w' #w
li $s2,'a' #a
li $s3,'d' #d
li $s4,'s' #s
li $s5,' '
li $t6, 1
start:
	#la $a0,mess
	#li $v0,4
	#syscall
	#lw $a1, 0xffff0004
	
	li $v0,12
	syscall
	add $a1,$zero,$v0

	beq $a1,$s5,caseSpace
	li $t8,MOVING
	beq $t8,$zero,start
	beq $a1,$s1,caseW
	beq $a1,$s2,caseA
	beq $a1,$s3,caseD
	beq $a1,$s4,caseS
	j start
caseW:
	addi $a0, $zero, 0 # Marsbot rotates 90* and startrunning
	jal ROTATE

sleep1: 
	jal UNTRACK	 	# keep old track
	jal TRACK 			# and draw new track line
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,200
	syscall

	j start
caseS:
	addi $a0, $zero, 180 # Marsbot rotates 90* and startrunning
	jal ROTATE

sleep2: 
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,200
	syscall

	j start
caseD:
	addi $a0, $zero, 90 # Marsbot rotates 90* and startrunning
	jal ROTATE

sleep3: 
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,200
	syscall
	j start
caseA:
	addi $a0, $zero, 270 # Marsbot rotates 90* and startrunning
	jal ROTATE

sleep4: 
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,200
	syscall

	j start
caseSpace:
	beq $t6, $zero, goto 
	jal UNTRACK # keep old track
	li $t6,0
	jal STOP
	j start
	
goto:
	li $t6, 1
	jal TRACK # and draw new track line
	jal GO
	j start
end_main:

#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO: li $at, MOVING # change MOVING port
addi $k0, $zero,1 # to logic 1,
sb $k0, 0($at) # to start running
jr $ra
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP: li $at, MOVING # change MOVING port to 0
sb $zero, 0($at) # to stop
jr $ra
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK: li $at, LEAVETRACK # change LEAVETRACK port
addi $k0, $zero,1 # to logic 1,
sb $k0, 0($at) # to start tracking
jr $ra
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:li $at, LEAVETRACK # change LEAVETRACK port to 0
sb $zero, 0($at) # to stop drawing tail
jr $ra
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: li $at, HEADING # change HEADING port
sw $a0, 0($at) # to rotate robot
jr $ra
