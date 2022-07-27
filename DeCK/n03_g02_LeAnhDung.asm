# MMIO Simulator
.eqv KEY_CODE		0xFFFF0004
.eqv KEY_READY		0xFFFF0000
.eqv DISPLAY_CODE 	0xFFFF000C 	# ASCII code to show, 1 byte
.eqv DISPLAY_READY 	0xFFFF0008 	# =1 if the display has already to do
 					# Auto clear after sw
# Led 7 doan			
.eqv SEVENSEG_RIGHT 	0xFFFF0010 	# Dia chi cua den led 7 doan phai
.eqv SEVENSEG_LEFT	0xFFFF0011 	# Dia chi cua den led 7 doan trai

.eqv LIMIT_TIME		2000000		# Gioi han thoi gian 200000 chu ki ngat

.data
	string: .asciiz "Nhom ky thuat dien tu Nguyen Tien Viet yeu mon Kien truc may tinh"
	buffer: .space 200
	enter: .asciiz "\n\n"
    	gach: .asciiz "/"
	ki_tu_dung: .asciiz "\nso ky tu dung la: "
	wpm: .asciiz "\nWPM(So tu tren mot phut): "
	speed: .asciiz "\nTime: "
	giay: .asciiz	" s"
	word: .asciiz "\nTong so tu la: "
	come_back: .asciiz "Ban co muon quay lai chuong trinh? "
	stringIsEmpty: .asciiz "\nERROR: Chuoi dau vao buffer bi rong\n Nhap lai chuoi de test toc do"
.text
	li $t7, 1				# Bien kiem tra giup tranh in xau mau 2 lan
begin:
	
	li $t0, 1			
	sb $t0, 0xFFFF0013($zero)	# Set bit tai 0xFFFF0013 khac 0 de kich hoat ngat
					            # Sau 30 cau lenh se ngat 1 lan						
	li $t0, 0			        # Bien dem i = 0
	li $s0, 0			        # $s0 Dem so chu ky ngat
	li $t5, 0			        # Bien dieu kien dem so chu ky
					            # $t5 = 0: Chua dem, $t5 = 1: Bat dau dem chu ky
#Hien thi chuoi string mau
dis_String:
WaitForDis: 
	beq $t7,$zero,input_keyboard		# Chuyen den cho nhap du lieu
	nop
		
	lw $t2, DISPLAY_READY		    # Vong lap cho display san sang
 	beq $t2, $zero, WaitForDis 	    # 
 	nop
 	lb $t1, string($t0)		        # Doc string[i]
 	beq $t1, '\0', input_keyboard 	# if string[i] == NULL then break
	nop
	
	sw $t1, DISPLAY_CODE		    # Hien thi string[i]
	add $t0, $t0, 1 		        # i++
	j dis_String			        # Lap lai vong lap
#Lay du lieu tu keyboard
input_keyboard:
	li $t7, 0
	li $t0, 0			    # Bien dem i = 0

WaitForKey:
	lw $t4, KEY_READY	    # Vong lap cho ban phim san sang
 	beqz $t4, WaitForKey	#
 	nop
 	li $t5, 1		        # Dat $t5 = 1, Bat dau dem cac chu ky ngat
 	lw $t3, KEY_CODE	    # Doc ky tu tu ban phim
 	beq $t3, 8, backspace	# Kiem tra nut xoa
 	nop
 	beq $t3, 10, exit	    # Ket thuc go neu nguoi dung nhan enter
 	nop
	sb $t3, buffer($t0)	    # Luu lai phim vua go

 	add $t0, $t0, 1		    # i++
 	sb $zero, buffer($t0)	 # Reset ki tu sau ve null
 	j WaitForKey
#Gap ky hieu xoa
backspace:
 	beqz $t0, WaitForKey	# if i == 0 {lap lai vong lap}
 	nop
 	sb $zero, buffer($t0) 	# else{ buffer[i] = NULL;
 	add $t0, $t0, -1		#	i--;}
 	sb $zero, buffer($t0)	# Ky tu vua xoa cung gan bang null
 	j WaitForKey			# Lap lai vong lap
 	
 #Ket thuc chuong trinh	
exit:
	li $t5, 0 		        # Khong dem chu ki nua
	move $t6, $t0	        # luu so ky tu da go vao t6
	beqz $t6,error
	nop
	
	li $s4, 0		        # dung: $s4 dem so ky tu go dung
	li $t0, 0		        # i: $t0 bien dem
	
