.data
Message: .asciiz "Nhap so nguyen:”
.text
 li $v0, 51
 la $a0, Message
 syscall 
 addi $t1,  $a0, 2