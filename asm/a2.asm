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
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
sw $t3, -20($fp)
sw $t4, -24($fp)
sw $t5, -28($fp)
lw $t0, -24($fp)
lw $t1, -28($fp)
bgt $t0, $t1, label1
j label2
label1:
lw $t0, -20($fp)
move $t0, $t0
li $t1, 50
sw $t0, -32($fp)
sw $t1, -36($fp)
lw $t0, -32($fp)
lw $t1, -36($fp)
blt $t0, $t1, label4
j label5
label4:
lw $t0, -20($fp)
move $t0, $t0
lw $t1, -12($fp)
move $t1, $t1
add $t2, $t0, $t1
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t0, -40($fp)
sw $t1, -44($fp)
sw $t2, -48($fp)
j label6
label5:
lw $t0, -20($fp)
move $t0, $t0
lw $t1, -12($fp)
move $t1, $t1
sub $t2, $t0, $t1
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t0, -52($fp)
sw $t1, -56($fp)
sw $t2, -60($fp)
label6:
j label3
label2:
lw $t0, -12($fp)
move $t0, $t0
li $t1, 100
sw $t0, -64($fp)
sw $t1, -68($fp)
lw $t0, -64($fp)
lw $t1, -68($fp)
beq $t0, $t1, label7
j label8
label7:
lw $t0, -20($fp)
move $t0, $t0
li $t1, 100
sw $t0, -72($fp)
sw $t1, -76($fp)
lw $t0, -72($fp)
lw $t1, -76($fp)
blt $t0, $t1, label10
j label11
label10:
lw $t0, -20($fp)
move $t0, $t0
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t0, -80($fp)
j label12
label11:
lw $t0, -20($fp)
move $t0, $t0
li $t1, 100
sub $t2, $t0, $t1
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t0, -84($fp)
sw $t1, -88($fp)
sw $t2, -92($fp)
label12:
j label9
label8:
lw $t0, -12($fp)
move $t0, $t0
li $t1, 100
sw $t0, -96($fp)
sw $t1, -100($fp)
lw $t0, -96($fp)
lw $t1, -100($fp)
blt $t0, $t1, label13
j label14
label13:
lw $t0, -20($fp)
move $t0, $t0
lw $t1, -12($fp)
move $t1, $t1
add $t2, $t0, $t1
li $t3, 100
sw $t0, -104($fp)
sw $t1, -108($fp)
sw $t2, -112($fp)
sw $t3, -116($fp)
lw $t0, -112($fp)
lw $t1, -116($fp)
bgt $t0, $t1, label15
j label16
label15:
lw $t0, -12($fp)
move $t0, $t0
li $t1, 100
add $t2, $t0, $t1
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t0, -120($fp)
sw $t1, -124($fp)
sw $t2, -128($fp)
j label17
label16:
li $t0, 100
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t0, -132($fp)
label17:
label14:
label9:
label3:
lw $t0, -12($fp)
move $t0, $t0
lw $t1, -20($fp)
move $t1, $t1
add $t2, $t0, $t1
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
li $t3, 0
move $v0, $t3
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -136($fp)
sw $t1, -140($fp)
sw $t2, -144($fp)
sw $t3, -148($fp)