#Kiem tra ki tu dung
true_character:
	lb $t1, string($t0) 		# $t1 = string[i]
	lb $t2, buffer($t0)	    	# $t2 = buffer[i]
	beqz $t2, showOutput		# if(buffer[i] == NULL) break;
	nop
	bne $t1, $t2, next_char		# If (String[i] == buffer[i])
	nop
	
	add $s4, $s4, 1		    #	dung++;
next_char:
	add $t0, $t0, 1		    # i++;
	j true_character		    # Lap lai vong lap
	nop
	
showOutput:

	li $t0, 0			
	sb $t0, 0xFFFF0013($zero)	# Set bit tai 0xFFFF0013 khac 0 de kich hoat ngat
#in xau tu ban phim	
	li $v0, 4		
	la $a0, buffer	
	syscall		                # In xau thu duoc tu ban phim
	
#in So ky tu dung
	li $v0, 4				#
	la $a0, ki_tu_dung			#
	syscall				# In message ki_tu_dung
	
	move $a0, $s4			#
	li $v0, 1				# In so ky tu go dung ra man hinh console
	syscall				#
	
	li $v0, 4				#
	la $a0, gach			#
	syscall				# In message ki_tu_dung
	
	move $a0, $t6			#
	li $v0, 1				# In so ky tu go dung ra man hinh console
	syscall				#
	
#Hien den led	
	li $s2, 10 
	div $s4, $s2    			# Chia so ki tu go dung cho 10
	
	mflo $t0				# Lay so thuong ( Hang chuc)
	jal SET_DATA_FOR_7SEG	#
	move $a1, $a0			# Dat du lieu hang chuc cho led
	
	mfhi $t0				# Lay so du ( Hang don vi)
	jal SET_DATA_FOR_7SEG	# Dat du lieu hang don vi cho led
	
	jal SHOW_7SEG_RIGHT	# Hien thi hang don vi led phai
	jal SHOW_7SEG_LEFT	# Hien thi hang chuc led trai
#So go duoc	
	li $v0, 4		#
	la $a0, word		#
	syscall		# In xau word
	jal CHECK_WORD
	
	addi $a0, $s6,0	#
	li $v0, 1		# In ra tong so tu go duoc
	syscall		#
	
#In ra toc do hoan thanh
	li $v0, 4		#
	la $a0, speed	#In ra xau
	syscall		# 

	
	div $a0, $s0,54000#
	addi $t6, $a0,0
	li $v0, 1		#  Tong thoi gian go
	syscall		#
	
	li $v0, 4		#
	la $a0, giay		#
	syscall		# In message 
	
	
#	addi $a0, $s0,0	#
#	li $v0, 1		#  Tong so ky tu da go
#	syscall		#
	
	#jal RESET_BUFFER	
#Toc do go wpm 
	li $v0, 4		#
	la $a0, wpm		#
	syscall		# 
	
	
	

	mul $a0, $s6,60	# wpm = so tu * 60/ thoi gian go
	div $a0, $a0,$t6
	li $v0, 1		# In ra tong so tu go duoc
	syscall		#
	
	
			

	
# In dau xuong dong	
	li $v0, 4		#
	la $a0, enter		#
	syscall		# 
	
	li $s0, 0			        # $s0 Dem so chu ky ngat
	li $t5, 0			        # Bien dieu kien dem so chu ky
	
	
	li $v0, 50
	la $a0, come_back
	syscall
	beq $a0,0, begin	
	nop
	
	
	li $v0, 10		#
	syscall			# Goi thu tuc ket thuc chuong trinh
	
#-----------------------------------------------------------------------------------------------------	
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# @param [in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: 
 	sb $a0, SEVENSEG_RIGHT # assign new value
 	jr $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# @param [in] $a1 value to shown
# remark $t0 changed
#--------------------------------------------------------------- 	
SHOW_7SEG_LEFT:
 	sb $a1, SEVENSEG_LEFT # assign new value
 	jr $ra
