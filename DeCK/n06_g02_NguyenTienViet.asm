# Bai 6 - Final Project
.data
#-----------Pointer-----------
	CharPtr: 	.word 0		# Bien con tro, tro toi kieu asciiz
	BytePtr: 	.word 0		# Bien con tro, tro toi kieu Byte
	WordPtr: 	.word 0		# Bien con tro, tro toi kieu Word
	TwoDArrayPtr: 	.word 0		# Bien con tro, tro toi mang hai chieu kieu Word
	CharPtr1: 	.word 0		# Bien con tro, su dung trong copy xau
	CharPtr2: 	.word 0		# Bien con tro, su dung trong copy xau
#-----------Menu String-----------
	menu: 		.asciiz "                       Menu\n Vui long chon tu 1->8.\n Chon nut bat ki khac de thoat.\n1. Cap phat bo nho.\n2. Tra ve gia tri cua cac bien con tro.\n3. Tra ve dia chi cua cac bien con tro.\n4. Copy 2 con tro xau ki tu.\n5. Giai phong bo nho.\n6. Tinh toan luong bo nho da cap phat.\n7. Malloc2 (2D Array).\n8. setArray[i][j] va getArray[i][j]."
	malloc_menu: 	.asciiz "1. CharPtr\n2. BytePtr\n3. WordPtr\n4. Return main menu\n\nNhan nut khac: Exit"
	getset_menu: 	.asciiz "1. SetArray[i][j]\n2. GetArray[i][j]\n3. Return main menu\n\nNhan nut khac: Exit"
	char_str:	.asciiz	"\nNhap so phan tu cua mang kieu Char :"
	byte_str:	.asciiz "\nNhap so phan tu cua mang kieu Byte :"
	word_str:	.asciiz "\nNhap so phan tu cua mang kieu Word :"
	copy_str:	.asciiz "\nXau da duoc copy la : "
	nb_row:		.asciiz "\nNhap so hang cua mang :"
	nb_col:		.asciiz "\nNhap so cot cua mang :"
	input_row:	.asciiz "\nNhap i (so thu tu hang) :"
	input_col:	.asciiz "\nNhap j (so thu tu cot) :"
	input_val:	.asciiz "\nNhap gia tri gan cho phan tu cua mang :"
	output_val:	.asciiz "\nGia tri tra ve: "
	charPtr_add: 	.asciiz "\nCharPtr address: "
	bytePtr_add: 	.asciiz "\nBytePtr address: "
	wordPtr_add: 	.asciiz "\nWordPtr address: "
	arrayPtr_add:	.asciiz "\n2DArrayPtr address: "
	charPtr_val: 	.asciiz "\nCharPtr value: "
	bytePtr_val: 	.asciiz "\nBytePtr value: "
	wordPtr_val: 	.asciiz "\nWordPtr value: "
	arrayPtr_val:	.asciiz "\n2DArrayPtr value: "
	malloc_str:	.asciiz "\nBo nho da cap phat(Tinh ca byte cap de chuyen dia chi): "
	bytes_str:	.asciiz " bytes"
	input_str:	.asciiz "\nNhap vao xau ky tu: "
#-----------Success Messages-----------
	malloc_success:	.asciiz "\nCap phat bo nho thanh cong."
	free_success:	.asciiz "\nGiai phong bo nho thanh cong."
	set_success:	.asciiz "\nThem phan tu vao mang thanh cong.Vi tri : "
	address: 		.asciiz "\nAddress: "
#-----------Error Messages-----------
	bound_error:	.asciiz "\nError: Ngoai pham vi cua mang"
	null_error:	.asciiz "\nError: Chua khoi tao mang"
	overflow_error:	.asciiz "\nError: Gia tri input qua lon (> 2000)"
	negative_error:	.asciiz	"\nError: Gia tri input phai lon hon 0"
	zero_error:	.asciiz "\nError: Gia tri input phai khac 0"
#-----------Symbol Messages-----------
	arrow: 		.asciiz " --> "
	left_bracket:	.asciiz "["
	right_bracket:	.asciiz "]"
	brackets:	.asciiz "]["
	string_copy:	.space	100	# Xau copy

.kdata
	# Luu gia tri la dia chi dau tien cua vung nho con trong
	Sys_TheTopOfFree: 	.word 1
	# Vung khong gian tu do, dung de cap phat bo nho cho cac bien con tro
	Sys_MyFreeSpace:	

.text
	# Khoi tao vung nho cap phat dong
	jal	SysInitMem
	
