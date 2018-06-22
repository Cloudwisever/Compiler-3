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
swap:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -148
move $t0, $a0
move $t1, $a1
move $t2, $t0
move $t3, $t2
move $t4, $t1
move $t0, $t4
move $t5, $t3
move $t1, $t5
move $t6, $t0
move $a0, $t6
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t7, $t1
move $a0, $t7
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $s0, $t0
move $v0, $s0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
sw $t3, -20($fp)
sw $t4, -24($fp)
sw $t5, -28($fp)
sw $t6, -32($fp)
sw $t7, -36($fp)
sw $s0, -40($fp)
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -148
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
move $t1, $t1
li $t5, 0
sw $t0, -44($fp)
sw $t2, -48($fp)
sw $t3, -52($fp)
sw $t4, -56($fp)
sw $t1, -60($fp)
sw $t5, -64($fp)
lw $t0, -60($fp)
lw $t1, -64($fp)
bgt $t0, $t1, label4
j label5
label4:
lw $t0, -32($fp)
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
move $a1, $t5
move $a0, $t7
sw $t1, -68($fp)
sw $t2, -72($fp)
sw $t3, -76($fp)
sw $t6, -80($fp)
sw $t7, -84($fp)
sw $t0, -88($fp)
sw $t4, -92($fp)
sw $t5, -96($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal swap
lw $ra, 0($sp)
addi $sp, $sp, 4
label5:
lw $t0, -32($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -100($fp)
sw $t0, -32($fp)
sw $t2, -104($fp)
sw $t3, -108($fp)
j label1
label3:
li $t0, 0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -112($fp)
