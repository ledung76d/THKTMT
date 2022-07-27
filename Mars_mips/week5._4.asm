#Laboratory Exercise 5, Home Assignment 3
.data
	string: 	.space 	50
	Message1: 	.asciiz 	"Nhap xau: "
	Message2: 	.asciiz 	"Do dai xau la: "
.text
main:
get_string: 						# TODO
	li $v0, 54				
	la $a0, Message1				# Message1 = "Nhap xau"
	la $a1, string				# input String
	la $a2, 100
	syscall
get_length: 
	la $a0,string 				# $a0 = address(string[0])
	add $t0,$zero,$zero 			# $t0 = i = 0
check_char: 
	add $t1,$a0,$t0 				# $t1 = $a0 + $t0
							# = address(string[i])
	lb $t2, 0($t1)				# $t2 = string[i]
	beq $t2, $zero, end_of_str 		# is null char?
	addi $t0, $t0, 1 				# $t0 = $t0 + 1 -> i = i + 1
	j check_char
	
end_of_str:

end_of_get_length:
	addi $a1,$t0,-1				# a1 = length
print_length: 					# TODO
	li $v0, 56
	la $a0, Message2				#Message2 = "Do dai xau la:"
	add $a1, $a1, $zero 			# the interger to be printed 
	syscall			 		# execute
	