#---------------------------------------------------------------
# Function SET_DATA_FOR_7SEG : Chuyen du lieu he 10 sang kieu ma hoa LED
# @param [in] $t0 gia tri he 10
# @return $a0 Ma hoa tung vung hien thi den led
#--------------------------------------------------------------- 	
SET_DATA_FOR_7SEG:
	beq $t0, 0, CASE_0
	beq $t0, 1, CASE_1
	beq $t0, 2, CASE_2
	beq $t0, 3, CASE_3
	beq $t0, 4, CASE_4
	beq $t0, 5, CASE_5
	beq $t0, 6, CASE_6
	beq $t0, 7, CASE_7
	beq $t0, 8, CASE_8
	beq $t0, 9, CASE_9
	nop
CASE_0:	li $a0, 0x3f
	j END_SET_DATA
CASE_1:	li $a0, 0x06
	j END_SET_DATA
CASE_2:	li $a0, 0x5B
	j END_SET_DATA
CASE_3:	li $a0, 0x4f

	j END_SET_DATA
CASE_4:	li $a0, 0x66
	j END_SET_DATA
CASE_5:	li $a0, 0x6D
	j END_SET_DATA
CASE_6:	li $a0, 0x7d
	j END_SET_DATA
CASE_7:	li $a0, 0x07
	j END_SET_DATA
CASE_8:	li $a0, 0x7f
	j END_SET_DATA
CASE_9:	li $a0, 0x6f
	j END_SET_DATA
END_SET_DATA:
	jr $ra		
#-----------------------------------------------------------------------------------------------------	
# Kiem tra so tu
CHECK_WORD:
	li $t0, -1			# bien dem i 
	li $t6, 0			# bien dem j 
	li $s6, 1 			# So tu trong chuoi
check_first_space:
	lb $t1, buffer($t6) 	# $t1 = buffer[0]
	bne $t1, ' ', for		# if(buffer[i] != ' ' ) chay den vong lap for
	nop
	addi $s6, $s6,-1		# So tu trong chuoi -1

for: 
	addi $t0, $t0,1		# i ++ ban dau i =0
	addi $t6, $t6,1		# j ++ ban dau j =1
	
	lb $t1, buffer($t0) 	# $t1 = buffer[i]
	beqz $t1, end_for 		# if(buffer[i] == NULL) break;
	nop
	bne $t1, ' ', for		# if(buffer[i] != ' ' ) quay tro lai for
	nop
	
	lb $t2, buffer($t6) 	# $t2 = buffer[i+1]
	bne $t2, ' ', count_word 	# if( buffer[i+1] != ' ') nhay den count_word
	nop
	
	j for
	nop
count_word:
	addi $s6, $s6,1		# Tang so tu len 1
	
	j for
	nop
	
end_for:
	addi $t0, $t0,-1				# t1 = t1 - 1 vi tri ki tu cuoi cung
	lb $t1, buffer($t0) 			# $t1 = buffer[i]
	
	bne $t1, ' ', END_CHECK_WORD	# if(buffer[i] != ' ' ) ket thuc chuong trinh con
	nop
	
	addi $s6, $s6,-1				#  if(buffer[i] != ' ' )  so tu -1
	
END_CHECK_WORD:
	jr $ra

# Thong bao loi
error:	
	li	$v0, 4					# "Error"
	la	$a0, stringIsEmpty
	syscall
	
	li $v0, 4			#
	la $a0, enter			#In dau xuong don
	syscall			# 
	
	j begin			# Quay tro lai chuong trinh nhap
	nop
	
	li $v0, 10			#
	syscall			# Goi thu tuc ket thuc chuong trinh

#-------------------------------------------------------------------------------------------------------
# XU LY NGAT CHUONG TRINH 	
.ktext 0x80000180 	
IntSR:
 move $t9, $at		        		# Luu lai gia tri thanh ghi $at
 mfc0 $v0, $13		        		# Kiem tra ma nguyen nhan ngat
 bne $v0, 1024, exit	   		# Ma ngat 1024 = 0x0000 0400, bo qua ma ngat do Counter cua Digit Lab Sim
 nop			              		# Ma ngat khac, la Loi => Ket thuc chuong trinh
   
 add $s0, $s0, $t5	        			# Tang bien dem so chu ky ngat, bien dem $s0 chi tang khi $t5 == 1 (Khi bat dau go)
 
 sge $v0, $s0, LIMIT_TIME		# Thoat neu dat so chu ky ngat toi da
 bnez $v0, exit			
 nop
 
 move $at, $t9		        		# Khoi phuc thanh ghi $at
return: eret 		        			# Quay lai vi tri ngat