main:
print_menu:
	la 	$a0, menu
	jal	integer_input		# Nhan tu ban phim
	move 	$s0, $a0		# switch case
	beq	$s0, 1, case1
	beq	$s0, 2, case2
	beq	$s0, 3, case3
	beq	$s0, 4, case4
	beq	$s0, 5, case5
	beq	$s0, 6, case6
	beq	$s0, 7, case7
	beq	$s0, 8, case8
	j	end			# Neu khac 1->11 => end
case1:
	la 	$a0, malloc_menu	# 3 lua chon tuong ung voi yeu cau 1
	li 	$v0, 51 
 	syscall 
  	move 	$s0, $a0      		# switch case 
  	beq 	$s0, 1, case1.1 	# Malloc CharPtr
  	beq 	$s0, 2, case1.2 	# Malloc BytePtr
  	beq 	$s0, 3, case1.3 	# Malloc WordPtr
  	beq 	$s0, 4, main 		# return menu
	j	end	
case1.1:					# Cap phat bien con tro Char, moi phan tu 1 byte
	la 	$a0, char_str
	jal	integer_input
	jal	check_input		# check_input (0 < input < 2000)
	move	$a1, $a0		# $a1 = so phan tu mang
	la	$a0, CharPtr		# $a0 = dia chi cua CharPtr 
	li	$a2, 1			# $a2 = kich thuoc Char = 1 byte
	jal	malloc			# Cap phat bo nho 
	j 	main

case1.2:					# Cap phat bien con tro Byte, moi phan tu 1 byte
	la	$a0, byte_str
	jal	integer_input
	jal	check_input		# check_input (0 < input < 2000)
	move	$a1, $a0		# $a1 = so phan tu cua mang 
	la	$a0, BytePtr		# $a0 = dia chi cua BytePtr 
	li	$a2, 1			# $a2 = kich thuoc Byte = 1 byte
	jal	malloc			# Cap phat bo nho
	j	main
			

case1.3:					# Cap phat bien con tro Word, moi phan tu 4 byte
	la	$a0, word_str
	jal	integer_input
	jal	check_input		# check_input (0 < input < 2000)
	move	$a1, $a0		# $a1 = so phan tu mang
	la	$a0, WordPtr		# $a0 = dia chi cua WordPtr 
	li	$a2, 4			# $a2 = kich thuoc Word = 4 bytes
	jal	malloc			# Cap phat bo nho
	j	main

case2:
	
	la	$a0, charPtr_val
  	li	$v0, 4
  	syscall
	la   	$a0, CharPtr		# CharPtr value
	jal	Ptr_val

	la	$a0, bytePtr_val
  	li	$v0, 4
  	syscall
	la   	$a0, BytePtr		# BytePtr value
	jal	Ptr_val
	
	la	$a0, wordPtr_val
  	li	$v0, 4
  	syscall
	la   	$a0, WordPtr		# WordPtr value
	jal	Ptr_val
	
	la	$a0, arrayPtr_val
  	li	$v0, 4
  	syscall
	la   	$a0, TwoDArrayPtr	# TwoDArrayPtr value
	jal	Ptr_val
	j	main

case3:
	
	la	$a0, charPtr_add
  	li	$v0, 4
  	syscall	
  	la   	$a0, CharPtr		# CharPtr address
	jal	Ptr_add
	
	la	$a0, bytePtr_add
  	li	$v0, 4
  	syscall
  	la   	$a0, BytePtr		# BytePtr address
	jal	Ptr_add
	
	la	$a0, wordPtr_add	
  	li	$v0, 4
  	syscall
  	la   	$a0, WordPtr		# WordPtr address
	jal	Ptr_add
	
	la	$a0, arrayPtr_add
  	li	$v0, 4
  	syscall
  	la   	$a0, TwoDArrayPtr	# TwoDArrayPtr address
	jal	Ptr_add
	j	main
case4:
input_string:
	li  	$v0, 54       			# Input
  	la   	$a0, input_str     		
  	la   	$a1, string_copy        	# Dia chi luu string dung de copy
  	li	$a2, 100			# So ki tu toi da = 100
  	syscall
  	la   	$a1, string_copy        	
  	la 	$s1, CharPtr1			# Load dia chi cua CharPtr1     
  	sw 	$a1, 0($s1) 			# Luu string vua nhap vao CharPtr1
  	la	$a0, copy_str			
	li	$v0, 4			
	syscall
