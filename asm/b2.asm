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
countSort:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -648
addi $sp, $sp, -20
addi $sp, $sp, -40
addi $sp, $sp, -20
li $t0, 0
move $t1, $t0
sw $t0, -88($fp)
sw $t1, -92($fp)
label1:
lw $t0, -92($fp)
move $t0, $t0
li $t1, 10
sw $t0, -96($fp)
sw $t1, -100($fp)
lw $t0, -96($fp)
lw $t1, -100($fp)
blt $t0, $t1, label2
j label3
label2:
li $t0, 0
lw $t1, -92($fp)
move $t2, $t1
li $t3, 4
mul $t2, $t2, $t3
la $t3, -64($fp)
add $t3, $t3, $t2
move $t4, $t3
sw $t0, 0($t4)
move $t5, $t1
li $t6, 1
add $t7, $t5, $t6
move $t1, $t7
sw $t0, -104($fp)
sw $t2, -108($fp)
sw $t1, -92($fp)
sw $t3, -112($fp)
sw $t4, -116($fp)
sw $t5, -120($fp)
sw $t6, -124($fp)
sw $t7, -128($fp)
j label1
label3:
li $t0, 0
move $t1, $t0
sw $t0, -132($fp)
sw $t1, -92($fp)
label4:
lw $t0, -92($fp)
move $t0, $t0
li $t1, 5
sw $t0, -136($fp)
sw $t1, -140($fp)
lw $t0, -136($fp)
lw $t1, -140($fp)
blt $t0, $t1, label5
j label6
label5:
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
lw $t1, -92($fp)
move $t2, $t1
li $t3, 4
mul $t2, $t2, $t3
la $t4, -24($fp)
add $t5, $t4, $t2
move $t6, $t5
sw $t0, 0($t6)
move $t7, $t1
mul $t7, $t7, $t3
add $s0, $t4, $t7
lw $s1, 0($s0)
mul $s1, $s1, $t3
la $s2, -64($fp)
add $s3, $s2, $s1
lw $s4, 0($s3)
li $s5, 1
add $s6, $s4, $s5
move $s7, $t1
mul $s7, $s7, $t3
add $t4, $t4, $s7
lw $t8, 0($t4)
mul $t8, $t8, $t3
add $t3, $s2, $t8
move $s2, $t3
sw $s6, 0($s2)
move $t9, $t1
sw $t3, -144($fp)
li $t3, 1
sw $t3, -148($fp)
add $t3, $t9, $t3
move $t1, $t3
sw $t0, -152($fp)
sw $t2, -156($fp)
sw $t1, -92($fp)
sw $t5, -160($fp)
sw $t6, -164($fp)
sw $t7, -168($fp)
sw $s0, -172($fp)
sw $s1, -176($fp)
sw $s3, -180($fp)
sw $s4, -184($fp)
sw $s5, -188($fp)
sw $s6, -192($fp)
sw $s7, -196($fp)
sw $t4, -200($fp)
sw $t8, -204($fp)
sw $s2, -208($fp)
sw $t9, -212($fp)
sw $t3, -216($fp)
j label4
label6:
li $t0, 1
move $t1, $t0
sw $t0, -220($fp)
sw $t1, -92($fp)
label7:
lw $t0, -92($fp)
move $t0, $t0
li $t1, 10
sw $t0, -224($fp)
sw $t1, -228($fp)
lw $t0, -224($fp)
lw $t1, -228($fp)
blt $t0, $t1, label8
j label9
label8:
lw $t0, -92($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t3, -64($fp)
add $t4, $t3, $t1
lw $t5, 0($t4)
move $t6, $t0
li $t7, 1
sub $s0, $t6, $t7
mul $s0, $s0, $t2
add $s1, $t3, $s0
lw $s2, 0($s1)
add $s3, $t5, $s2
move $s4, $t0
mul $s4, $s4, $t2
add $t2, $t3, $s4
move $t3, $t2
sw $s3, 0($t3)
move $s5, $t0
li $s6, 1
add $s7, $s5, $s6
move $t0, $s7
sw $t1, -232($fp)
sw $t0, -92($fp)
sw $t4, -236($fp)
sw $t5, -240($fp)
sw $t6, -244($fp)
sw $t7, -248($fp)
sw $s0, -252($fp)
sw $s1, -256($fp)
sw $s2, -260($fp)
sw $s3, -264($fp)
sw $s4, -268($fp)
sw $t2, -272($fp)
sw $t3, -276($fp)
sw $s5, -280($fp)
sw $s6, -284($fp)
sw $s7, -288($fp)
j label7
label9:
li $t0, 0
move $t1, $t0
sw $t0, -292($fp)
sw $t1, -92($fp)
label10:
lw $t0, -92($fp)
move $t0, $t0
li $t1, 5
sw $t0, -296($fp)
sw $t1, -300($fp)
lw $t0, -296($fp)
lw $t1, -300($fp)
blt $t0, $t1, label11
j label12
label11:
lw $t0, -92($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t3, -24($fp)
add $t4, $t3, $t1
lw $t5, 0($t4)
move $t6, $t0
mul $t6, $t6, $t2
add $t7, $t3, $t6
lw $s0, 0($t7)
mul $s0, $s0, $t2
la $s1, -64($fp)
add $s2, $s1, $s0
lw $s3, 0($s2)
li $s4, 1
sub $s5, $s3, $s4
mul $s5, $s5, $t2
la $s6, -84($fp)
add $s6, $s6, $s5
move $s7, $s6
sw $t5, 0($s7)
move $t8, $t0
mul $t8, $t8, $t2
add $t9, $t3, $t8
sw $t9, -304($fp)
lw $t9, 0($t9)
mul $t9, $t9, $t2
sw $s6, -308($fp)
add $s6, $s1, $t9
sw $s6, -312($fp)
lw $s6, 0($s6)
sw $s4, -316($fp)
li $s4, 1
sw $s4, -320($fp)
sub $s4, $s6, $s4
sw $s6, -324($fp)
move $s6, $t0
mul $s6, $s6, $t2
add $t3, $t3, $s6
sw $t3, -328($fp)
lw $t3, 0($t3)
mul $t3, $t3, $t2
add $t2, $s1, $t3
move $s1, $t2
sw $s4, 0($s1)
sw $t2, -332($fp)
move $t2, $t0
sw $s4, -336($fp)
li $s4, 1
sw $s4, -340($fp)
add $s4, $t2, $s4
move $t0, $s4
sw $t1, -344($fp)
sw $t0, -92($fp)
sw $t4, -348($fp)
sw $t5, -352($fp)
sw $t6, -356($fp)
sw $t7, -360($fp)
sw $s0, -364($fp)
sw $s2, -368($fp)
sw $s3, -372($fp)
sw $s5, -376($fp)
sw $s7, -380($fp)
sw $t8, -384($fp)
sw $t9, -388($fp)
sw $s6, -392($fp)
sw $t3, -396($fp)
sw $s1, -400($fp)
sw $t2, -404($fp)
sw $s4, -408($fp)
j label10
label12:
li $t0, 0
move $t1, $t0
sw $t0, -412($fp)
sw $t1, -92($fp)
label13:
lw $t0, -92($fp)
move $t0, $t0
li $t1, 5
sw $t0, -416($fp)
sw $t1, -420($fp)
lw $t0, -416($fp)
lw $t1, -420($fp)
blt $t0, $t1, label14
j label15
label14:
lw $t0, -92($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t2, -84($fp)
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
sw $t1, -424($fp)
sw $t0, -92($fp)
sw $t2, -428($fp)
sw $t3, -432($fp)
sw $t4, -436($fp)
sw $t5, -440($fp)
sw $t6, -444($fp)
j label13
label15:
li $t0, 0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -448($fp)
bubbleSort:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -648
addi $sp, $sp, -20
li $t0, 0
move $t1, $t0
sw $t0, -28($fp)
sw $t1, -32($fp)
label16:
lw $t0, -32($fp)
move $t0, $t0
li $t1, 5
sw $t0, -36($fp)
sw $t1, -40($fp)
lw $t0, -36($fp)
lw $t1, -40($fp)
blt $t0, $t1, label17
j label18
label17:
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
j label16
label18:
li $t0, 1
move $t1, $t0
sw $t0, -72($fp)
sw $t1, -76($fp)
label19:
lw $t0, -76($fp)
move $t0, $t0
li $t1, 1
sw $t0, -80($fp)
sw $t1, -84($fp)
lw $t0, -80($fp)
lw $t1, -84($fp)
beq $t0, $t1, label20
j label21
label20:
li $t0, 0
move $t1, $t0
li $t2, 1
move $t3, $t2
sw $t0, -88($fp)
sw $t1, -76($fp)
sw $t2, -92($fp)
sw $t3, -32($fp)
label22:
lw $t0, -32($fp)
move $t0, $t0
li $t1, 5
sw $t0, -96($fp)
sw $t1, -100($fp)
lw $t0, -96($fp)
lw $t1, -100($fp)
blt $t0, $t1, label23
j label24
label23:
lw $t0, -32($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t3, -24($fp)
add $t4, $t3, $t1
lw $t5, 0($t4)
move $t0, $t0
li $t6, 1
sub $t7, $t0, $t6
mul $t7, $t7, $t2
add $t2, $t3, $t7
lw $t3, 0($t2)
sw $t1, -104($fp)
sw $t4, -108($fp)
sw $t5, -112($fp)
sw $t0, -116($fp)
sw $t6, -120($fp)
sw $t7, -124($fp)
sw $t2, -128($fp)
sw $t3, -132($fp)
lw $t0, -112($fp)
lw $t1, -132($fp)
blt $t0, $t1, label25
j label26
label25:
li $t0, 1
move $t1, $t0
lw $t2, -32($fp)
move $t3, $t2
li $t4, 1
sub $t5, $t3, $t4
li $t6, 4
mul $t5, $t5, $t6
la $t7, -24($fp)
add $s0, $t7, $t5
lw $s1, 0($s0)
move $s2, $s1
move $s3, $t2
mul $s3, $s3, $t6
add $s4, $t7, $s3
lw $s5, 0($s4)
move $s6, $t2
li $s7, 1
sub $t8, $s6, $s7
mul $t8, $t8, $t6
add $t9, $t7, $t8
sw $t9, -136($fp)
move $t9, $t9
sw $s5, 0($t9)
sw $s7, -140($fp)
move $s7, $s2
move $t2, $t2
mul $t2, $t2, $t6
add $t6, $t7, $t2
move $t7, $t6
sw $s7, 0($t7)
sw $t0, -144($fp)
sw $t1, -76($fp)
sw $t3, -148($fp)
sw $t4, -152($fp)
sw $t5, -156($fp)
sw $s0, -160($fp)
sw $s1, -164($fp)
sw $s2, -168($fp)
sw $s3, -172($fp)
sw $s4, -176($fp)
sw $s5, -180($fp)
sw $s6, -184($fp)
sw $t8, -188($fp)
sw $t9, -192($fp)
sw $s7, -196($fp)
sw $t2, -200($fp)
sw $t6, -204($fp)
sw $t7, -208($fp)
label26:
lw $t0, -32($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -212($fp)
sw $t0, -32($fp)
sw $t2, -216($fp)
sw $t3, -220($fp)
j label22
label24:
j label19
label21:
li $t0, 0
move $t1, $t0
sw $t0, -224($fp)
sw $t1, -32($fp)
label27:
lw $t0, -32($fp)
move $t0, $t0
li $t1, 5
sw $t0, -228($fp)
sw $t1, -232($fp)
lw $t0, -228($fp)
lw $t1, -232($fp)
blt $t0, $t1, label28
j label29
label28:
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
sw $t1, -236($fp)
sw $t0, -32($fp)
sw $t2, -240($fp)
sw $t3, -244($fp)
sw $t4, -248($fp)
sw $t5, -252($fp)
sw $t6, -256($fp)
j label27
label29:
li $t0, 0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -260($fp)
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -648
addi $sp, $sp, -4
sw $ra, 0($sp)
jal countSort
lw $ra, 0($sp)
addi $sp, $sp, 4
addi $sp, $sp, -4
sw $ra, 0($sp)
jal bubbleSort
lw $ra, 0($sp)
addi $sp, $sp, 4
li $t0, 0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -8($fp)
