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
addi $sp, $sp, -156
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t2, $v0
move $t3, $t2
move $t4, $t1
li $t5, 100
bgt $t4, $t5, label1
j label2
label1:
move $t6, $t3
li $t7, 50
blt $t6, $t7, label4
j label5
label4:
move $s0, $t3
move $s1, $t1
add $s2, $s0, $s1
move $a0, $s2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
j label6
label5:
move $s3, $t3
move $s4, $t1
sub $s5, $s3, $s4
move $a0, $s5
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
label6:
j label3
label2:
move $s6, $t1
li $s7, 100
beq $s6, $s7, label7
j label8
label7:
move $t8, $t3
li $t9, 100
blt $t8, $t9, label10
j label11
label10:
sw $t9, -8($fp)
move $t9, $t3
move $a0, $t9
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
j label12
label11:
sw $t8, -12($fp)
move $t8, $t3
sw $s7, -16($fp)
li $s7, 100
sw $s7, -20($fp)
sub $s7, $t8, $s7
move $a0, $s7
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
label12:
j label9
label8:
sw $t8, -24($fp)
move $t8, $t1
sw $s6, -28($fp)
li $s6, 100
blt $t8, $s6, label13
j label14
label13:
sw $s6, -32($fp)
move $s6, $t3
sw $t8, -36($fp)
move $t8, $t1
sw $t8, -40($fp)
add $t8, $s6, $t8
sw $s6, -44($fp)
li $s6, 100
bgt $t8, $s6, label15
j label16
label15:
sw $s6, -48($fp)
move $s6, $t1
sw $t8, -52($fp)
li $t8, 100
sw $t8, -56($fp)
add $t8, $s6, $t8
move $a0, $t8
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
j label17
label16:
sw $s6, -60($fp)
li $s6, 100
move $a0, $s6
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
label17:
label14:
label9:
label3:
sw $s4, -64($fp)
move $s4, $t1
sw $s3, -68($fp)
move $s3, $t3
sw $s3, -72($fp)
add $s3, $s4, $s3
move $a0, $s3
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $s4, -76($fp)
li $s4, 0
move $v0, $s4
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