copy:
	la	$a0, CharPtr2			# Load dia chi cua CharPtr2
	la   	$t9, Sys_TheTopOfFree   
	lw   	$t8, 0($t9) 			# Lay dia chi dau tien con trong
	sw   	$t8, 0($a0)    			# Cat dia chi do vao bien con tro
	lw 	$t4, 0($t9)            		# Dem so luong ki tu trong string
	lw	$t1, 0($s1)			# Load gia tri con tro CharPtr1
  	lw 	$t2, 0($a0)	   		# Load gia tri con tro CharPtr2
copy_loop: 
  	lb 	$t3, 0($t1)             	# Load 1 ki tu (tren cung) cua $t1 vao $t3
  	sb 	$t3, 0($t2)             	# Luu 1 ki tu cua $t3 vao $t2 
  	addi 	$t4, $t4, 1           		# so luong ki tu trong string += 1
  	addi 	$t1, $t1, 1            		# Chuyen sang dia chi ki tu tiep theo cua CharPtr1
  	addi 	$t2, $t2, 1            		# Chuyen sang dia chi ki tu tiep theo cua CharPtr2
  	beq 	$t3, '\0', end_copy    		# Check null = end string
  	j 	copy_loop 
end_copy: 
  	sw 	$t4, 0($t9)             	# Kich thuoc cap phat = do dai string
  	lw	$a0, 0($a0)			# Lay noi dung con tro CharPtr2
  	li 	$v0, 4                  	# In ra xau da copy		
  	syscall 
  	j 	main 

case5:					# Giai phong bo nho 
	li	$s6 , 0
	la	$a0, CharPtr	
	sw	$s6, 0($a0)
	la	$a0, BytePtr	
	sw	$s6, 0($a0)
	la	$a0, WordPtr	
	sw	$s6, 0($a0)
	la	$a0, TwoDArrayPtr	
	sw	$s6, 0($a0)	 	
	jal	SysInitMem			# Khoi tao lai vung cap phat dong
	la 	$a0, free_success	
	li 	$v0, 4				
	syscall
	j	main			
case6:					# Tinh luong bo nho da cap phat
	la 	$a0, malloc_str
	li 	$v0, 4				
	syscall
	jal 	MemoryCount			# tinh luong bo nho da cap phat va luu vao $v0
	move 	$a0, $v0
	li 	$v0, 1				# print integer
	syscall
	la 	$a0, bytes_str
	li 	$v0, 4				
	syscall
	j 	main

case7:					# Cap phat bo nho cho mang 2 chieu Malloc2
	la 	$a0, nb_row		
	jal 	integer_input 			# Nhap vao so hang
	jal 	check_input			
	move 	$s4, $a0
	la 	$a0, nb_col
	jal 	integer_input			# Nhap vao so cot
	jal 	check_input 
	move	$s5, $a0			
	move 	$a1, $s4 			# $a1 = so hang
	move 	$a2, $s5 			# $a2 = so cot
	la 	$a0, TwoDArrayPtr
	jal 	Malloc2 			# Cap phat bo nho cho mang 2 chieu								
	j 	main
case8:
	la 	$a0, getset_menu	# 2 lua chon get/set tuong ung yeu cau 8
	li 	$v0, 51 
 	syscall 
  	move 	$s0, $a0      		# switch case 
  	beq 	$s0, 1, case8.1 	# setArray[i][j]
  	beq 	$s0, 2, case8.2 	# getArray[i][j]
  	beq 	$s0, 3, main 		# return ti main menu
	j	end
case8.1:					# Set[i][j]
	la 	$a0, TwoDArrayPtr
	lw 	$s1, 0($a0)
	beqz 	$s1, nullptr 			# if *ArrayPtr==0 => null error
	la 	$a0, input_row
	jal 	integer_input 			# Nhap vao hang
	move 	$s2, $a0			
	la 	$a0, input_col
	jal 	integer_input  			# Nhap vao cot
	move 	$s3, $a0			
	la 	$a0, input_val
	jal 	integer_input  			# Nhap gia tri can set
	move 	$a3, $a0			# $a3 = gia tri can set
	move 	$a1, $s2			# $a1 = so thu tu hang
	move	$a2, $s3			# $a2 = so thu tu cot
	move 	$a0, $s1
	jal 	SetArray
	la 	$a0, set_success	
	li 	$v0, 4				# In ra thong bao set thanh cong va vi tri		
	syscall
	la 	$a0, left_bracket	
	li 	$v0, 4				
	syscall
	move 	$a0, $a1
	li 	$v0, 1				
	syscall
	la 	$a0, brackets	
	li 	$v0, 4				
	syscall
	move 	$a0, $a2
	li 	$v0, 1				
	syscall
	la	$a0, right_bracket	
	li 	$v0, 4				
	syscall
	j 	main

