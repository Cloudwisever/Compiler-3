.data
_prompt: .asciiz "Enter an integer:"
_ret: .asciiz "\n"
.globl main
.text
read:
li $v0, 4
	la $a0, _prompt
	syscall
	li $v0, 5
	syscall
	jr $ra
write:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, _ret
	syscall
	move $v0, $0
	jr $ra
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -260
li $t0, 0
move $t1, $t0
label1:
move $t2, $t1
li $t3, 5
blt $t2, $t3, label2
j label3
label2:
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t4, $v0
move $t5, $t1
li $t6, 4
mul $t5, $t5, $t6
la $t7, -24($fp)
add $s0, $t7, $t5
move $s1, $s0
sw $t4, 0($s1)
move $s2, $t1
li $s3, 1
add $s4, $s2, $s3
move $t1, $s4
j label1
label3:
li $s5, 1
move $t1, $s5
label4:
move $s6, $t1
li $s7, 5
blt $s6, $s7, label5
j label6
label5:
move $t8, $t1
move $t9, $t8
label7:
sw $t8, -28($fp)
move $t8, $t9
sw $s7, -32($fp)
li $s7, 0
bgt $t8, $s7, label10
j label9
label10:
sw $s7, -36($fp)
move $s7, $t9
sw $t8, -40($fp)
li $t8, 1
sw $t8, -44($fp)
sub $t8, $s7, $t8
mul $t8, $t8, $t6
sw $s7, -48($fp)
add $s7, $t7, $t8
sw $s7, -52($fp)
lw $s7, 0($s7)
sw $s6, -56($fp)
move $s6, $t9
mul $s6, $s6, $t6
sw $s5, -60($fp)
add $s5, $t7, $s6
sw $s5, -64($fp)
lw $s5, 0($s5)
bgt $s7, $s5, label8
j label9
label8:
sw $s5, -68($fp)
move $s5, $t9
mul $s5, $s5, $t6
sw $s7, -72($fp)
add $s7, $t7, $s5
sw $s7, -76($fp)
lw $s7, 0($s7)
sw $s7, -80($fp)
move $s7, $s7
sw $s4, -84($fp)
move $s4, $t9
sw $s3, -88($fp)
li $s3, 1
sw $s3, -92($fp)
sub $s3, $s4, $s3
mul $s3, $s3, $t6
sw $s4, -96($fp)
add $s4, $t7, $s3
sw $s4, -100($fp)
lw $s4, 0($s4)
sw $s2, -104($fp)
move $s2, $t9
mul $s2, $s2, $t6
sw $s0, -108($fp)
add $s0, $t7, $s2
sw $s0, -112($fp)
move $s0, $s0
sw $s4, 0($s0)
sw $s4, -116($fp)
move $s4, $s7
sw $s7, -120($fp)
move $s7, $t9
sw $t4, -124($fp)
li $t4, 1
sw $t4, -128($fp)
sub $t4, $s7, $t4
mul $t4, $t4, $t6
sw $s7, -132($fp)
add $s7, $t7, $t4
sw $s7, -136($fp)
move $s7, $s7
sw $s4, 0($s7)
sw $s4, -140($fp)
move $s4, $t9
sw $t7, -0($fp)
li $t7, 1
sw $t7, -144($fp)
sub $t7, $s4, $t7
move $t9, $t7
j label7
label9:
sw $t7, -148($fp)
move $t7, $t1
sw $s4, -152($fp)
li $s4, 1
sw $s4, -156($fp)
add $s4, $t7, $s4
move $t1, $s4
j label4
label6:
sw $s4, -160($fp)
li $s4, 0
move $t1, $s4
label11:
sw $s4, -164($fp)
move $s4, $t1
sw $t7, -168($fp)
li $t7, 5
blt $s4, $t7, label12
j label13
label12:
sw $t7, -172($fp)
move $t7, $t1
mul $t7, $t7, $t6
la $t6, -24($fp)
add $t6, $t6, $t7
sw $t6, -176($fp)
lw $t6, 0($t6)
move $a0, $t6
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $s4, -180($fp)
move $s4, $t1
sw $t3, -184($fp)
li $t3, 1
sw $t3, -188($fp)
add $t3, $s4, $t3
move $t1, $t3
j label11
label13:
sw $t3, -192($fp)
li $t3, 0
move $v0, $t3
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
