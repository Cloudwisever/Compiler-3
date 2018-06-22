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
myPow:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -196
move $t0, $a0
move $t1, $a1
move $t2, $t1
li $t3, 0
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
sw $t3, -20($fp)
lw $t0, -16($fp)
lw $t1, -20($fp)
beq $t0, $t1, label1
j label2
label1:
li $t0, 1
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -24($fp)
label2:
lw $t0, -12($fp)
move $t0, $t0
li $t1, 1
sw $t0, -28($fp)
sw $t1, -32($fp)
lw $t0, -28($fp)
lw $t1, -32($fp)
beq $t0, $t1, label3
j label4
label3:
lw $t0, -8($fp)
move $t0, $t0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -36($fp)
label4:
lw $t0, -12($fp)
move $t0, $t0
li $t1, 2
sw $t0, -40($fp)
sw $t1, -44($fp)
lw $t0, -40($fp)
lw $t1, -44($fp)
beq $t0, $t1, label5
j label6
label5:
lw $t0, -8($fp)
move $t1, $t0
move $t0, $t0
mul $t2, $t1, $t0
move $v0, $t2
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t1, -48($fp)
sw $t0, -52($fp)
sw $t2, -56($fp)
label6:
lw $t0, -12($fp)
move $t1, $t0
move $t0, $t0
li $t2, 2
div $t0, $t2
mflo $t3
li $t4, 2
mul $t5, $t3, $t4
sw $t1, -60($fp)
sw $t0, -64($fp)
sw $t2, -68($fp)
sw $t3, -72($fp)
sw $t4, -76($fp)
sw $t5, -80($fp)
lw $t0, -60($fp)
lw $t1, -80($fp)
beq $t0, $t1, label7
j label8
label7:
lw $t0, -8($fp)
move $t0, $t0
lw $t1, -12($fp)
move $t1, $t1
li $t2, 2
div $t1, $t2
mflo $t3
move $a1, $t3
move $a0, $t0
sw $t0, -84($fp)
sw $t1, -88($fp)
sw $t2, -92($fp)
sw $t3, -96($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal myPow
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
li $t1, 2
move $a1, $t1
move $a0, $t0
sw $t0, -100($fp)
sw $t1, -104($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal myPow
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -108($fp)
j label9
label8:
lw $t0, -8($fp)
move $t1, $t0
lw $t2, -12($fp)
move $t2, $t2
li $t3, 2
div $t2, $t3
mflo $t4
move $a1, $t4
move $a0, $t1
sw $t1, -112($fp)
sw $t0, -8($fp)
sw $t2, -116($fp)
sw $t3, -120($fp)
sw $t4, -124($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal myPow
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
li $t1, 2
move $a1, $t1
move $a0, $t0
sw $t0, -128($fp)
sw $t1, -132($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal myPow
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
lw $t2, -8($fp)
move $t2, $t2
move $t3, $t1
mul $t4, $t2, $t3
move $v0, $t4
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -136($fp)
sw $t1, -140($fp)
sw $t2, -144($fp)
sw $t3, -148($fp)
sw $t4, -152($fp)
label9:
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -196
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
move $t5, $t3
move $a1, $t5
move $a0, $t4
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
sw $t3, -20($fp)
sw $t4, -24($fp)
sw $t5, -28($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal myPow
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
sw $t0, -32($fp)
sw $t1, -36($fp)