case8.2:					# Get[i][j]
	la 	$a0, TwoDArrayPtr
	lw 	$s1, 0($a0)
	beqz 	$s1, nullptr 			# if *ArrayPtr == 0 return error null pointer
	la 	$a0, input_row
	jal 	integer_input 			# Nhap vao hang
	move 	$s0, $a0			
	la 	$a0, input_col
	jal 	integer_input 			# Nhap vao cot
	move 	$a2, $a0			# $a2 = so cot
	move 	$a1, $s0			# $a1 = so hang
	move 	$a0, $s1			# $a0 = gia tri thanh ghi
	jal 	GetArray
	move 	$s0, $v0 			# $s0 = gia tri tra ve cua GetArray
	la 	$a0, output_val
	li 	$v0, 4
	syscall
	move    $a0, $s0
    		li  $v0, 1
    		syscall
	j 	main


	
	
#-------------------------------------------------------------------
# Ham khoi tao cho viec cap phat dong
# @param khong co
# @detail Danh dau vi tri bat dau cua vung nho co the cap phat duoc
#-------------------------------------------------------------------
SysInitMem:
	la 	$t9, Sys_TheTopOfFree 		# Lay con tro chua dau tien con trong, khoi tao
	la 	$t7, Sys_MyFreeSpace 		# Lay dia chi dau tien con trong, khoi tao
	sw 	$t7, 0($t9) 			# Luu lai
	jr 	$ra
	
#------------------------------------------------------------------------------
# Ham cap phat bo nho dong cho cac bien con tro
# @param [in/out] $a0 Chua dia chi cua bien con tro can cap phat
# Khi ham ket thuc, dia chi vung nho duoc cap phat se luu tru vao bien con tro
# @param [in] $a1 So phan tu can cap phat
# @param [in] $a2 Kich thuoc 1 phan tu, tinh theo byte
# @return $v0 Dia chi vung nho duoc cap phat
#------------------------------------------------------------------------------
malloc:
	la 	$t9, Sys_TheTopOfFree
	lw 	$t8, 0($t9) 			# Lay dia chi dau tien con trong		
	li	$t1, 4			 	# Do dai 1 word nho
	bne	$a2, $t1, continue		# Neu khong phai cap phat kieu WORD thi OK
	divu	$t8, $t1			# Kiem tra dia chi bat dau cap phat co chia het cho 4 khong
	mfhi	$t2				# Luu phan du (remainder) vao $t2
	beqz	$t2, continue			# So du = 0 -> Kich thuoc hop le
	sub	$t3, $t1, $t2			# So du != 0, can cap phat them (4-sodu) bits
	add	$t8, $t8, $t3 			# tang gia tri thanh ghi len so chia het cho 4
continue:
	sw 	$t8, 0($a0) 			# Cat dia chi do vao bien con tro
	addi 	$v0, $t8, 0 			# Dong thoi la ket qua tra ve cua ham
	mul 	$t7, $a1, $a2 			# Tinh kich thuoc cua mang can cap phat
	add 	$t6, $t8, $t7 			# Tinh dia chi dau tien con trong
	sw 	$t6, 0($t9) 			# Luu tro lai dia chi dau tien do vao bien Sys_TheTopOfFree
print_address:
	la	$a0, malloc_success		# Thong bao cap phat thanh cong
	li	$v0, 4			
	syscall
	la	$a0, address		
  	li	$v0, 4
  	syscall
  	addi	$a0, $t8, 0			# Malloc start address
	li 	$v0, 34				# In so integer ra man hinh duoi dang hexa
  	syscall
  	la	$a0, arrow			# In ra man hinh " --> "
  	li	$v0, 4
  	syscall
  	addi	$a0, $t6, 0			# Malloc end address
	li 	$v0, 34				# In so integer ra man hinh duoi dang hexa
  	syscall			
	jr 	$ra
#------------------------------------------
#  2 ham in ra dia chi va gia tri cua pointer
#  @detail   	ptr_val: in gia tri
#		ptr_add: in dia chi
#------------------------------------------
Ptr_val: 
  	lw 	$a0, 0($a0)			# Lay gia tri luu trong trong con tro
Ptr_add:
  	li 	$v0, 34				# In so integer ra man hinh duoi dang hexa
  	syscall
  	jr 	$ra 
