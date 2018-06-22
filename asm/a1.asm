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
addi $sp, $sp, -204
li $t0, 3
move $t1, $t0
li $t2, 12
move $t3, $t2
move $t4, $t3
move $t5, $t3
mul $t6, $t4, $t5
li $t7, 13
add $s0, $t6, $t7
move $s1, $s0
move $s2, $s1
li $s3, 13
div $s2, $s3
mflo $s4
li $s5, 1
add $s6, $s4, $s5
move $s7, $s6
move $t8, $t3
move $t9, $s1
sw $t9, -8($fp)
div $t8, $t9
mflo $t9
sw $t8, -12($fp)
move $t8, $s1
sw $s6, -16($fp)
move $s6, $s7
sw $s6, -20($fp)
mul $s6, $t8, $s6
sw $s6, -24($fp)
add $s6, $t9, $s6
sw $s6, -28($fp)
move $s6, $s6
sw $t8, -32($fp)
move $t8, $s6
move $a0, $t8
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t9, -36($fp)
move $t9, $t1
sw $s6, -40($fp)
move $s6, $s6
sw $s5, -44($fp)
li $s5, 2
sw $s5, -48($fp)
mul $s5, $s6, $s5
sw $s5, -52($fp)
add $s5, $t9, $s5
sw $s5, -56($fp)
move $s5, $s5
sw $s6, -60($fp)
move $s6, $s5
move $a0, $s6
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $t9, -64($fp)
move $t9, $t3
sw $s4, -68($fp)
move $s4, $s1
sw $s4, -72($fp)
add $s4, $t9, $s4
sw $t9, -76($fp)
move $t9, $s7
sw $t9, -80($fp)
add $t9, $s4, $t9
sw $s4, -84($fp)
move $s4, $t3
sw $s5, -88($fp)
move $s5, $s5
sw $s5, -92($fp)
div $s4, $s5
mflo $s5
sw $s5, -96($fp)
add $s5, $t9, $s5
sw $s4, -100($fp)
move $s4, $t1
sw $s4, -104($fp)
add $s4, $s5, $s4
move $t1, $s4
sw $s4, -108($fp)
move $s4, $t1
move $a0, $s4
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $s5, -112($fp)
li $s5, 0
move $v0, $s5
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -116($fp)
sw $t1, -120($fp)
sw $t2, -124($fp)
sw $t3, -128($fp)
sw $t4, -132($fp)
sw $t5, -136($fp)
sw $t6, -140($fp)
sw $t7, -144($fp)
sw $s0, -148($fp)
sw $s1, -152($fp)
sw $s2, -156($fp)
sw $s3, -160($fp)
sw $s7, -164($fp)
sw $t8, -168($fp)
sw $s6, -172($fp)
sw $t9, -176($fp)
sw $s4, -180($fp)
sw $s5, -184($fp)
