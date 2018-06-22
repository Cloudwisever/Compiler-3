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
addi $sp, $sp, -20
li $t0, 0
move $t1, $t0
sw $t0, -28($fp)
sw $t1, -32($fp)
label1:
lw $t0, -32($fp)
move $t0, $t0
li $t1, 5
sw $t0, -36($fp)
sw $t1, -40($fp)
lw $t0, -36($fp)
lw $t1, -40($fp)
blt $t0, $t1, label2
j label3
label2:
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
lw $t1, -32($fp)
move $t2, $t1
li $t3, 4
mul $t2, $t2, $t3
la $t3, -24($fp)
add $t3, $t3, $t2
move $t4, $t3
sw $t0, 0($t4)
move $t5, $t1
li $t6, 1
add $t7, $t5, $t6
move $t1, $t7
sw $t0, -44($fp)
sw $t2, -48($fp)
sw $t1, -32($fp)
sw $t3, -52($fp)
sw $t4, -56($fp)
sw $t5, -60($fp)
sw $t6, -64($fp)
sw $t7, -68($fp)
j label1
label3:
li $t0, 1
move $t1, $t0
sw $t0, -72($fp)
sw $t1, -32($fp)
label4:
lw $t0, -32($fp)
move $t0, $t0
li $t1, 5
sw $t0, -76($fp)
sw $t1, -80($fp)
lw $t0, -76($fp)
lw $t1, -80($fp)
blt $t0, $t1, label5
j label6
label5:
lw $t0, -32($fp)
move $t0, $t0
move $t1, $t0
sw $t0, -84($fp)
sw $t1, -88($fp)
label7:
lw $t0, -88($fp)
move $t0, $t0
li $t1, 0
sw $t0, -92($fp)
sw $t1, -96($fp)
lw $t0, -92($fp)
lw $t1, -96($fp)
bgt $t0, $t1, label10
j label9
label10:
lw $t0, -88($fp)
move $t1, $t0
li $t2, 1
sub $t3, $t1, $t2
li $t4, 4
mul $t3, $t3, $t4
la $t5, -24($fp)
add $t6, $t5, $t3
lw $t7, 0($t6)
move $t0, $t0
mul $t0, $t0, $t4
add $t4, $t5, $t0
lw $t5, 0($t4)
sw $t1, -100($fp)
sw $t2, -104($fp)
sw $t3, -108($fp)
sw $t6, -112($fp)
sw $t7, -116($fp)
sw $t0, -120($fp)
sw $t4, -124($fp)
sw $t5, -128($fp)
lw $t0, -116($fp)
lw $t1, -128($fp)
bgt $t0, $t1, label8
j label9
label8:
lw $t0, -88($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t3, -24($fp)
add $t4, $t3, $t1
lw $t5, 0($t4)
move $t6, $t5
move $t7, $t0
li $s0, 1
sub $s1, $t7, $s0
mul $s1, $s1, $t2
add $s2, $t3, $s1
lw $s3, 0($s2)
move $s4, $t0
mul $s4, $s4, $t2
add $s5, $t3, $s4
move $s6, $s5
sw $s3, 0($s6)
move $s7, $t6
move $t8, $t0
li $t9, 1
sw $t9, -132($fp)
sub $t9, $t8, $t9
mul $t9, $t9, $t2
add $t2, $t3, $t9
move $t3, $t2
sw $s7, 0($t3)
sw $t2, -136($fp)
move $t2, $t0
sw $t8, -140($fp)
li $t8, 1
sw $t8, -144($fp)
sub $t8, $t2, $t8
move $t0, $t8
sw $t1, -148($fp)
sw $t0, -88($fp)
sw $t4, -152($fp)
sw $t5, -156($fp)
sw $t6, -160($fp)
sw $t7, -164($fp)
sw $s0, -168($fp)
sw $s1, -172($fp)
sw $s2, -176($fp)
sw $s3, -180($fp)
sw $s4, -184($fp)
sw $s5, -188($fp)
sw $s6, -192($fp)
sw $s7, -196($fp)
sw $t9, -200($fp)
sw $t3, -204($fp)
sw $t2, -208($fp)
sw $t8, -212($fp)
j label7
label9:
lw $t0, -32($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -216($fp)
sw $t0, -32($fp)
sw $t2, -220($fp)
sw $t3, -224($fp)
j label4
label6:
li $t0, 0
move $t1, $t0
sw $t0, -228($fp)
sw $t1, -32($fp)
label11:
lw $t0, -32($fp)
move $t0, $t0
li $t1, 5
sw $t0, -232($fp)
sw $t1, -236($fp)
lw $t0, -232($fp)
lw $t1, -236($fp)
blt $t0, $t1, label12
j label13
label12:
lw $t0, -32($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t2, -24($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
move $a0, $t3
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t4, $t0
li $t5, 1
add $t6, $t4, $t5
move $t0, $t6
sw $t1, -240($fp)
sw $t0, -32($fp)
sw $t2, -244($fp)
sw $t3, -248($fp)
sw $t4, -252($fp)
sw $t5, -256($fp)
sw $t6, -260($fp)
j label11
label13:
li $t0, 0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -264($fp)
