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
li $t0, 3
move $t0, $t0
li $t1, 12
move $t1, $t1
move $t2, $t1
move $t3, $t1
mul $t2, $t2, $t3
li $t3, 13
add $t2, $t2, $t3
move $t2, $t2
move $t3, $t2
li $t4, 13
div $t3, $t4
mflo $t3
li $t4, 1
add $t3, $t3, $t4
move $t3, $t3
move $t4, $t1
move $t5, $t2
div $t4, $t5
mflo $t4
move $t5, $t2
move $t6, $t3
mul $t5, $t5, $t6
add $t4, $t4, $t5
move $t4, $t4
move $t5, $t4
move $a0, $t5
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t5, $t0
move $t4, $t4
li $t6, 2
mul $t4, $t4, $t6
add $t4, $t5, $t4
move $t4, $t4
move $t5, $t4
move $a0, $t5
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t5, $t1
move $t2, $t2
add $t2, $t5, $t2
move $t3, $t3
add $t2, $t2, $t3
move $t1, $t1
move $t3, $t4
div $t1, $t3
mflo $t1
add $t1, $t2, $t1
move $t2, $t0
add $t1, $t1, $t2
move $t0, $t1
move $t0, $t0
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
li $t0, 0
move $v0, $t0
jr $ra
