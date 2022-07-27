.data 
	Mess1: .asciiz "Nhap toa do: "
	Mess2: .asciiz "\n "
	MessX1: .asciiz "x1: "
	MessY1: .asciiz "y1: "
	MessX2: .asciiz "x2: "
	MessY2: .asciiz "y2: "
	
		
	.eqv MONITOR_SCREEN 0x10010000
	.eqv RED 0x00FF0000
	.eqv GREEN 0x0000FF00
	.eqv BLUE 0x000000FF
	.eqv WHITE 0x00FFFFFF
	.eqv YELLOW 0x00FFFF00
.text
	
	li $k0, MONITOR_SCREEN
		
main:	
	# ve vien hcn
	jal input
	li $t1, 0	# i = 0
	li $t2, 0	# j = 0
	li $t0, RED
	jal loop1
	# ve hcn
	addi $s1,$s1,1
	addi $s2,$s2,1
	addi $s3,$s3,-1
	addi $s4,$s4,-1
	li $t1, 0	# i = 0
	li $t2, 0	# j = 0
	li $t0, GREEN
	jal loop1
exit: 
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
	add $t5, $t5, $k0		# t5 = k0 + 64i+ 4j
	
	addi $t2, $t2, 1 		# tang j len 1
	
	
	j if
endloop2:
	addi $t1, $t1, 1  		# tang i len 1	
	li $t2, 0
	j loop1

endloop1:
	jr $ra
	
# kiem tra dieu kien de ve	
if:
	
	slt $t3,  $s2, $t1		# y1 < i
	beqz $t3, loop2		# neu t1 <= x1 tro ve vong lap loop2
	
	slt $t3,  $t1	,$s4		# i  < y2		
	beqz $t3, loop2		# neu t1 >= x2 tro ve vong lap loop2
	
	
	
	slt $t3,  $s1,$t2		# x1 < j
	beqz $t3, loop2
	
	
	slt $t3,  $t2,$s3		# x2 < j
	beqz $t3, loop2
	
	

	sw $t0, 0($t5)
	j loop2
	
	

# nhap du lieu			
input: 
	la $a0,Mess1
	li $v0,4		# Nhap toa do: 
	syscall
	
	la $a0,Mess2
	li $v0,4		 
	syscall
	
	
	la $a0,MessX1
	li $v0,4		# x1: 
	syscall
	
	li $v0,5
	syscall		# Luu du lieu tu ban phim
	addi $s1,$v0,-1

	
	la $a0,MessY1
	li $v0,4		# y1: 
	syscall
	
	li $v0,5
	syscall		# Luu du lieu tu ban phim
	addi $s2,$v0,-2
	
	la $a0,Mess1
	li $v0,4		# Nhap toa do: 
	syscall
	
	la $a0,Mess2
	li $v0,4		 
	syscall
	
	la $a0,MessX2
	li $v0,4		# x2: 
	syscall
	
	li $v0,5
	syscall		# Luu du lieu tu ban phim

	addi $s3,$v0,3
	
	la $a0,MessY2
	li $v0,4		# y2: 
	syscall
	
	li $v0,5
	syscall		# Luu du lieu tu ban phim
	addi $s4,$v0,2
	jr $ra
	
	
