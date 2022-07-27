.eqv HEADING 0xffff8010 # Integer: An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
.eqv MOVING 0xffff8050 # Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 # Boolean (0 or non-0):
# whether or not to leave a track
.eqv WHEREX 0xffff8030 # Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040 # Integer: Current y-location of MarsBot
.text
main:
	addi $a0, $zero, 135 # Marsbot rotates 135* and start running ( move to c
	jal ROTATE
	jal GO
sleep0: 
	addi $v0,$zero,32 # Keep running by sleeping in 12000 ms
	li $a0,14000
	syscall
	jal STOP
goE1: 
	addi $a0, $zero, 90 # Marsbot rotates 90*
	jal ROTATE
	jal TRACK # draw first edge
	jal GO
sleep1: 
	addi $v0,$zero,32 # Keep running by sleeping in 5000 ms
	li $a0,6000
	syscall
	jal STOP
	jal UNTRACK # keep old track
goE2: 
	addi $a0, $zero, 210 # Marsbot rotates 210*
	jal ROTATE
	jal TRACK # draw second edge
	jal GO
sleep2: 
	addi $v0,$zero,32 # Keep running by sleeping in 6000 ms
	li $a0,6000
	syscall
	jal STOP # keep old track
	jal UNTRACK
goE3: 
	addi $a0, $zero, 330 # Marsbot rotates 330*
	jal ROTATE
	jal TRACK # draw third edge
	jal GO
sleep3: 
	addi $v0,$zero,32 # Keep running by sleeping in 6000 ms
	li $a0,6000
syscall
jal STOP # keep old track
jal UNTRACK
end_main:
li $v0, 10
syscall
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
