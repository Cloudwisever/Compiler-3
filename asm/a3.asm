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
addi $sp, $sp, -152
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
move $t4, $t3
move $t5, $t3
li $t6, 2
div $t5, $t6
mflo $t7
li $s0, 2
mul $s1, $t7, $s0
beq $t4, $s1, label1
j label2
label1:
li $s2, 1
move $s3, $s2
j label3
label2:
move $s4, $t1
move $s3, $s4
label3:
move $s5, $t3
li $s6, 2
div $s5, $s6
mflo $s7
move $t3, $s7
label4:
move $t8, $t3
li $t9, 0
bgt $t8, $t9, label5
j label6
label5:
sw $t9, -8($fp)
move $t9, $t1
sw $t8, -12($fp)
move $t8, $t1
sw $t8, -16($fp)
mul $t8, $t9, $t8
move $t1, $t8
sw $t8, -20($fp)
move $t8, $t3
sw $t9, -24($fp)
move $t9, $t3
sw $s7, -28($fp)
li $s7, 2
sw $s7, -32($fp)
div $t9, $s7
mflo $s7
sw $t9, -36($fp)
li $t9, 2
sw $t9, -40($fp)
mul $t9, $s7, $t9
bne $t8, $t9, label7
j label8
label7:
sw $t9, -44($fp)
move $t9, $s3
sw $s7, -48($fp)
move $s7, $t1
sw $s7, -52($fp)
mul $s7, $t9, $s7
move $s3, $s7
label8:
sw $s7, -56($fp)
move $s7, $t3
sw $t9, -60($fp)
li $t9, 2
sw $t9, -64($fp)
div $s7, $t9
mflo $t9
move $t3, $t9
j label4
label6:
sw $t9, -68($fp)
move $t9, $s3
move $a0, $t9
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $s7, -72($fp)
li $s7, 0
move $v0, $s7
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
