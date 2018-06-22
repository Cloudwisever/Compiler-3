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
search:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -284
move $t0, $a0
addi $sp, $sp, -20
li $t1, 0
move $t2, $t1
sw $t0, -28($fp)
sw $t1, -32($fp)
sw $t2, -36($fp)
label1:
lw $t0, -36($fp)
move $t0, $t0
li $t1, 5
sw $t0, -40($fp)
sw $t1, -44($fp)
lw $t0, -40($fp)
lw $t1, -44($fp)
blt $t0, $t1, label2
j label3
label2:
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
lw $t1, -36($fp)
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
sw $t0, -48($fp)
sw $t2, -52($fp)
sw $t1, -36($fp)
sw $t3, -56($fp)
sw $t4, -60($fp)
sw $t5, -64($fp)
sw $t6, -68($fp)
sw $t7, -72($fp)
j label1
label3:
li $t0, 0
move $t1, $t0
li $t2, 4
move $t3, $t2
sw $t0, -76($fp)
sw $t1, -80($fp)
sw $t2, -84($fp)
sw $t3, -88($fp)
label4:
lw $t0, -80($fp)
move $t0, $t0
lw $t1, -88($fp)
move $t1, $t1
sw $t0, -92($fp)
sw $t1, -96($fp)
lw $t0, -92($fp)
lw $t1, -96($fp)
ble $t0, $t1, label5
j label6
label5:
lw $t0, -80($fp)
move $t0, $t0
lw $t1, -88($fp)
move $t1, $t1
add $t2, $t0, $t1
li $t3, 2
div $t2, $t3
mflo $t4
move $t5, $t4
move $t6, $t5
li $t7, 4
mul $t6, $t6, $t7
la $t7, -24($fp)
add $t7, $t7, $t6
lw $s0, 0($t7)
move $s1, $s0
move $s2, $s1
lw $s3, -28($fp)
move $s3, $s3
sw $t0, -100($fp)
sw $t1, -104($fp)
sw $t2, -108($fp)
sw $t3, -112($fp)
sw $t4, -116($fp)
sw $t5, -120($fp)
sw $t6, -124($fp)
sw $t7, -128($fp)
sw $s0, -132($fp)
sw $s1, -136($fp)
sw $s2, -140($fp)
sw $s3, -144($fp)
lw $t0, -140($fp)
lw $t1, -144($fp)
beq $t0, $t1, label7
j label8
label7:
lw $t0, -120($fp)
move $t0, $t0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -148($fp)
label8:
lw $t0, -136($fp)
move $t0, $t0
lw $t1, -80($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t2, -24($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
sw $t0, -152($fp)
sw $t1, -156($fp)
sw $t2, -160($fp)
sw $t3, -164($fp)
lw $t0, -152($fp)
lw $t1, -164($fp)
bgt $t0, $t1, label14
j label9
label14:
lw $t0, -28($fp)
move $t0, $t0
lw $t1, -80($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t2, -24($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
sw $t0, -168($fp)
sw $t1, -172($fp)
sw $t2, -176($fp)
sw $t3, -180($fp)
lw $t0, -168($fp)
lw $t1, -180($fp)
bge $t0, $t1, label13
j label9
label13:
lw $t0, -28($fp)
move $t0, $t0
lw $t1, -136($fp)
move $t1, $t1
sw $t0, -184($fp)
sw $t1, -188($fp)
lw $t0, -184($fp)
lw $t1, -188($fp)
blt $t0, $t1, label12
j label9
label12:
lw $t0, -136($fp)
move $t0, $t0
lw $t1, -80($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t2, -24($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
sw $t0, -192($fp)
sw $t1, -196($fp)
sw $t2, -200($fp)
sw $t3, -204($fp)
lw $t0, -192($fp)
lw $t1, -204($fp)
blt $t0, $t1, label15
j label9
label15:
lw $t0, -28($fp)
move $t0, $t0
lw $t1, -80($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t2, -24($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
sw $t0, -208($fp)
sw $t1, -212($fp)
sw $t2, -216($fp)
sw $t3, -220($fp)
lw $t0, -208($fp)
lw $t1, -220($fp)
bge $t0, $t1, label9
j label16
label16:
lw $t0, -28($fp)
move $t0, $t0
lw $t1, -136($fp)
move $t1, $t1
sw $t0, -224($fp)
sw $t1, -228($fp)
lw $t0, -224($fp)
lw $t1, -228($fp)
blt $t0, $t1, label9
j label10
label9:
lw $t0, -120($fp)
move $t0, $t0
li $t1, 1
sub $t2, $t0, $t1
move $t3, $t2
sw $t0, -232($fp)
sw $t1, -236($fp)
sw $t2, -240($fp)
sw $t3, -88($fp)
j label11
label10:
lw $t0, -120($fp)
move $t0, $t0
li $t1, 1
add $t2, $t0, $t1
move $t3, $t2
sw $t0, -244($fp)
sw $t1, -248($fp)
sw $t2, -252($fp)
sw $t3, -80($fp)
label11:
j label4
label6:
li $t0, 1
li $t1, 0
sub $t1, $t1, $t0
move $v0, $t1
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -256($fp)
sw $t1, -260($fp)
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -284
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
move $t2, $t1
move $a0, $t2
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal search
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
li $t1, 0
move $v0, $t1
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -20($fp)
sw $t1, -24($fp)