#------------------------------------------
# Tinh tong luong bo nho da cap phat
# @param: none
# @return $v0 chua luong bo nho da cap phat
#------------------------------------------
MemoryCount:
	la 	$t9, Sys_TheTopOfFree
	lw 	$t9, 0($t9)			# $t9 = Gia tri tai dia chi con trong dau tien
	la 	$t8, Sys_MyFreeSpace		# Sys_MyFreeSpace luon co dinh la thanh ghi ngay sau Sys_TheTopOfFree
	sub 	$v0, $t9, $t8			# $v0 = luong bo nho da cap phat
	jr 	$ra	
#-------------------------------------------------------------------------------------------
# Ham cap phat bo nho dong cho mang 2 chieu
# Idea: Dua ve cap phat bo nho cho mang 1 chieu co ROW * COL phan tu, su dung lai ham malloc
# @param [in/out] $a0 Chua dia chi cua bien con tro can cap phat
# Khi ham ket thuc, dia chi vung nho duoc cap phat se luu tru vao bien con tro
# @param [in] $a1 so hang
# @param [in] $a2 so cot
# @return $v0 Dia chi vung nho duoc cap phat
#-------------------------------------------------------------------------------------------
Malloc2:
	addiu 	$sp, $sp, -4			# them 1 phan tu vao stack
	sw 	$ra, 4($sp) 			# push $ra
	mul 	$a1, $a1, $a2			# tra ve so phan tu cua Array
	li 	$a2, 4				# kich thuoc kieu Word = 4 bytes
	jal 	malloc
	lw 	$ra, 4($sp)
	addiu 	$sp, $sp, 4 			# pop $ra
	jr 	$ra
	
#--------------------------------------------------------
# gan gia tri cua phan tu trong mang hai chieu
# @param [in] $a0 Chua dia chi bat dau mang
# @param [in] $a1 hang (i)	# @param [in] $a2 cot (j)
# @param [in] $a3 gia tri gan
#--------------------------------------------------------
SetArray:
	bge 	$a1, $s4, bound_err 		# So hang vuot qua pham vi => error
	bge 	$a2, $s5, bound_err 		# So cot vuot qua pham vi => error
	bltz	$a1, bound_err			# So hang < 0 => error
	bltz	$a2, bound_err			# So cot < 0 => error
	mul 	$s0, $s5, $a1
	addu 	$s0, $s0, $a2 			# $s0 = i*col +j 
	sll 	$s0, $s0, 2
	addu 	$s0, $s0, $a0 			# $s0 = *array + (i*col +j)*4
	sw 	$a3, 0($s0)
	jr 	$ra
	
#------------------------------------------
# lay gia tri cua trong mang
# @param [in] $a0 Chua dia chi bat dau mang
# @param [in] $a1 hang (i)
# @param [in] $a2 cot (j)
# @return $v0 gia tri tai hang a1 cot a2 trong mang
#	------------------------------------------
GetArray:
	bge 	$a1, $s4, bound_err 		# So hang vuot qua pham vi => error
	bge 	$a2, $s5, bound_err 		# So cot hang qua pham vi => error
	bltz	$a1, bound_err			# So hang < 0 => error
	bltz	$a2, bound_err			# So cot < 0 => error
	mul 	$s0, $s5, $a1
	addu 	$s0, $s0, $a2 			# $s0= i*col +j  
	sll 	$s0, $s0, 2
	addu 	$s0, $s0, $a0 			# $s0 = *array + (i*col +j)*4
	lw 	$v0, 0($s0)
	jr 	$ra
	
integer_input:
	li 	$v0, 51
	syscall
	beq 	$a1, 0, end_input
	beq 	$a1, -2, end
	j 	integer_input
end_input:
	jr 	$ra
	

check_input:
	bge 	$a0, 2000, too_big	# Loi input >	2000
	beqz 	$a0, zero_err		# Loi input =   0
	bltz	$a0, negative_err	# Loi input <   0
	jr 	$ra
too_big:
	la    	$a0, overflow_error
	j 	error
zero_err:
	la 	$a0, zero_error
	j 	error
negative_err:	
	la 	$a0, negative_error
	j 	error
bound_err:				# Loi chi so vuot ngoai pham vi
	la 	$a0, bound_error
	j 	error
	
nullptr:				# Loi null
	la 	$a0, null_error
	j 	error
error:	
	li 	$v0, 4			# In ra thong bao loi
	syscall
	j 	main

end:
	li 	$v0, 10			# Ket thuc 
	syscall
	
