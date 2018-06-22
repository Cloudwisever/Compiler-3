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
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
sw $t3, -20($fp)
sw $t4, -24($fp)
sw $t5, -28($fp)
sw $t6, -32($fp)
sw $t7, -36($fp)
sw $s0, -40($fp)
sw $s1, -44($fp)
lw $t0, -24($fp)
lw $t1, -44($fp)
beq $t0, $t1, label1
j label2
label1:
li $t0, 1
move $t1, $t0
sw $t0, -48($fp)
sw $t1, -52($fp)
j label3
label2:
lw $t0, -12($fp)
move $t0, $t0
move $t1, $t0
sw $t0, -56($fp)
sw $t1, -52($fp)
label3:
lw $t0, -20($fp)
move $t1, $t0
li $t2, 2
div $t1, $t2
mflo $t3
move $t0, $t3
sw $t1, -60($fp)
sw $t0, -20($fp)
sw $t2, -64($fp)
sw $t3, -68($fp)
label4:
lw $t0, -20($fp)
move $t0, $t0
li $t1, 0
sw $t0, -72($fp)
sw $t1, -76($fp)
lw $t0, -72($fp)
lw $t1, -76($fp)
bgt $t0, $t1, label5
j label6
label5:
lw $t0, -12($fp)
move $t1, $t0
move $t2, $t0
mul $t3, $t1, $t2
move $t0, $t3
lw $t4, -20($fp)
move $t5, $t4
move $t4, $t4
li $t6, 2
div $t4, $t6
mflo $t7
li $s0, 2
mul $s1, $t7, $s0
sw $t1, -80($fp)
sw $t0, -12($fp)
sw $t2, -84($fp)
sw $t3, -88($fp)
sw $t5, -92($fp)
sw $t4, -96($fp)
sw $t6, -100($fp)
sw $t7, -104($fp)
sw $s0, -108($fp)
sw $s1, -112($fp)
lw $t0, -92($fp)
lw $t1, -112($fp)
bne $t0, $t1, label7
j label8
label7:
lw $t0, -52($fp)
move $t1, $t0
lw $t2, -12($fp)
move $t2, $t2
mul $t3, $t1, $t2
move $t0, $t3
sw $t1, -116($fp)
sw $t0, -52($fp)
sw $t2, -120($fp)
sw $t3, -124($fp)
label8:
lw $t0, -20($fp)
move $t1, $t0
li $t2, 2
div $t1, $t2
mflo $t3
move $t0, $t3
sw $t1, -128($fp)
sw $t0, -20($fp)
sw $t2, -132($fp)
sw $t3, -136($fp)
j label4
label6:
lw $t0, -52($fp)
move $t0, $t0
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
sw $t0, -140($fp)
sw $t1, -144($fp)
